Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWFCPCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWFCPCi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 11:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWFCPCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 11:02:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22289 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750947AbWFCPCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 11:02:38 -0400
Date: Sat, 3 Jun 2006 16:02:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
Message-ID: <20060603150229.GC31182@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603141548.GA31182@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 03:15:48PM +0100, Russell King wrote:
> I don't know what to do about this since I don't have any cards and
> I've not seen any bug reports to investigate what's going on.  So I'm
> just going to say "the code as it stands is correct as to my best
> knowledge, please provide details of it's failings."

It would be nice to get the results from the following patch from people
with failing cards.  Obviously they need to enable the debugging message
to see it.

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -44,6 +44,7 @@
 #define MMC_SHIFT	3
 
 static int major;
+static int debug;
 
 /*
  * There is one mmc_blk_data per slot.
@@ -324,6 +325,19 @@ static struct mmc_blk_data *mmc_blk_allo
 	 */
 	md->read_only = mmc_blk_readonly(card);
 
+	if (debug)
+		printk(KERN_INFO "%s: sd%u mmca%u cap0x%x rd:b%u:m%u:p%u wr:b%u:m%u:p%u\n",
+			mmc_card_id(card),
+			mmc_card_sd(card),
+			card->csd.mmca_vsn,
+			card->csd.capacity,
+			card->csd.read_blkbits,
+			card->csd.read_misalign,
+			card->csd.read_partial,
+			card->csd.write_blkbits,
+			card->csd.write_misalign,
+			card->csd.write_partial);
+
 	/*
 	 * Figure out a workable block size.  MMC cards have:
 	 *  - two block sizes, one for read and one for write.
@@ -575,5 +589,8 @@ module_exit(mmc_blk_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
 
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "enable debugging messages");
+
 module_param(major, int, 0444);
 MODULE_PARM_DESC(major, "specify the major device number for MMC block driver");

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
