Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271471AbRHPEq4>; Thu, 16 Aug 2001 00:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271468AbRHPEqh>; Thu, 16 Aug 2001 00:46:37 -0400
Received: from trained-monkey.org ([209.217.122.11]:36600 "EHLO
	savage.trained-monkey.org") by vger.kernel.org with ESMTP
	id <S271465AbRHPEqa>; Thu, 16 Aug 2001 00:46:30 -0400
Date: Thu, 16 Aug 2001 00:44:48 -0400
Message-Id: <200108160444.f7G4imA19523@savage.trained-monkey.org>
From: <jes@trained-monkey.org>
To: jamesg@filanet.com
CC: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch] 64 bit bug in ohci1394.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

drivers/ieee1394/sbp.c has a couple of instances where it saved
cpu flags in 'int' which breaks on 64 bit boxes.

Here's a patch.

Jes

--- drivers/ieee1394/sbp2.c~	Wed Aug  8 00:08:04 2001
+++ drivers/ieee1394/sbp2.c	Thu Aug 16 00:43:54 2001
@@ -984,7 +984,7 @@
 static void sbp2_add_host(struct hpsb_host *host)
 {
 	struct sbp2scsi_host_info *hi;
-	unsigned int flags;
+	unsigned long flags;
 
 	SBP2_DEBUG("sbp2: sbp2_add_host");
 
@@ -1067,7 +1067,7 @@
 {
 	struct sbp2scsi_host_info *hi;
 	int i;
-	unsigned int flags;
+	unsigned long flags;
 
 	SBP2_DEBUG("sbp2: sbp2_remove_host");
 
