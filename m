Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVBRPfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVBRPfW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVBRPfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:35:22 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:17027 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261387AbVBRPfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:35:08 -0500
Subject: Re: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function
	called from invalid context and segmentation fault
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200502161935.43820.blaisorblade@yahoo.it>
References: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
	 <200502161935.43820.blaisorblade@yahoo.it>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Fri, 18 Feb 2005 15:33:43 +0000
Message-Id: <1108740823.6713.28.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-16 at 19:35 +0100, Blaisorblade wrote:
> On Monday 14 February 2005 12:48, Anton Altaparmakov wrote:
> > Hi,
> >
> > I get a few Debug messages of the form from UML:
> >
> > Debug: sleeping function called from invalid context at
> > include/asm/arch/semaphore.h:107
> > in_atomic():0, irqs_disabled():1
> > Call Trace:
> > 087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
> > 087d77d8:  [<084d377f>] mcount+0xf/0x20
> > 087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80
> 
> > Most are coming via uml_console_write.
> The problem is that the UML tty drivers use a semaphore instead of a spinlock 
> for the locking, which also causes some other problems.
> 
> The attached patch should fix this, but I've not yet made sure it is not 
> deadlock-prone (I didn't hit any during some very limited testing).
> 
> So it's not yet ready for 2.6.11.

Trying with the above patch in now only get two "sleeping function
called from invalid context" warnings during boot and none during
running.  However I get a lot of those errors:

arch/um/drivers/line.c:262: spin_lock(arch/um/drivers/line.c:085b5900)
already locked by arch/um/drivers/line.c/262

Also both before and after the patch I see a lot of messages like:

kernel: line_write_room: tty2: no room left in buffer

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

