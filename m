Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJRJj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJRJj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUJRJjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:39:14 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:31742 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S265234AbUJRJhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:37:07 -0400
Message-ID: <41738EC1.1080707@verizon.net>
Date: Mon, 18 Oct 2004 05:37:05 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to drivers/video/Kconfig [2 of 4]
Content-Type: multipart/mixed;
 boundary="------------000203010900070402010603"
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:37:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000203010900070402010603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix undefined symbol errors in "make config" on architectures that do
not have I2C (sparc, primarily)

Apply against 2.6.9-rc4.

diff -u drivers/video/Kconfig.orig drivers/video/Kconfig


--------------000203010900070402010603
Content-Type: text/x-patch;
 name="drivers_video_kconfig-fix-matrox-dependency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_video_kconfig-fix-matrox-dependency.patch"

--- drivers/video/Kconfig.orig	2004-10-16 11:58:32.738491881 -0400
+++ drivers/video/Kconfig	2004-10-16 12:55:51.225105213 -0400
@@ -586,10 +586,12 @@
 	depends on FB_MATROX && (FB_MATROX_G450 || FB_MATROX_G100A)
 	default y
 
+comment "Enable I2C and I2C_ALGOBIT to enable Matrox I2C support."
+	depends on FB_MATROX && !(I2C && I2C_ALGOBIT)
+
 config FB_MATROX_I2C
 	tristate "Matrox I2C support"
-	depends on FB_MATROX && I2C
-	select I2C_ALGOBIT
+	depends on FB_MATROX && I2C && I2C_ALGOBIT
 	---help---
 	  This drivers creates I2C buses which are needed for accessing the
 	  DDC (I2C) bus present on all Matroxes, an I2C bus which


--------------000203010900070402010603--
