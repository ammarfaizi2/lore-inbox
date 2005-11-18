Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbVKRDdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbVKRDdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbVKRDdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:33:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58374 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751509AbVKRDdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:33:38 -0500
Date: Fri, 18 Nov 2005 04:33:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/edac/: cleanups
Message-ID: <20051118033337.GV11494@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global code static
- e752x_edac.c: #if 0 the unused sysbus_message


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/edac/amd76x_edac.c  |    2 +-
 drivers/edac/e752x_edac.c   |   12 +++++++-----
 drivers/edac/e7xxx_edac.c   |    2 +-
 drivers/edac/edac_mc.c      |    2 +-
 drivers/edac/i82860_edac.c  |    2 +-
 drivers/edac/i82875p_edac.c |    2 +-
 drivers/edac/r82600_edac.c  |    2 +-
 7 files changed, 13 insertions(+), 11 deletions(-)

--- linux-2.6.15-rc1-mm1-full/drivers/edac/amd76x_edac.c.old	2005-11-18 02:43:09.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/amd76x_edac.c	2005-11-18 02:43:19.000000000 +0100
@@ -338,7 +338,7 @@
 	.id_table = amd76x_pci_tbl,
 };
 
-int __init amd76x_init(void)
+static int __init amd76x_init(void)
 {
 	return pci_module_init(&amd76x_driver);
 }
--- linux-2.6.15-rc1-mm1-full/drivers/edac/e752x_edac.c.old	2005-11-18 02:43:32.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/e752x_edac.c	2005-11-18 02:44:49.000000000 +0100
@@ -376,14 +376,14 @@
 		       mci->mc_idx);
 }
 
-char *global_message[11] = {
+static char *global_message[11] = {
 	"PCI Express C1", "PCI Express C", "PCI Express B1",
 	"PCI Express B", "PCI Express A1", "PCI Express A",
 	"DMA Controler", "HUB Interface", "System Bus",
 	"DRAM Controler", "Internal Buffer"
 };
 
-char *fatal_message[2] = { "Non-Fatal ", "Fatal " };
+static char *fatal_message[2] = { "Non-Fatal ", "Fatal " };
 
 static void do_global_error(int fatal, u32 errors)
 {
@@ -405,7 +405,7 @@
 		do_global_error(fatal, errors);
 }
 
-char *hub_message[7] = {
+static char *hub_message[7] = {
 	"HI Address or Command Parity", "HI Illegal Access",
 	"HI Internal Parity", "Out of Range Access",
 	"HI Data Parity", "Enhanced Config Access",
@@ -432,7 +432,7 @@
 		do_hub_error(fatal, errors);
 }
 
-char *membuf_message[4] = {
+static char *membuf_message[4] = {
 	"Internal PMWB to DRAM parity",
 	"Internal PMWB to System Bus Parity",
 	"Internal System Bus or IO to PMWB Parity",
@@ -458,6 +458,7 @@
 		do_membuf_error(errors);
 }
 
+#if 0
 char *sysbus_message[10] = {
 	"Addr or Request Parity",
 	"Data Strobe Glitch",
@@ -469,6 +470,7 @@
 	"Memory Parity",
 	"IO Subsystem Parity"
 };
+#endif  /*  0  */
 
 static void do_sysbus_error(int fatal, u32 errors)
 {
@@ -1044,7 +1046,7 @@
 };
 
 
-int __init e752x_init(void)
+static int __init e752x_init(void)
 {
 	int pci_rc;
 
--- linux-2.6.15-rc1-mm1-full/drivers/edac/e7xxx_edac.c.old	2005-11-18 02:45:01.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/e7xxx_edac.c	2005-11-18 02:45:12.000000000 +0100
@@ -537,7 +537,7 @@
 };
 
 
-int __init e7xxx_init(void)
+static int __init e7xxx_init(void)
 {
 	return pci_module_init(&e7xxx_driver);
 }
--- linux-2.6.15-rc1-mm1-full/drivers/edac/edac_mc.c.old	2005-11-18 02:45:49.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/edac_mc.c	2005-11-18 02:45:57.000000000 +0100
@@ -1094,7 +1094,7 @@
  * edac_mc_init
  *      module initialization entry point
  */
-int __init edac_mc_init(void)
+static int __init edac_mc_init(void)
 {
 	int ret;
 	struct completion event;
--- linux-2.6.15-rc1-mm1-full/drivers/edac/i82860_edac.c.old	2005-11-18 02:46:16.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/i82860_edac.c	2005-11-18 02:46:25.000000000 +0100
@@ -253,7 +253,7 @@
 	.id_table = i82860_pci_tbl,
 };
 
-int __init i82860_init(void)
+static int __init i82860_init(void)
 {
 	int pci_rc;
 
--- linux-2.6.15-rc1-mm1-full/drivers/edac/i82875p_edac.c.old	2005-11-18 02:46:36.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/i82875p_edac.c	2005-11-18 02:46:43.000000000 +0100
@@ -483,7 +483,7 @@
 };
 
 
-int __init i82875p_init(void)
+static int __init i82875p_init(void)
 {
 	int pci_rc;
 
--- linux-2.6.15-rc1-mm1-full/drivers/edac/r82600_edac.c.old	2005-11-18 02:46:55.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/drivers/edac/r82600_edac.c	2005-11-18 02:47:04.000000000 +0100
@@ -381,7 +381,7 @@
 };
 
 
-int __init r82600_init(void)
+static int __init r82600_init(void)
 {
 	return pci_module_init(&r82600_driver);
 }

