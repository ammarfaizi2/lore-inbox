Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUJRJif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUJRJif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUJRJif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:38:35 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:65469 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S265773AbUJRJiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:38:00 -0400
Message-ID: <41738EF2.3030701@verizon.net>
Date: Mon, 18 Oct 2004 05:37:54 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to drivers/video/Kconfig [4 of 4]
Content-Type: multipart/mixed;
 boundary="------------000606010904060105020607"
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:37:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000606010904060105020607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix undefined symbol errors in "make config" on architectures that do
not have I2C (sparc, primarily)

Apply against 2.6.9-rc4.

diff -u drivers/video/Kconfig.orig drivers/video/Kconfig


--------------000606010904060105020607
Content-Type: text/x-patch;
 name="drivers_video_kconfig-fix-riva-i2c-dependency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_video_kconfig-fix-riva-i2c-dependency.patch"

--- drivers/video/Kconfig.orig	2004-10-16 11:58:32.738491881 -0400
+++ drivers/video/Kconfig	2004-10-16 12:24:54.896505429 -0400
@@ -428,8 +428,6 @@
 config FB_RIVA
 	tristate "nVidia Riva support"
 	depends on FB && PCI
-	select I2C_ALGOBIT if FB_RIVA_I2C
-	select I2C if FB_RIVA_I2C
 	select FB_MODE_HELPERS
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
@@ -441,7 +439,7 @@
 
 config FB_RIVA_I2C
        bool "Enable DDC Support"
-       depends on FB_RIVA
+       depends on FB_RIVA && I2C && I2C_ALGOBIT
        help
 	  This enables I2C support for nVidia Chipsets.  This is used
 	  only for getting EDID information from the attached display
@@ -451,6 +449,9 @@
 	  independently validate video mode parameters, you should say Y
 	  here.
 
+comment "You must enable I2C and I2C_ALGOBIT for nVidia Riva DDC Support."
+	depends on !(I2C && I2C_ALGOBIT) && FB_RIVA
+
 config FB_RIVA_DEBUG
 	bool "Lots of debug output from Riva(nVidia) driver"
 	depends on FB_RIVA

--------------000606010904060105020607--
