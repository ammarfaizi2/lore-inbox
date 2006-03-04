Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWCDIut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWCDIut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 03:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWCDIut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 03:50:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:44416 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751318AbWCDIus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 03:50:48 -0500
Message-ID: <440954EA.90604@sw.ru>
Date: Sat, 04 Mar 2006 11:50:50 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, markus.lidel@shadowconnect.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org
Subject: [PATCH I2O] i2o_dump_hrt output cleanup
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040905020203040903050603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040905020203040903050603
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch fixes i2o_dump_hrt output
from dmesg:
iop0: HRT has 1 entries of 16 bytes each.
Adapter 00000012: <7>TID 0000:[<7>H<7>P<7>C<7>*<7>]:<7>PCI 1: Bus 1 Device 22
Function 0<7>

Signed-off-by: Vasily Averin <vvs@sw.ru>

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

--------------040905020203040903050603
Content-Type: text/plain;
 name="diff-drv-i2o-dumphrt-20060303"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-drv-i2o-dumphrt-20060303"

--- ./drivers/message/i2o/debug.c.i2dbg	2006-01-03 06:21:10.000000000 +0300
+++ ./drivers/message/i2o/debug.c	2006-03-03 17:59:03.000000000 +0300
@@ -419,58 +419,53 @@ void i2o_dump_hrt(struct i2o_controller 
 		d = (u8 *) (rows + 2);
 		state = p[1] << 8 | p[0];
 
-		printk(KERN_DEBUG "TID %04X:[", state & 0xFFF);
+		printk("TID %04X:[", state & 0xFFF);
 		state >>= 12;
 		if (state & (1 << 0))
-			printk(KERN_DEBUG "H");	/* Hidden */
+			printk("H");	/* Hidden */
 		if (state & (1 << 2)) {
-			printk(KERN_DEBUG "P");	/* Present */
+			printk("P");	/* Present */
 			if (state & (1 << 1))
-				printk(KERN_DEBUG "C");	/* Controlled */
+				printk("C");	/* Controlled */
 		}
 		if (state > 9)
-			printk(KERN_DEBUG "*");	/* Hard */
+			printk("*");	/* Hard */
 
-		printk(KERN_DEBUG "]:");
+		printk("]:");
 
 		switch (p[3] & 0xFFFF) {
 		case 0:
 			/* Adapter private bus - easy */
-			printk(KERN_DEBUG
-			       "Local bus %d: I/O at 0x%04X Mem 0x%08X", p[2],
+			printk("Local bus %d: I/O at 0x%04X Mem 0x%08X", p[2],
 			       d[1] << 8 | d[0], *(u32 *) (d + 4));
 			break;
 		case 1:
 			/* ISA bus */
-			printk(KERN_DEBUG
-			       "ISA %d: CSN %d I/O at 0x%04X Mem 0x%08X", p[2],
+			printk("ISA %d: CSN %d I/O at 0x%04X Mem 0x%08X", p[2],
 			       d[2], d[1] << 8 | d[0], *(u32 *) (d + 4));
 			break;
 
 		case 2:	/* EISA bus */
-			printk(KERN_DEBUG
-			       "EISA %d: Slot %d I/O at 0x%04X Mem 0x%08X",
+			printk("EISA %d: Slot %d I/O at 0x%04X Mem 0x%08X",
 			       p[2], d[3], d[1] << 8 | d[0], *(u32 *) (d + 4));
 			break;
 
 		case 3:	/* MCA bus */
-			printk(KERN_DEBUG
-			       "MCA %d: Slot %d I/O at 0x%04X Mem 0x%08X", p[2],
+			printk("MCA %d: Slot %d I/O at 0x%04X Mem 0x%08X", p[2],
 			       d[3], d[1] << 8 | d[0], *(u32 *) (d + 4));
 			break;
 
 		case 4:	/* PCI bus */
-			printk(KERN_DEBUG
-			       "PCI %d: Bus %d Device %d Function %d", p[2],
+			printk("PCI %d: Bus %d Device %d Function %d", p[2],
 			       d[2], d[1], d[0]);
 			break;
 
 		case 0x80:	/* Other */
 		default:
-			printk(KERN_DEBUG "Unsupported bus type.");
+			printk("Unsupported bus type.");
 			break;
 		}
-		printk(KERN_DEBUG "\n");
+		printk("\n");
 		rows += length;
 	}
 }

--------------040905020203040903050603--
