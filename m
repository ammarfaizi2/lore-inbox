Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267413AbTA1PWm>; Tue, 28 Jan 2003 10:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267414AbTA1PWm>; Tue, 28 Jan 2003 10:22:42 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:26799 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267413AbTA1PWk>; Tue, 28 Jan 2003 10:22:40 -0500
Date: Tue, 28 Jan 2003 16:31:55 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Edward Peng." <edward_peng@dlink.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG] in drivers/net/dl2k.h
Message-ID: <20030128153155.GA10685@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The patch below should be enough to verify the bug and create a proper
fix, I hope.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack

diff -Naur linux-2.4.21-pre3-ac4/drivers/net/dl2k.c scratch/drivers/net/dl2k.c
--- linux-2.4.21-pre3-ac4/drivers/net/dl2k.c	Fri Jan 24 15:25:37 2003
+++ scratch/drivers/net/dl2k.c	Tue Jan 28 15:45:02 2003
@@ -1743,6 +1743,8 @@
 		anar.image = mii_read (dev, phy_addr, MII_ANAR);
 		anar.bits.half_duplex = 
 			esr.bits.media_1000BT_HD | esr.bits.media_1000BX_HD;
+		/* BUG: esr.bits.media_1000BT_FD is uninitialized.
+		 * 	see sl2k.h */
 		anar.bits.full_duplex = 
 			esr.bits.media_1000BT_FD | esr.bits.media_1000BX_FD;
 		anar.bits.pause = 1;
diff -Naur linux-2.4.21-pre3-ac4/drivers/net/dl2k.h scratch/drivers/net/dl2k.h
--- linux-2.4.21-pre3-ac4/drivers/net/dl2k.h	Fri Jan 24 15:25:37 2003
+++ scratch/drivers/net/dl2k.h	Tue Jan 28 15:46:33 2003
@@ -513,6 +513,8 @@
 	u16 image;
 	struct {
 		u16 _bit_11_0:12;	// bit 11:0
+		/* BUG: ":2" should be ":1", if this is really only bit 12.
+		 * 	This should cause the bug in dl2k.c */
 		u16 media_1000BT_HD:2;	// bit 12
 		u16 media_1000BT_FD:1;	// bit 13
 		u16 media_1000BX_HD:1;	// bit 14
