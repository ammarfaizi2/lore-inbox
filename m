Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUCHEOU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 23:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUCHEOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 23:14:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:64956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262384AbUCHEOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 23:14:17 -0500
Date: Sun, 7 Mar 2004 19:53:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: stelian@popies.net
Subject: [PATCH] sonypi section usage
Message-Id: <20040307195349.354f3bf1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

Please apply to 2.6.current.

Thanks,
--
~Randy


// Linux 2.6.4-rc2
// sonypi_type[12]_srs() are called by sonypi_pm_callback()
// so they shouldn't be marked as __devinit;

diffstat:=
 drivers/char/sonypi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naurp ./drivers/char/sonypi.c~sonypi_init ./drivers/char/sonypi.c
--- ./drivers/char/sonypi.c~sonypi_init	2004-02-17 19:58:47.000000000 -0800
+++ ./drivers/char/sonypi.c	2004-03-07 14:59:19.000000000 -0800
@@ -129,7 +129,7 @@ static int ec_read16(u8 addr, u16 *value
 }
 
 /* Initializes the device - this comes from the AML code in the ACPI bios */
-static void __devinit sonypi_type1_srs(void) {
+static void sonypi_type1_srs(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -151,7 +151,7 @@ static void __devinit sonypi_type1_srs(v
 	pci_write_config_dword(sonypi_device.dev, SONYPI_G10A, v);
 }
 
-static void __devinit sonypi_type2_srs(void) {
+static void sonypi_type2_srs(void) {
 	if (sonypi_ec_write(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (sonypi_ec_write(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF))
