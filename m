Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbUKIXpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUKIXpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUKIXoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:44:09 -0500
Received: from linux.us.dell.com ([143.166.224.162]:57413 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261768AbUKIXlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:41:19 -0500
Date: Tue, 9 Nov 2004 17:40:54 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Christian Kujau <evil@g-house.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
Message-ID: <20041109234053.GA4546@lists.us.dell.com>
References: <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4191530D.8020406@g-house.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 12:30:21AM +0100, Christian Kujau wrote:
> > 	ChangeSet@1.2000.5.108, 2004-10-20 08:36:22-07:00, Matt_Domsch@dell.com
> > 	  [PATCH] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
> 
> and i say: good catch! that does it!
> 
> i did "bk undo -a1.2000.5.108" on a current tree, booting this still gives
> an oops:
> 
> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.9_a1.2000.5.108.txt
> 
> excluding this single ChangeSet with "bk undo -r1.2118" does work with
> CONFIG_EDD=y:
> 
> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-2.6.9_r1.2000.5.108.txt

OK, thanks, that helps.  From the diff of those dmesg:

-BIOS EDD facility v0.16 2004-Jun-25, 16 devices found
+BIOS EDD facility v0.16 2004-Jun-25, 6 devices found

So with the latest EDD patch noted above, it's finding more disks than
before.  How many disks do you actually have in the system?

I'll review the assembly again to see where I could have miscounted,
and see how that may affect the EDD sysfs exports.  Likely no answer
from me before tomorrow though.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
