Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUFXTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUFXTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUFXTSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:18:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60920 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265275AbUFXTQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:16:26 -0400
Date: Thu, 24 Jun 2004 21:16:18 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch] 2.6.7-mm2: fdomain_cs needs unknown symbols
Message-ID: <20040624191617.GB26669@fs.tum.de>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624014655.5d2a4bfb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 01:46:55AM -0700, Andrew Morton wrote:
>...
> All 195 patches:
>...
> bk-scsi.patch
>...

This makes two functions in drivers/scsi/fdomain.c static that are 
required in fdomain_cs.o:

<--  snip  -->

WARNING: /lib/modules/2.6.7-mm2/kernel/drivers/scsi/pcmcia/fdomain_cs.ko 
needs unknown symbol fdomain_16x0_bus_reset
WARNING: /lib/modules/2.6.7-mm2/kernel/drivers/scsi/pcmcia/fdomain_cs.ko 
needs unknown symbol fdomain_setup

<--  snip  -->


Although I agree that the way fdomain_cs.o is built is too ugly for
words, I'd suggest the following patch that revert these static's:


--- linux-2.6.7-mm2-modular/drivers/scsi/fdomain.c.old	2004-06-24 21:04:56.000000000 +0200
+++ linux-2.6.7-mm2-modular/drivers/scsi/fdomain.c	2004-06-24 21:07:17.000000000 +0200
@@ -418,7 +418,7 @@
 
 static irqreturn_t       do_fdomain_16x0_intr( int irq, void *dev_id,
 					    struct pt_regs * regs );
-static int		 fdomain_16x0_bus_reset(struct scsi_cmnd *SCpnt);
+int			 fdomain_16x0_bus_reset(struct scsi_cmnd *SCpnt);
 
 /* Allow insmod parameters to be like LILO parameters.  For example:
    insmod fdomain fdomain=0x140,11 */
@@ -555,7 +555,7 @@
    printk( "\n" );
 }
 
-static int __init fdomain_setup(char *str)
+int __init fdomain_setup(char *str)
 {
 	int ints[4];
 
@@ -1541,7 +1541,7 @@
    return SUCCESS;
 }
 
-static int fdomain_16x0_bus_reset(struct scsi_cmnd *SCpnt)
+int fdomain_16x0_bus_reset(struct scsi_cmnd *SCpnt)
 {
    outb( 1, SCSI_Cntl_port );
    do_pause( 2 );



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

