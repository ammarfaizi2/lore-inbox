Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSKZGAP>; Tue, 26 Nov 2002 01:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbSKZGAP>; Tue, 26 Nov 2002 01:00:15 -0500
Received: from gettysburg.edu ([138.234.4.100]:24009 "EHLO gettysburg.edu")
	by vger.kernel.org with ESMTP id <S266183AbSKZGAN>;
	Tue, 26 Nov 2002 01:00:13 -0500
Date: Tue, 26 Nov 2002 01:07:27 -0500
To: linux-kernel@vger.kernel.org, fdavis@si.rr.com,
       justinpryzby@users.sourceforge.net
Subject: Re: [PATCH] 2.5.49-ac1 : include/asm-386/io_apic.h
Message-ID: <20021126060727.GA28353@perseus.homeunix.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I had to work a slightly larger patch than Frank.  Note that I am assuming that
s/PCI_VENDOR_ID_SIS/PCI_VENDOR_ID_SI/ is correct, as PCI_VENDOR_ID_SIS shows up
nowhere in the kernel tree.

Please CC me in all replies.

Justin


diff -Naur linux.2.5.49-ac1/drivers/pci/quirks.c linux.2.5.49-ac1-jp/drivers/pci/quirks.c
--- linux.2.5.49-ac1/drivers/pci/quirks.c	2002-11-26 00:28:18.000000000 -0500
+++ linux.2.5.49-ac1-jp/drivers/pci/quirks.c	2002-11-26 00:20:47.000000000 -0500
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
+static int sis_apic_bug;
+
 #undef DEBUG
 
 /* Deal with broken BIOS'es that neglect to enable passive release,
@@ -351,7 +353,7 @@
 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if(dev->devfn == 0 && dev->bus->number == 0)
-		apic_sys_bug = 1;
+		sis_apic_bug = 1;
 }
 
 
@@ -561,7 +563,7 @@
 #ifdef CONFIG_X86_IO_APIC 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
 	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SIS,	PCI_ANY_ID,			quirk_ioapic_rmw },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw },
 #endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
diff -Naur linux.2.5.49-ac1/include/asm-i386/io_apic.h linux.2.5.49-ac1-jp/include/asm-i386/io_apic.h
--- linux.2.5.49-ac1/include/asm-i386/io_apic.h	2002-11-26 00:28:19.000000000 -0500
+++ linux.2.5.49-ac1-jp/include/asm-i386/io_apic.h	2002-11-25 23:57:35.000000000 -0500
@@ -11,6 +11,8 @@
  * Copyright (C) 1997, 1998, 1999, 2000 Ingo Molnar
  */
 
+extern int sis_apic_bug;
+
 #ifdef CONFIG_X86_IO_APIC
 
 #define APIC_MISMATCH_DEBUG

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Description: Patch for undefined: acpi_sis_bug
Content-Disposition: attachment; filename="linux-2.5.49-ac1"

diff -Naur linux.2.5.49-ac1/drivers/pci/quirks.c linux.2.5.49-ac1-jp/drivers/pci/quirks.c
--- linux.2.5.49-ac1/drivers/pci/quirks.c	2002-11-26 00:28:18.000000000 -0500
+++ linux.2.5.49-ac1-jp/drivers/pci/quirks.c	2002-11-26 00:20:47.000000000 -0500
@@ -19,6 +19,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
+static int sis_apic_bug;
+
 #undef DEBUG
 
 /* Deal with broken BIOS'es that neglect to enable passive release,
@@ -351,7 +353,7 @@
 static void __init quirk_ioapic_rmw(struct pci_dev *dev)
 {
 	if(dev->devfn == 0 && dev->bus->number == 0)
-		apic_sys_bug = 1;
+		sis_apic_bug = 1;
 }
 
 
@@ -561,7 +563,7 @@
 #ifdef CONFIG_X86_IO_APIC 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },
 	{ PCI_FIXUP_FINAL, 	PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_VIPER_7410,	quirk_amd_ioapic },
-	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SIS,	PCI_ANY_ID,			quirk_ioapic_rmw },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw },
 #endif
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi },
diff -Naur linux.2.5.49-ac1/include/asm-i386/io_apic.h linux.2.5.49-ac1-jp/include/asm-i386/io_apic.h
--- linux.2.5.49-ac1/include/asm-i386/io_apic.h	2002-11-26 00:28:19.000000000 -0500
+++ linux.2.5.49-ac1-jp/include/asm-i386/io_apic.h	2002-11-25 23:57:35.000000000 -0500
@@ -11,6 +11,8 @@
  * Copyright (C) 1997, 1998, 1999, 2000 Ingo Molnar
  */
 
+extern int sis_apic_bug;
+
 #ifdef CONFIG_X86_IO_APIC
 
 #define APIC_MISMATCH_DEBUG

--u3/rZRmxL6MmkK24--
