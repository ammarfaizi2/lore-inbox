Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUCPC4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUCPCw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:52:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:25775 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262900AbUCPACa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:30 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <107939139263@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:32 -0800
Message-Id: <10793913922333@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.14, 2004/02/23 16:33:50-08:00, khali@linux-fr.org

[PATCH] I2C: Remove asb100 support from w83781d

Now that we have a separate asb100 driver, we can remove the (bad)
support of it from the w83781d driver. Following patch does this. I've
already cleaned this up in our CVS repository.


 drivers/i2c/chips/w83781d.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:36:37 2004
+++ b/drivers/i2c/chips/w83781d.c	Mon Mar 15 14:36:37 2004
@@ -25,8 +25,7 @@
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
     as99127f	7	3	1?	3	0x31	0x12c3	yes	no
-    as99127f rev.2 (type_name = 1299127f)	0x31	0x5ca3	yes	no
-    asb100 "bach" (type_name = as99127f)	0x31	0x0694	yes	no
+    as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
     w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
@@ -1194,10 +1193,8 @@
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
 		if ((!(val1 & 0x07)) &&
-		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3)
-		      && (val2 != 0x94))
-		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
-			 && (val2 != 0x06)))) {
+		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
+		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1226,7 +1223,7 @@
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		if (val2 == 0x5c)
 			vendid = winbond;
-		else if ((val2 == 0x12) || (val2 == 0x06))
+		else if (val2 == 0x12)
 			vendid = asus;
 		else {
 			err = -ENODEV;

