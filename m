Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUFNAnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUFNAnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFNAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:40:15 -0400
Received: from holomorphy.com ([207.189.100.168]:29597 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261500AbUFNAii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:38:38 -0400
Date: Sun, 13 Jun 2004 17:38:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [5/12] Ignore errors from tw_setfeature in 3w-xxxx.c
Message-ID: <20040614003835.GT1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614003708.GS1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Ignore errors from tw_setfeature in drivers/scsi/3w-xxxx.c
This fixes Debian BTS #181581.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=181581

	From: Blars Blarson <blarson@blars.org>
	To: submit@bugs.debian.org
	Subject: kernel-source-2.4.20: 3w-xxxx driver won't configure older 3ware card
	Message-ID: <20030219074855.GA22346@blars.org>

The 3w-xxxx driver has changed so it will no longer configure older
3ware raid cards.  The attached patch allows it to work with my 3ware
card.  (The source is the same in 2.4.20-5.)  (Note: this is an ide
controler pretending it's scsi.)


Index: linux-2.5/drivers/scsi/3w-xxxx.c
===================================================================
--- linux-2.5.orig/drivers/scsi/3w-xxxx.c	2004-06-13 11:57:23.000000000 -0700
+++ linux-2.5/drivers/scsi/3w-xxxx.c	2004-06-13 12:08:55.000000000 -0700
@@ -1220,13 +1220,6 @@
 			error = tw_setup_irq(tw_dev2);
 			if (error) {
 				printk(KERN_WARNING "3w-xxxx: tw_findcards(): Error requesting irq for card %d.\n", j);
-				scsi_unregister(host);
-				release_region((tw_dev->tw_pci_dev->resource[0].start), TW_IO_ADDRESS_RANGE);
-
-				tw_free_device_extension(tw_dev);
-				kfree(tw_dev);
-				numcards--;
-				continue;
 			}
 
 			/* Re-enable interrupts on the card */
