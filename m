Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUJRJj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUJRJj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUJRJjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:39:03 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:35495 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S265395AbUJRJh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:37:28 -0400
Message-ID: <41738ED7.9090400@verizon.net>
Date: Mon, 18 Oct 2004 05:37:27 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch to drivers/video/Kconfig [3 of 4]
Content-Type: multipart/mixed;
 boundary="------------090205010504080403010702"
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:37:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090205010504080403010702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix undefined symbol errors in "make config" on architectures that do
not have I2C (sparc, primarily)

Apply against 2.6.9-rc4.

diff -u drivers/video/Kconfig.orig drivers/video/Kconfig


--------------090205010504080403010702
Content-Type: text/x-patch;
 name="drivers_video_kconfig-fix-radeon-dependency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_video_kconfig-fix-radeon-dependency.patch"

--- drivers/video/Kconfig.orig	2004-10-16 11:58:32.738491881 -0400
+++ drivers/video/Kconfig	2004-10-16 13:07:09.222883919 -0400
@@ -667,8 +667,6 @@
 config FB_RADEON
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
-	select I2C_ALGOBIT if FB_RADEON_I2C
-	select I2C if FB_RADEON_I2C
 	select FB_MODE_HELPERS
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
@@ -685,9 +683,12 @@
 	  There is a product page at
 	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
 
+comment "Enable I2C and I2C_ALGOBIT to enable ATI Radeon DDC/I2C support."
+	depends on FB_RADEON && !(I2C && I2C_ALGOBIT)
+
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
-	depends on FB_RADEON
+	depends on FB_RADEON && I2C && I2C_ALGOBIT
 	default y
 	help
 	  Say Y here if you want DDC/I2C support for your Radeon board. 

--------------090205010504080403010702--
