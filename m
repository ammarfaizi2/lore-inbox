Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUFBP5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUFBP5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUFBP5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:57:49 -0400
Received: from cpc5-hitc2-5-0-cust152.lutn.cable.ntl.com ([82.0.115.152]:39621
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263227AbUFBPse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:48:34 -0400
Message-ID: <40BDF8E6.6040601@gentoo.org>
Date: Wed, 02 Jun 2004 16:57:26 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stelian@popies.net
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Use msleep in meye driver
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040603000908020002000806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040603000908020002000806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove meye's definition of wait_ms() and switch to using the new global 
msleep() function.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Against 2.6.7-rc2

--------------040603000908020002000806
Content-Type: text/plain;
 name="meye-msleep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="meye-msleep.patch"

--- linux-dsd/drivers/media/video/meye.c.orig	2004-05-10 03:32:39.000000000 +0100
+++ linux-dsd/drivers/media/video/meye.c	2004-06-02 15:20:24.677887544 +0100
@@ -473,16 +473,6 @@
 /* MCHIP low-level functions                                                */
 /****************************************************************************/
 
-/* waits for the specified miliseconds */
-static inline void wait_ms(unsigned int ms) {
-	if (!in_interrupt()) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1 + ms * HZ / 1000);
-	}
-	else
-		mdelay(ms);
-}
-
 /* returns the horizontal capture size */
 static inline int mchip_hsize(void) {
 	return meye.params.subsample ? 320 : 640;
@@ -640,12 +630,12 @@
 		for (j = 0; j < 100; ++j) {
 			if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 				return;
-			wait_ms(1);
+			msleep(1);
 		}
 		printk(KERN_ERR "meye: need to reset HIC!\n");
 	
 		mchip_set(MCHIP_HIC_CTL, MCHIP_HIC_CTL_SOFT_RESET);
-		wait_ms(250);
+		msleep(250);
 	}
 	printk(KERN_ERR "meye: resetting HIC hanged!\n");
 }
@@ -741,7 +731,7 @@
 	for (i = 0; i < 100; ++i) {
 		if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 			break;
-		wait_ms(1);
+		msleep(1);
 	}
 }
 
@@ -757,7 +747,7 @@
 	for (i = 0; i < 100; ++i) {
 		if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 			break;
-		wait_ms(1);
+		msleep(1);
 	}
 	for (i = 0; i < 4 ; ++i) {
 		v = mchip_get_frame();
@@ -799,7 +789,7 @@
 	for (i = 0; i < 100; ++i) {
 		if (mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE))
 			break;
-		wait_ms(1);
+		msleep(1);
 	}
 
 	for (i = 0; i < 4 ; ++i) {
@@ -1260,11 +1250,11 @@
 
 	mchip_delay(MCHIP_HIC_CMD, 0);
 	mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE);
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_VRJ_SOFT_RESET, 1);
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_PCI_MODE, 5);
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
 
 	switch (meye.pm_mchip_mode) {
@@ -1349,13 +1339,13 @@
 	mchip_delay(MCHIP_HIC_CMD, 0);
 	mchip_delay(MCHIP_HIC_STATUS, MCHIP_HIC_STATUS_IDLE);
 
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_VRJ_SOFT_RESET, 1);
 
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_PCI_MODE, 5);
 
-	wait_ms(1);
+	msleep(1);
 	mchip_set(MCHIP_MM_INTA, MCHIP_MM_INTA_HIC_1_MASK);
 
 	if (video_register_device(meye.video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {

--------------040603000908020002000806--
