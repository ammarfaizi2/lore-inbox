Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTIITuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTIITuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:50:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53775 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264346AbTIITsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:48:07 -0400
Date: Tue, 9 Sep 2003 20:48:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030909204803.N4216@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

All these drivers are buggy wrt PCI hotplugging/Cardbus/PCI new_id
support and are all potential sources of oops dumps.  You don't need
to have hotplugging enabled to cause your machine to oops with any
of these drivers loaded.

The authors of future drivers doing this will be sent home to write
1000 lines, using pen and paper, of: "I will not use __initdata with
pci_device_id tables."  Printed copies, trick photography, and emails
will not be accepted.

(I'm sending Linus a separate patch since I've already sent him the
AGP fixes.)

--- orig/drivers/char/agp/ati-agp.c	Mon Sep  8 23:36:52 2003
+++ linux/drivers/char/agp/ati-agp.c	Tue Sep  9 20:11:19 2003
@@ -491,7 +491,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_ati_pci_table[] __initdata = {
+static struct pci_device_id agp_ati_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
--- orig/drivers/char/agp/sis-agp.c	Mon Sep  8 23:36:53 2003
+++ linux/drivers/char/agp/sis-agp.c	Tue Sep  9 20:12:38 2003
@@ -215,7 +215,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_sis_pci_table[] __initdata = {
+static struct pci_device_id agp_sis_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
--- orig/drivers/char/agp/uninorth-agp.c	Thu Sep  4 16:36:58 2003
+++ linux/drivers/char/agp/uninorth-agp.c	Tue Sep  9 20:12:38 2003
@@ -350,7 +350,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_uninorth_pci_table[] __initdata = {
+static struct pci_device_id agp_uninorth_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
--- orig/drivers/char/agp/via-agp.c	Mon Sep  8 23:36:53 2003
+++ linux/drivers/char/agp/via-agp.c	Tue Sep  9 20:12:38 2003
@@ -432,7 +432,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_via_pci_table[] __initdata = {
+static struct pci_device_id agp_via_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
--- orig/drivers/char/watchdog/alim1535_wdt.c	Mon Sep  8 23:37:03 2003
+++ linux/drivers/char/watchdog/alim1535_wdt.c	Tue Sep  9 20:45:16 2003
@@ -317,7 +317,7 @@
  *	want to register another driver on the same PCI id.
  */
 
-static struct pci_device_id ali_pci_tbl[] __initdata = {
+static struct pci_device_id ali_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, 1535, PCI_ANY_ID, PCI_ANY_ID,},
 	{ 0, },
 };
--- orig/drivers/char/watchdog/amd7xx_tco.c	Sat Jun 14 22:33:48 2003
+++ linux/drivers/char/watchdog/amd7xx_tco.c	Tue Sep  9 20:45:16 2003
@@ -294,7 +294,7 @@
 	.fops	= &amdtco_fops
 };
 
-static struct pci_device_id amdtco_pci_tbl[] __initdata = {
+static struct pci_device_id amdtco_pci_tbl[] = {
 	/* AMD 766 PCI_IDs here */
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_OPUS_7443, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
--- orig/drivers/char/watchdog/i810-tco.c	Sun Aug  3 11:21:11 2003
+++ linux/drivers/char/watchdog/i810-tco.c	Tue Sep  9 20:45:16 2003
@@ -301,7 +301,7 @@
  * register a pci_driver, because someone else might one day
  * want to register another driver on the same PCI id.
  */
-static struct pci_device_id i810tco_pci_tbl[] __initdata = {
+static struct pci_device_id i810tco_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0,	PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0,	PCI_ANY_ID, PCI_ANY_ID, },
--- orig/drivers/char/hw_random.c	Sat Jun 14 22:33:46 2003
+++ linux/drivers/char/hw_random.c	Tue Sep  9 20:45:16 2003
@@ -149,7 +149,7 @@
  * register a pci_driver, because someone else might one day
  * want to register another driver on the same PCI id.
  */
-static struct pci_device_id rng_pci_tbl[] __initdata = {
+static struct pci_device_id rng_pci_tbl[] = {
 	{ 0x1022, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
 	{ 0x1022, 0x746b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_amd },
 
--- orig/drivers/isdn/hisax/config.c	Sun Aug  3 11:21:16 2003
+++ linux/drivers/isdn/hisax/config.c	Tue Sep  9 20:45:16 2003
@@ -2113,7 +2113,7 @@
 
 #include <linux/pci.h>
 
-static struct pci_device_id hisax_pci_tbl[] __initdata = {
+static struct pci_device_id hisax_pci_tbl[] = {
 #ifdef CONFIG_HISAX_FRITZPCI
 	{PCI_VENDOR_ID_AVM,      PCI_DEVICE_ID_AVM_A1,           PCI_ANY_ID, PCI_ANY_ID},
 #endif
--- orig/drivers/isdn/hysdn/hysdn_init.c	Sat Jun 14 22:33:52 2003
+++ linux/drivers/isdn/hysdn/hysdn_init.c	Tue Sep  9 20:45:16 2003
@@ -21,7 +21,7 @@
 
 #include "hysdn_defs.h"
 
-static struct pci_device_id hysdn_pci_tbl[] __initdata = {
+static struct pci_device_id hysdn_pci_tbl[] = {
 	{PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_HYPERCOPE_PLX, PCI_ANY_ID, PCI_SUBDEVICE_ID_HYPERCOPE_METRO},
 	{PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_HYPERCOPE_PLX, PCI_ANY_ID, PCI_SUBDEVICE_ID_HYPERCOPE_CHAMP2},
 	{PCI_VENDOR_ID_HYPERCOPE, PCI_DEVICE_ID_HYPERCOPE_PLX, PCI_ANY_ID, PCI_SUBDEVICE_ID_HYPERCOPE_ERGO},
--- orig/drivers/net/fc/iph5526.c	Thu Sep  4 16:37:13 2003
+++ linux/drivers/net/fc/iph5526.c	Tue Sep  9 20:45:17 2003
@@ -110,7 +110,7 @@
 #define ALIGNED_ADDR(addr, len) ((((unsigned long)(addr) + (len - 1)) & ~(len - 1)) - (unsigned long)(addr))
 
 
-static struct pci_device_id iph5526_pci_tbl[] __initdata = {
+static struct pci_device_id iph5526_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTERPHASE, PCI_DEVICE_ID_INTERPHASE_5526, PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_INTERPHASE, PCI_DEVICE_ID_INTERPHASE_55x6, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
--- orig/drivers/net/irda/via-ircc.c	Mon Sep  8 23:37:31 2003
+++ linux/drivers/net/irda/via-ircc.c	Tue Sep  9 20:45:17 2003
@@ -121,7 +121,7 @@
 	}
 }
 
-static struct pci_device_id via_pci_tbl[] __initdata = {
+static struct pci_device_id via_pci_tbl[] = {
 	{ PCI_VENDOR_ID_VIA, DeviceID1, PCI_ANY_ID, PCI_ANY_ID,0,0,0 },
 	{ PCI_VENDOR_ID_VIA, DeviceID2, PCI_ANY_ID, PCI_ANY_ID,0,0,1 },
 	{ PCI_VENDOR_ID_VIA, DeviceID3, PCI_ANY_ID, PCI_ANY_ID,0,0,2 },
--- orig/drivers/net/skfp/skfddi.c	Mon Sep  8 23:37:35 2003
+++ linux/drivers/net/skfp/skfddi.c	Tue Sep  9 20:45:17 2003
@@ -182,7 +182,7 @@
 extern void enable_tx_irq(struct s_smc *smc, u_short queue);
 extern void mac_drv_clear_txd(struct s_smc *smc);
 
-static struct pci_device_id skfddi_pci_tbl[] __initdata = {
+static struct pci_device_id skfddi_pci_tbl[] = {
 	{ PCI_VENDOR_ID_SK, PCI_DEVICE_ID_SK_FP, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
 };
--- orig/drivers/net/wan/sdladrv.c	Wed Aug 13 10:33:18 2003
+++ linux/drivers/net/wan/sdladrv.c	Tue Sep  9 20:45:17 2003
@@ -201,7 +201,7 @@
  * Note: All data must be explicitly initialized!!!
  */
 
-static struct pci_device_id sdladrv_pci_tbl[] __initdata = {
+static struct pci_device_id sdladrv_pci_tbl[] = {
 	{ V3_VENDOR_ID, V3_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
 };
--- orig/drivers/net/dgrs.c	Mon Sep  8 23:37:29 2003
+++ linux/drivers/net/dgrs.c	Tue Sep  9 20:45:16 2003
@@ -120,7 +120,7 @@
 #include "dgrs_asstruct.h"
 #include "dgrs_bcomm.h"
 
-static struct pci_device_id dgrs_pci_tbl[] __initdata = {
+static struct pci_device_id dgrs_pci_tbl[] = {
 	{ SE6_PCI_VENDOR_ID, SE6_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, },
 	{ }			/* Terminating entry */
 };
--- orig/drivers/net/hp100.c	Thu Sep  4 16:37:16 2003
+++ linux/drivers/net/hp100.c	Tue Sep  9 20:45:16 2003
@@ -284,7 +284,7 @@
 
 #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))
 
-static struct pci_device_id hp100_pci_tbl[] __initdata = {
+static struct pci_device_id hp100_pci_tbl[] = {
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585A, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585B, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_COMPEX, PCI_DEVICE_ID_COMPEX_ENET100VG4, PCI_ANY_ID, PCI_ANY_ID,},
--- orig/drivers/net/sunhme.c	Mon Sep  8 23:37:36 2003
+++ linux/drivers/net/sunhme.c	Tue Sep  9 20:45:17 2003
@@ -179,7 +179,7 @@
    where it could be referenced at any time due to hot plugging,
    the __initdata reference should be removed. */
 
-struct pci_device_id happymeal_pci_ids[] __initdata = {
+struct pci_device_id happymeal_pci_ids[] = {
 	{
 	  .vendor	= PCI_VENDOR_ID_SUN,
 	  .device	= PCI_DEVICE_ID_SUN_HAPPYMEAL,
--- orig/drivers/video/i810/i810_main.c	Wed Aug 13 10:33:34 2003
+++ linux/drivers/video/i810/i810_main.c	Tue Sep  9 20:45:16 2003
@@ -66,7 +66,7 @@
 	"Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device"
 };
 
-static struct pci_device_id i810fb_pci_tbl[] __initdata = {
+static struct pci_device_id i810fb_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3,

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
