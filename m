Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTLERic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTLERhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:37:36 -0500
Received: from linux.us.dell.com ([143.166.224.162]:61339 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264260AbTLERgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:36:55 -0500
Date: Fri, 5 Dec 2003 11:36:19 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Meelis Roos <mroos@linux.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-bk bogus edd changeset - Re: 2.4.23 compile error in edd
Message-ID: <20031205113619.A20371@lists.us.dell.com>
References: <Pine.SOL.4.58.0312042225300.26114@yellow.csi.cam.ac.uk> <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0312051109580.1782-100000@logos.cnet>; from marcelo.tosatti@cyclades.com on Fri, Dec 05, 2003 at 01:52:42PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 4 Dec 2003, Anton Altaparmakov wrote:
> > 2.4.23-bk has a changeset (post 2.4.23 release TAG) that makes edd not
> > compile as Meelis Roos already reported:
> > > DISKSIG_BUFFER is nowhere to be seen.

Yeah, that's my bad, setup.c should say DISK80_SIG_BUFFER not
DISKSIG_BUFFER.

===== arch/i386/kernel/setup.c 1.77 vs edited =====
--- 1.77/arch/i386/kernel/setup.c       Mon Dec  1 09:23:55 2003
+++ edited/arch/i386/kernel/setup.c     Fri Dec  5 10:58:11 2003
@@ -211,7 +211,7 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
-#define DISK80_SIGNATURE_BUFFER (*(unsigned int*)(PARAM+DISKSIG_BUFFER))
+#define DISK80_SIGNATURE_BUFFER (*(unsigned int*)(PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))



With this, it works for me on my PowerEdge 4600 with disks on the
aic7xxx, and the same int13 code works on all other PowerEdge servers
we've ever tried it on.  What kind of system and disks (IDE/SCSI) and
BIOS do you have for those please?

> > However, changing DISKSIG_BUFFER to DISK80_SIG_BUFFER causes the kernel to
> > reboot the computer as soon as it starts booting.  Basically I select it
> > in grub and the screen changes graphics mode and by the time it has
> > finished the switch the computer reboots.

Can you send me your .config and I'll try to reproduce? 

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
