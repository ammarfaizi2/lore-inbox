Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289874AbSBKRp0>; Mon, 11 Feb 2002 12:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289865AbSBKRpH>; Mon, 11 Feb 2002 12:45:07 -0500
Received: from ztxmail01.ztx.compaq.com ([161.114.1.205]:50697 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S289874AbSBKRo7>; Mon, 11 Feb 2002 12:44:59 -0500
Date: Mon, 11 Feb 2002 11:41:23 -0600
From: Stephen Cameron <steve.cameron@compaq.com>
To: linux-kernel@vger.kernel.org
Cc: Timo.Proescholdt@brk-muenchen.de
Subject: RE: randomness - compaq smart array driver
Message-ID: <20020211114123.A24651@quandary.cca.cpqcorp.net>
Reply-To: steve.cameron@compaq.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timo (Timo.Proescholdt@brk-muenchen.de) wrote:

> I have a question concerning /dev/random on proliant servers with 
> smart array controllers.
> A month ago i tried to install freeswan on a proliant dl360 box,
> running redhat 6.2 on a smart array controller.
> There are no disks hanging at the scsi controller only the 
> two disks at the smart array controller channel. Kernel is 2.4.14 .

As it happens, we just sent this patch to Jens on Friday,
I tried it and meant it for 2.5.4-pre2 and -pre3.  I 
think it ought to be good for 2.4.x as well though.

-- steve

diff -urN lx254p2-c3/drivers/block/cciss.c lx254p2-c4/drivers/block/cciss.c
--- lx254p2-c3/drivers/block/cciss.c	Thu Feb  7 14:35:31 2002
+++ lx254p2-c4/drivers/block/cciss.c	Thu Feb  7 14:50:43 2002
@@ -2467,7 +2467,8 @@
 	/* make sure the board interrupts are off */
 	hba[i]->access.set_intr_mask(hba[i], CCISS_INTR_OFF);
 	if( request_irq(hba[i]->intr, do_cciss_intr, 
-		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
+		SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
+			hba[i]->devname, hba[i]))
 	{
 		printk(KERN_ERR "ciss: Unable to get irq %d for %s\n",
 			hba[i]->intr, hba[i]->devname);

