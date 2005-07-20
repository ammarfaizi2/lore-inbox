Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVGTIc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVGTIc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 04:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVGTIc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 04:32:26 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:47254 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261431AbVGTIcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 04:32:06 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Nils Faerber <nils@kernelconcepts.de>
Subject: [PATCH] remove unneeded indentation in drivers/char/watchdog/i8xx_tco.c
Date: Wed, 20 Jul 2005 10:36:19 +0200
User-Agent: KMail/1.8.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201036.20165@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch changes a bit of indentation. Currently it is

if (i8xx_tcp_pci) {
...
	return 1;
}
return 0;

Now it will be

if (!i8xx_tcp_pci)
	return 0;
...
return 1;

Also some superfluous spaces are killed to match Codingstyle.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.13-rc3/drivers/char/watchdog/i8xx_tco.c	2005-07-13 06:46:46.000000000 +0200
+++ linux-2.6.13-rc3-eike/drivers/char/watchdog/i8xx_tco.c	2005-07-20 10:22:18.000000000 +0200
@@ -391,7 +391,7 @@ MODULE_DEVICE_TABLE (pci, i8xx_tco_pci_t
  *	Init & exit routines
  */
 
-static unsigned char __init i8xx_tco_getdevice (void)
+static unsigned char __init i8xx_tco_getdevice(void)
 {
 	struct pci_dev *dev = NULL;
 	u8 val1, val2;
@@ -407,47 +407,47 @@ static unsigned char __init i8xx_tco_get
 		}
 	}
 
-	if (i8xx_tco_pci) {
-		/*
-		 *      Find the ACPI base I/O address which is the base
-		 *      for the TCO registers (TCOBASE=ACPIBASE + 0x60)
-		 *      ACPIBASE is bits [15:7] from 0x40-0x43
-		 */
-		pci_read_config_byte (i8xx_tco_pci, 0x40, &val1);
-		pci_read_config_byte (i8xx_tco_pci, 0x41, &val2);
-		badr = ((val2 << 1) | (val1 >> 7)) << 7;
-		ACPIBASE = badr;
-		/* Something's wrong here, ACPIBASE has to be set */
-		if (badr == 0x0001 || badr == 0x0000) {
-			printk (KERN_ERR PFX "failed to get TCOBASE address\n");
-			return 0;
-		}
-		/*
-		 * Check chipset's NO_REBOOT bit
-		 */
+	if (!i8xx_tco_pci)
+		return 0;
+
+	/*
+	 *      Find the ACPI base I/O address which is the base
+	 *      for the TCO registers (TCOBASE=ACPIBASE + 0x60)
+	 *      ACPIBASE is bits [15:7] from 0x40-0x43
+	 */
+	pci_read_config_byte(i8xx_tco_pci, 0x40, &val1);
+	pci_read_config_byte(i8xx_tco_pci, 0x41, &val2);
+	badr = ((val2 << 1) | (val1 >> 7)) << 7;
+	ACPIBASE = badr;
+	/* Something's wrong here, ACPIBASE has to be set */
+	if (badr == 0x0001 || badr == 0x0000) {
+		printk(KERN_ERR PFX "failed to get TCOBASE address\n");
+		return 0;
+	}
+	/*
+	 * Check chipset's NO_REBOOT bit
+	 */
+	pci_read_config_byte(i8xx_tco_pci, 0xd4, &val1);
+	if (val1 & 0x02) {
+		val1 &= 0xfd;
+		pci_write_config_byte(i8xx_tco_pci, 0xd4, val1);
 		pci_read_config_byte (i8xx_tco_pci, 0xd4, &val1);
 		if (val1 & 0x02) {
-			val1 &= 0xfd;
-			pci_write_config_byte (i8xx_tco_pci, 0xd4, val1);
-			pci_read_config_byte (i8xx_tco_pci, 0xd4, &val1);
-			if (val1 & 0x02) {
-				printk (KERN_ERR PFX "failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
-				return 0;	/* Cannot reset NO_REBOOT bit */
-			}
-		}
-		/* Set the TCO_EN bit in SMI_EN register */
-		if (!request_region (SMI_EN + 1, 1, "i8xx TCO")) {
-			printk (KERN_ERR PFX "I/O address 0x%04x already in use\n",
-				SMI_EN + 1);
-			return 0;
+			printk(KERN_ERR PFX "failed to reset NO_REBOOT flag, reboot disabled by hardware\n");
+			return 0;	/* Cannot reset NO_REBOOT bit */
 		}
-		val1 = inb (SMI_EN + 1);
-		val1 &= 0xdf;
-		outb (val1, SMI_EN + 1);
-		release_region (SMI_EN + 1, 1);
-		return 1;
 	}
-	return 0;
+	/* Set the TCO_EN bit in SMI_EN register */
+	if (!request_region(SMI_EN + 1, 1, "i8xx TCO")) {
+		printk(KERN_ERR PFX "I/O address 0x%04x already in use\n",
+			SMI_EN + 1);
+		return 0;
+	}
+	val1 = inb(SMI_EN + 1);
+	val1 &= 0xdf;
+	outb(val1, SMI_EN + 1);
+	release_region(SMI_EN + 1, 1);
+	return 1;
 }
 
 static int __init watchdog_init (void)
