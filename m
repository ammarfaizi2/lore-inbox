Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTDCTOW 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263495AbTDCTMs 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:12:48 -0500
Received: from LION-S12.SEAS.UPENN.EDU ([158.130.12.194]:60033 "EHLO
	lion.seas.upenn.edu") by vger.kernel.org with ESMTP
	id S263494AbTDCTLI 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:11:08 -0500
Date: Thu, 3 Apr 2003 14:24:57 -0500
From: Nicholas Henke <henken@seas.upenn.edu>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: PATCH: eepro100 oops on 2.4.20
Message-Id: <20030403142457.14227434.henken@seas.upenn.edu>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the patch that fixes an oops on 2.4.20 when insmod'ing eepro100.
 Looks like a trivial 'oops forgot to replace those' case.

---------------------start patch----------------------------------
diff -urN clean/drivers/net/eepro100.c linux-2.4/drivers/net/eepro100.c
--- clean/drivers/net/eepro100.c	Thu Apr  3 23:21:47 2003
+++ linux-2.4/drivers/net/eepro100.c	Thu Apr  3 23:25:09 2003
@@ -788,10 +788,10 @@
 					   ((option & 0x20) ? 0x2000 : 0) | 	/* 100mbps? */
 					   ((option & 0x10) ? 0x0100 : 0)); /* Full duplex? */
 		} else {
-			int mii_bmcrctrl = mdio_read(ioaddr, eeprom[6] & 0x1f, 0);
+			int mii_bmcrctrl = mdio_read(dev, eeprom[6] & 0x1f, 0);
 			/* Reset out of a transceiver left in 10baseT-fixed mode. */
 			if ((mii_bmcrctrl & 0x3100) == 0)
-				mdio_write(ioaddr, eeprom[6] & 0x1f, 0, 0x8000);
+				mdio_write(dev, eeprom[6] & 0x1f, 0, 0x8000);
 		}
 
 		/* Perform a system self-test. */
------------------end----------------------------------------------------------
Nic

P.S Please cc me on any replies to lkml -- I am not on the list
-- 
Nicholas Henke
Penguin Herder & Linux Cluster System Programmer
Liniac Project - Univ. of Pennsylvania
