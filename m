Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271468AbRHPEv4>; Thu, 16 Aug 2001 00:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271474AbRHPEvq>; Thu, 16 Aug 2001 00:51:46 -0400
Received: from trained-monkey.org ([209.217.122.11]:38648 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271475AbRHPEvi>; Thu, 16 Aug 2001 00:51:38 -0400
Date: Thu, 16 Aug 2001 00:49:56 -0400
Message-Id: <200108160449.f7G4nu619552@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: alan@redhat.com
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] 64 bit bug in video1394.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

drivers/message/i2o/i2o_block.c cpu flags in 'int' which breaks on 64
bit boxes.

Here's a patch.

Jes

--- drivers/message/i2o/i2o_block.c~	Wed Aug  8 00:08:04 2001
+++ drivers/message/i2o/i2o_block.c	Thu Aug 16 00:48:19 2001
@@ -721,7 +721,7 @@
 static int i2ob_evt(void *dummy)
 {
 	unsigned int evt;
-	unsigned int flags;
+	unsigned long flags;
 	int unit;
 	int i;
 	//The only event that has data is the SCSI_SMART event.
@@ -1706,7 +1706,7 @@
 {	
 	int unit = 0;
 	int i = 0;
-	int flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&io_request_lock, flags);
 
