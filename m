Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271473AbRHPEoh>; Thu, 16 Aug 2001 00:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271471AbRHPEo0>; Thu, 16 Aug 2001 00:44:26 -0400
Received: from trained-monkey.org ([209.217.122.11]:35320 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271468AbRHPEoU>; Thu, 16 Aug 2001 00:44:20 -0400
Date: Thu, 16 Aug 2001 00:42:33 -0400
Message-Id: <200108160442.f7G4gXT19513@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: sebastien.rougeaux@anu.edu.au
CC: Gord Peters <GordPeters@smarttech.com>, torvalds@transmeta.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] 64 bit bug in ohci1394.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

drivers/ieee1394/ohci1394.c has a couple of instances where it saved
cpu flags in 'int' which breaks on 64 bit boxes.

Here's a patch.

Jes

--- drivers/ieee1394/ohci1394.c~	Wed Aug  8 00:08:04 2001
+++ drivers/ieee1394/ohci1394.c	Thu Aug 16 00:40:28 2001
@@ -200,7 +200,8 @@
 
 static u8 get_phy_reg(struct ti_ohci *ohci, u8 addr) 
 {
-	int i, flags;
+	int i;
+	unsigned long flags;
 	quadlet_t r;
 
 	spin_lock_irqsave (&ohci->phy_reg_lock, flags);
@@ -227,7 +228,8 @@
 
 static void set_phy_reg(struct ti_ohci *ohci, u8 addr, u8 data)
 {
-	int i, flags;
+	int i;
+	unsigned long flags;
 	u32 r;
 
 	spin_lock_irqsave (&ohci->phy_reg_lock, flags);
@@ -1066,7 +1068,8 @@
 	quadlet_t event, node_id;
 	struct ti_ohci *ohci = (struct ti_ohci *)dev_id;
 	struct hpsb_host *host = ohci->host;
-	int phyid = -1, isroot = 0, flags;
+	int phyid = -1, isroot = 0;
+	unsigned long flags;
 
 	/* Read the interrupt event register. We don't clear the bus reset
 	 * here. We wait till we get a selfid complete interrupt and clear
@@ -1331,7 +1334,8 @@
 	struct ti_ohci *ohci = (struct ti_ohci*)(d->ohci);
 	unsigned int split_left, idx, offset, rescount;
 	unsigned char tcode;
-	int length, bytes_left, ack, flags;
+	int length, bytes_left, ack;
+	unsigned long flags;
 	quadlet_t *buf_ptr;
 	char *split_ptr;
 	char msg[256];
