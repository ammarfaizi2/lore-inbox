Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVA1Ab4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVA1Ab4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVA1A3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:29:45 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:42468 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261358AbVA1AZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:25:06 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050128002501.23839.78981.57374@localhost.localdomain>
Subject: [PATCH 2.4] lcd: Add checks to CAP_SYS_ADMIN to potentially dangerous ioctl's
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 18:25:01 -0600
Date: Thu, 27 Jan 2005 18:25:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CAP_SYS_ADMIN checks to the potentially dangerous ioctls FLASH_Erase and FLASH_Burn
in the Cobalt LCD interface driver.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -purN --exclude='*~' linux-2.4.29-original/drivers/char/lcd.c linux-2.4.29/drivers/char/lcd.c
--- linux-2.4.29-original/drivers/char/lcd.c	2005-01-27 18:46:42.085690494 -0500
+++ linux-2.4.29/drivers/char/lcd.c	2005-01-27 18:54:00.902766505 -0500
@@ -386,6 +386,8 @@ static int lcd_ioctl(struct inode *inode
 
 		int ctr=0;
 
+		if (!capable(CAP_SYS_ADMIN)) return -EPERM;
+
 		    // Chip Erase Sequence
 		WRITE_FLASH( kFlash_Addr1, kFlash_Data1 );
 		WRITE_FLASH( kFlash_Addr2, kFlash_Data2 );
@@ -422,6 +424,8 @@ static int lcd_ioctl(struct inode *inode
 
                 struct lcd_display display;
 
+		if (!capable(CAP_SYS_ADMIN)) return -EPERM;
+
                 if(copy_from_user(&display, (struct lcd_display*)arg, sizeof(struct lcd_display)))
 		  return -EFAULT;
 		rom = (unsigned char *) kmalloc((128),GFP_ATOMIC);
