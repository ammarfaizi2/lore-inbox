Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbTDWHvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTDWHvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:51:50 -0400
Received: from [81.80.245.157] ([81.80.245.157]:36825 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S263982AbTDWHvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:51:48 -0400
Date: Wed, 23 Apr 2003 10:04:15 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.21-rc1] sonypi fixes
Message-ID: <20030423080415.GD820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've already send this once or twice, but it hasn't been applied yet
to the 2.4 tree.

I've attached below a smaller patch, containing only the obviously
correct changes, so there is no risk involved in applying this.

Original credit goes to Adrian Bunk for the .text.exit related
changes and to Daniel K. for the battery #defines.

Marcelo, please apply.

Stelian.

===== drivers/char/sonypi.c 1.14 vs edited =====
--- 1.14/drivers/char/sonypi.c	Tue Feb 18 12:33:33 2003
+++ edited/drivers/char/sonypi.c	Mon Mar 31 16:39:06 2003
@@ -162,7 +162,7 @@
 }
 
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void __devexit sonypi_type1_dis(void) {
+static void sonypi_type1_dis(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -174,7 +174,7 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
-static void __devexit sonypi_type2_dis(void) {
+static void sonypi_type2_dis(void) {
 	if (ec_write(SONYPI_SHIB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (ec_write(SONYPI_SLOB, 0))
@@ -531,7 +531,7 @@
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT1REM:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT1_LEFT, &val16)) {
 			ret = -EIO;
 			break;
 		}
@@ -539,7 +539,7 @@
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT2CAP:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT2_FULL, &val16)) {
 			ret = -EIO;
 			break;
 		}
@@ -547,7 +547,7 @@
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBAT2REM:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT2_LEFT, &val16)) {
 			ret = -EIO;
 			break;
 		}
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
