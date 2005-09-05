Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVIESd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVIESd1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVIESdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:33:14 -0400
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:58723 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932392AbVIESc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:32:56 -0400
Message-Id: <20050905183246.782212000@kohtala.home.org>
References: <20050905183109.284672000@kohtala.home.org>
Date: Mon, 05 Sep 2005 21:31:15 +0300
From: marko.kohtala@gmail.com
To: akpm@osdl.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [patch 06/10] parport: ieee1284 fixes and cleanups
Content-Disposition: inline; filename=parport-add-some-missing-const-from-static-variables-in-parport-driver.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial "const" additions to places in parport that truly are const.

Signed-off-by: Marko Kohtala <marko.kohtala@gmail.com>

---

 drivers/parport/parport_pc.c |   38 ++++++++++++++++++++++----------------
 drivers/parport/probe.c      |    6 +++---
 2 files changed, 25 insertions(+), 19 deletions(-)

Index: linux-dvb/drivers/parport/parport_pc.c
===================================================================
--- linux-dvb.orig/drivers/parport/parport_pc.c	2005-06-24 10:41:40.000000000 +0300
+++ linux-dvb/drivers/parport/parport_pc.c	2005-06-24 13:03:46.000000000 +0300
@@ -1170,7 +1170,7 @@ dump_parport_state ("fwd idle", port);
 
 /* GCC is not inlining extern inline function later overwriten to non-inline,
    so we use outlined_ variants here.  */
-static struct parport_operations parport_pc_ops =
+static const struct parport_operations parport_pc_ops =
 {
 	.write_data	= parport_pc_write_data,
 	.read_data	= parport_pc_read_data,
@@ -1212,10 +1212,11 @@ static struct parport_operations parport
 static void __devinit show_parconfig_smsc37c669(int io, int key)
 {
 	int cr1,cr4,cra,cr23,cr26,cr27,i=0;
-	static const char *modes[]={ "SPP and Bidirectional (PS/2)",	
-				     "EPP and SPP",
-				     "ECP",
-				     "ECP and EPP" };
+	static const char *const modes[]={
+		"SPP and Bidirectional (PS/2)",	
+		"EPP and SPP",
+		"ECP",
+		"ECP and EPP" };
 
 	outb(key,io);
 	outb(key,io);
@@ -1289,7 +1290,7 @@ static void __devinit show_parconfig_sms
 static void __devinit show_parconfig_winbond(int io, int key)
 {
 	int cr30,cr60,cr61,cr70,cr74,crf0,i=0;
-	static const char *modes[] = {
+	static const char *const modes[] = {
 		"Standard (SPP) and Bidirectional(PS/2)", /* 0 */
 		"EPP-1.9 and SPP",
 		"ECP",
@@ -1298,7 +1299,9 @@ static void __devinit show_parconfig_win
 		"EPP-1.7 and SPP",		/* 5 */
 		"undefined!",
 		"ECP and EPP-1.7" };
-	static char *irqtypes[] = { "pulsed low, high-Z", "follows nACK" };
+	static char *const irqtypes[] = {
+		"pulsed low, high-Z",
+		"follows nACK" };
 		
 	/* The registers are called compatible-PnP because the
            register layout is modelled after ISA-PnP, the access
@@ -2397,7 +2400,8 @@ EXPORT_SYMBOL (parport_pc_unregister_por
 
 /* ITE support maintained by Rich Liu <richliu@poorman.org> */
 static int __devinit sio_ite_8872_probe (struct pci_dev *pdev, int autoirq,
-					 int autodma, struct parport_pc_via_data *via)
+					 int autodma,
+					 const struct parport_pc_via_data *via)
 {
 	short inta_addr[6] = { 0x2A0, 0x2C0, 0x220, 0x240, 0x1E0 };
 	struct resource *base_res;
@@ -2505,7 +2509,7 @@ static int __devinit sio_ite_8872_probe 
 static int __devinitdata parport_init_mode = 0;
 
 /* Data for two known VIA chips */
-static struct parport_pc_via_data via_686a_data __devinitdata = {
+static const struct parport_pc_via_data via_686a_data __devinitdata = {
 	0x51,
 	0x50,
 	0x85,
@@ -2514,7 +2518,7 @@ static struct parport_pc_via_data via_68
 	0xF0,
 	0xE6
 };
-static struct parport_pc_via_data via_8231_data __devinitdata = {
+static const struct parport_pc_via_data via_8231_data __devinitdata = {
 	0x45,
 	0x44,
 	0x50,
@@ -2525,7 +2529,8 @@ static struct parport_pc_via_data via_82
 };
 
 static int __devinit sio_via_probe (struct pci_dev *pdev, int autoirq,
-					 int autodma, struct parport_pc_via_data *via)
+				    int autodma,
+				    const struct parport_pc_via_data *via)
 {
 	u8 tmp, tmp2, siofunc;
 	u8 ppcontrol = 0;
@@ -2694,9 +2699,10 @@ enum parport_pc_sio_types {
 };
 
 /* each element directly indexed from enum list, above */
-static struct parport_pc_superio {
-	int (*probe) (struct pci_dev *pdev, int autoirq, int autodma, struct parport_pc_via_data *via);
-	struct parport_pc_via_data *via;
+static const struct parport_pc_superio {
+	int (*probe) (struct pci_dev *pdev, int autoirq, int autodma,
+		      const struct parport_pc_via_data *via);
+	const struct parport_pc_via_data *via;
 } parport_pc_superio_info[] __devinitdata = {
 	{ sio_via_probe, &via_686a_data, },
 	{ sio_via_probe, &via_8231_data, },
@@ -2756,7 +2762,7 @@ enum parport_pc_pci_cards {
 
 /* each element directly indexed from enum list, above 
  * (but offset by last_sio) */
-static struct parport_pc_pci {
+static const struct parport_pc_pci {
 	int numports;
 	struct { /* BAR (base address registers) numbers in the config
                     space header */
@@ -2827,7 +2833,7 @@ static struct parport_pc_pci {
 	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
 };
 
-static struct pci_device_id parport_pc_pci_tbl[] = {
+static const struct pci_device_id parport_pc_pci_tbl[] = {
 	/* Super-IO onboard chips */
 	{ 0x1106, 0x0686, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_via_686a },
 	{ 0x1106, 0x8231, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_via_8231 },
Index: linux-dvb/drivers/parport/probe.c
===================================================================
--- linux-dvb.orig/drivers/parport/probe.c	2005-06-24 13:03:46.000000000 +0300
+++ linux-dvb/drivers/parport/probe.c	2005-06-24 13:03:46.000000000 +0300
@@ -11,9 +11,9 @@
 #include <linux/string.h>
 #include <asm/uaccess.h>
 
-static struct {
-	char *token;
-	char *descr;
+static const struct {
+	const char *token;
+	const char *descr;
 } classes[] = {
 	{ "",            "Legacy device" },
 	{ "PRINTER",     "Printer" },

--
