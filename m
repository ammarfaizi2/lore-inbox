Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWJQM7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWJQM7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 08:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWJQM7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 08:59:16 -0400
Received: from 85-210-250-36.dsl.pipex.com ([85.210.250.36]:57053 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750858AbWJQM7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 08:59:16 -0400
Date: Tue, 17 Oct 2006 13:54:22 +0100
To: Andrew Morton <akpm@osdl.org>, Holger Macht <hmacht@suse.de>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] backlight users need to select BACKLIGHT_CLASS_DEVICE
Message-ID: <fe75efd7d8608c949bd6be9c78ed54c4@pinky>
References: <45349744.9040508@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <45349744.9040508@ens-lyon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have a similar issue, but with ACPI_TOSHIBA=y.  It does not
look like the backlight support is intended to be optional.  I also
note that ACPI_SONY is already select'ing BACKLIGHT_CLASS_DEVICE
directly.

The attached patch seems like the right thing.  I have tested this
with the config I had showing the problem.  My kernels now compile
again.

Seems that this change comes in from the following patch:
  add-support-for-the-generic-backlight-device-to-the-toshiba-acpi-driver

Does this seem sane?

Holger?

-apw

=== 8< ===
backlight users need to select BACKLIGHT_CLASS_DEVICE

When compiling 2.6.19-rc2-mm1 we get the following link
failures:

  drivers/built-in.o(.init.text+0x3076): In function `toshiba_acpi_init':
    : undefined reference to `backlight_device_register'
  drivers/built-in.o(.exit.text+0x170): In function `toshiba_acpi_exit':
    : undefined reference to `backlight_device_unregister'

When we build an ACPI module which provides backlight
support we need to ensure that the backlight class
device is selected.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 335da3e..819331d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -179,7 +179,7 @@ config ACPI_NUMA
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
-	select BACKLIGHT_DEVICE
+	select BACKLIGHT_CLASS_DEVICE
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may also
@@ -208,7 +208,7 @@ config ACPI_ASUS
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
-	select BACKLIGHT_DEVICE
+	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
@@ -234,7 +234,7 @@ config ACPI_IBM_DOCK
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
-	select BACKLIGHT_DEVICE
+	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
