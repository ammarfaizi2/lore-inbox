Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263654AbVBCRz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbVBCRz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVBCRzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:55:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:4008 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263431AbVBCRlQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:16 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Reduce it87 i2c address range
In-Reply-To: <11074523383338@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:38:58 -0800
Message-Id: <11074523383635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2044, 2005/02/03 00:29:54-08:00, khali@linux-fr.org

[PATCH] I2C: Reduce it87 i2c address range

IT87xxF chips were never seen at any other I2C address than the default
(0x2d) so I think that we could safely reduce the range of addresses the
it87 drivers accepts. Currently it accepts 0x20-0x2f, I believe that
0x28-0x2f would already be more than sufficient.

(In theory, any address is possible, so whatever range we choose is
arbitrary anyway.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-02-03 09:35:02 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-02-03 09:35:02 -08:00
@@ -2,8 +2,8 @@
     it87.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring.
 
-    Supports: IT8705F  Super I/O chip w/LPC interface
-              IT8712F  Super I/O chip w/LPC interface & SMbus
+    Supports: IT8705F  Super I/O chip w/LPC interface & SMBus
+              IT8712F  Super I/O chip w/LPC interface & SMBus
               Sis950   A clone of the IT8705F
 
     Copyright (C) 2001 Chris Gauthron <chrisg@0-in.com> 
@@ -42,10 +42,8 @@
 
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24,
-					0x25, 0x26, 0x27, 0x28, 0x29,
-					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
-					0x2f, I2C_CLIENT_END };
+static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
+					0x2e, 0x2f, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */

