Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281216AbRKEQdJ>; Mon, 5 Nov 2001 11:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281219AbRKEQdC>; Mon, 5 Nov 2001 11:33:02 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:53494 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281216AbRKEQcv>;
	Mon, 5 Nov 2001 11:32:51 -0500
Date: Sat, 3 Nov 2001 16:34:30 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tobias Ringstrom <tori@unhappy.mine.nu>, linux-kernel@vger.kernel.org
Subject: [PATCH] Davicom net driver jiffies cleanup
Message-ID: <20011103163430.B12523@lynx.no>
Mail-Followup-To: torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tobias Ringstrom <tori@unhappy.mine.nu>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch for jiffies cleanup of the Davicom fast ethernet driver (dmfe).
The maintainer (Tobias Ringstrom <tori@unhappy.mine.nu>) is CC'd, but
it is obviously correct.

Cheers, Andreas
===========================================================================
--- linux/drivers/net/dmfe.c.orig	Thu Oct 25 02:08:43 2001
+++ linux/drivers/net/dmfe.c	Fri Nov  2 21:52:45 2001
@@ -1109,11 +1109,11 @@
 
 	/* TX polling kick monitor */
 	if ( db->tx_packet_cnt &&
-		((jiffies - dev->trans_start) > DMFE_TX_KICK) ) {
+	     time_after(jiffies, dev->trans_start + DMFE_TX_KICK) ) {
 		outl(0x1, dev->base_addr + DCR1);   /* Tx polling again */
 
 		/* TX Timeout */
-		if ( (jiffies - dev->trans_start) > DMFE_TX_TIMEOUT ) {
+		if ( time_after(jiffies, dev->trans_start + DMFE_TX_TIMEOUT) ) {
 			db->reset_TXtimeout++;
 			db->wait_reset = 1;
 			printk(KERN_WARNING "%s: Tx timeout - resetting\n",
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

