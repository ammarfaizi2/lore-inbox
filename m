Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbUJWQHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUJWQHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbUJWQHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:07:42 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:5093 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261223AbUJWQHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:07:21 -0400
Date: Sun, 24 Oct 2004 01:06:59 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed compile error
Message-Id: <20041024010659.2c4a3f1e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed "causes a section type conflict".

ex.
arch/mips/pci/fixup-mpc30x.c:32: error: irq_tab_mpc30x causes a section type conflict

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-atlas.c a/arch/mips/pci/fixup-atlas.c
--- a-orig/arch/mips/pci/fixup-atlas.c	Sat Oct 23 19:45:31 2004
+++ a/arch/mips/pci/fixup-atlas.c	Sat Oct 23 22:13:00 2004
@@ -9,7 +9,7 @@
 #define SCSI		ATLASINT_SCSI
 #define ETH		ATLASINT_ETH
 
-static char irq_tab[][5] __initdata = {
+static const char irq_tab[][5] __initdata = {
 	/*      INTA    INTB    INTC    INTD */
 	{0,	0,	0,	0,	0 },	/*  0: Unused */
 	{0,	0,	0,	0,	0 },	/*  1: Unused */
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-au1000.c a/arch/mips/pci/fixup-au1000.c
--- a-orig/arch/mips/pci/fixup-au1000.c	Sat Oct 23 19:36:25 2004
+++ a/arch/mips/pci/fixup-au1000.c	Sat Oct 23 22:16:41 2004
@@ -54,14 +54,14 @@
 #define INTX    0xFF /* not valid */
 
 #ifdef CONFIG_MIPS_DB1500
-static char irq_tab_alchemy[][5] __initdata = {
+static const char irq_tab_alchemy[][5] __initdata = {
  [12] =	{ -1, INTA, INTX, INTX, INTX},   /* IDSEL 12 - HPT371   */
  [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
 };
 #endif
 
 #ifdef CONFIG_MIPS_BOSPORUS
-static char irq_tab_alchemy[][5] __initdata = {
+static const char irq_tab_alchemy[][5] __initdata = {
  [11] =	{ -1, INTA, INTB, INTX, INTX},   /* IDSEL 11 - miniPCI  */
  [12] =	{ -1, INTA, INTX, INTX, INTX},   /* IDSEL 12 - SN1741   */
  [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
@@ -69,7 +69,7 @@
 #endif
 
 #ifdef CONFIG_MIPS_MIRAGE
-static char irq_tab_alchemy[][5] __initdata = {
+static const char irq_tab_alchemy[][5] __initdata = {
  [11] =	{ -1, INTD, INTX, INTX, INTX},   /* IDSEL 11 - SMI VGX */
  [12] =	{ -1, INTX, INTX, INTC, INTX},   /* IDSEL 12 - PNX1300 */
  [13] =	{ -1, INTA, INTB, INTX, INTX},   /* IDSEL 13 - miniPCI */
@@ -77,7 +77,7 @@
 #endif
 
 #ifdef CONFIG_MIPS_DB1550
-static char irq_tab_alchemy[][5] __initdata = {
+static const char irq_tab_alchemy[][5] __initdata = {
  [11] =	{ -1, INTC, INTX, INTX, INTX},   /* IDSEL 11 - on-board HPT371    */
  [12] =	{ -1, INTB, INTC, INTD, INTA},   /* IDSEL 12 - PCI slot 2 (left)  */
  [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot 1 (right) */
@@ -85,14 +85,14 @@
 #endif
 
 #ifdef CONFIG_MIPS_PB1500
-static char irq_tab_alchemy[][5] __initdata = {
+static const char irq_tab_alchemy[][5] __initdata = {
  [12] = { -1, INTA, INTX, INTX, INTX},   /* IDSEL 12 - HPT370   */
  [13] = { -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot */
 };
 #endif
 
 #ifdef CONFIG_MIPS_PB1550
-static char irq_tab_alchemy[][5] __initdata = {
+static const char irq_tab_alchemy[][5] __initdata = {
  [12] =	{ -1, INTB, INTC, INTD, INTA},   /* IDSEL 12 - PCI slot 2 (left)  */
  [13] =	{ -1, INTA, INTB, INTC, INTD},   /* IDSEL 13 - PCI slot 1 (right) */
 };
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-capcella.c a/arch/mips/pci/fixup-capcella.c
--- a-orig/arch/mips/pci/fixup-capcella.c	Sat Oct 23 19:38:35 2004
+++ a/arch/mips/pci/fixup-capcella.c	Sat Oct 23 22:15:28 2004
@@ -32,7 +32,7 @@
 #define INTC	PC104PLUS_INTC_IRQ
 #define INTD	PC104PLUS_INTD_IRQ
 
-static char irq_tab_capcella[][5] __initdata = {
+static const int irq_tab_capcella[][5] __initdata = {
  [11] = { -1, INT1, INT1, INT1, INT1 },
  [12] = { -1, INT2, INT2, INT2, INT2 },
  [14] = { -1, INTA, INTB, INTC, INTD }
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-cobalt.c a/arch/mips/pci/fixup-cobalt.c
--- a-orig/arch/mips/pci/fixup-cobalt.c	Sat Oct 23 19:39:08 2004
+++ a/arch/mips/pci/fixup-cobalt.c	Sat Oct 23 22:15:09 2004
@@ -79,7 +79,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GALILEO, PCI_ANY_ID,
 	qube_raq_galileo_fixup);
 
-static char irq_tab_cobalt[] __initdata = {
+static const char irq_tab_cobalt[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
   [COBALT_PCICONF_ETH0]    = COBALT_ETH0_IRQ,
   [COBALT_PCICONF_RAQSCSI] = COBALT_SCSI_IRQ,
@@ -88,7 +88,7 @@
   [COBALT_PCICONF_ETH1]    = COBALT_ETH1_IRQ
 };
 
-static char irq_tab_raq2[] __initdata = {
+static const char irq_tab_raq2[] __initdata = {
   [COBALT_PCICONF_CPU]     = 0,
   [COBALT_PCICONF_ETH0]    = COBALT_ETH0_IRQ,
   [COBALT_PCICONF_RAQSCSI] = COBALT_RAQ_SCSI_IRQ,
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-ev96100.c a/arch/mips/pci/fixup-ev96100.c
--- a-orig/arch/mips/pci/fixup-ev96100.c	Sat Oct 23 19:39:47 2004
+++ a/arch/mips/pci/fixup-ev96100.c	Sat Oct 23 22:14:37 2004
@@ -31,7 +31,7 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 
-static char irq_tab_ev96100[][5] __initdata = {
+static const char irq_tab_ev96100[][5] __initdata = {
  [8] = { 0, 5, 5, 5, 5 },
  [9] = { 0, 2, 2, 2, 2 }
 };
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-ip32.c a/arch/mips/pci/fixup-ip32.c
--- a-orig/arch/mips/pci/fixup-ip32.c	Sat Oct 23 19:43:52 2004
+++ a/arch/mips/pci/fixup-ip32.c	Sat Oct 23 22:13:29 2004
@@ -22,7 +22,7 @@
 #define INTB   MACEPCI_SHARED0_IRQ
 #define INTC   MACEPCI_SHARED1_IRQ
 #define INTD   MACEPCI_SHARED2_IRQ
-static char irq_tab_mace[][5] __initdata = {
+static const char irq_tab_mace[][5] __initdata = {
       /* Dummy  INT#A  INT#B  INT#C  INT#D */
 	{0,         0,     0,     0,     0}, /* This is placeholder row - never used */
 	{0,     SCSI0, SCSI0, SCSI0, SCSI0},
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-ite8172g.c a/arch/mips/pci/fixup-ite8172g.c
--- a-orig/arch/mips/pci/fixup-ite8172g.c	Sat Oct 23 19:40:22 2004
+++ a/arch/mips/pci/fixup-ite8172g.c	Sat Oct 23 22:13:46 2004
@@ -53,7 +53,7 @@
 	IT8172_MC68K_IRQ
 };
 
-static char irq_tab_ite8172g[][5] __initdata = {
+static const char irq_tab_ite8172g[][5] __initdata = {
  [0x10] = {	0, INTA, INTB, INTC, INTD },
  [0x11] = {	0, INTA, INTB, INTC, INTD },
  [0x12] = {	0, INTB, INTC, INTD, INTA },
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-ivr.c a/arch/mips/pci/fixup-ivr.c
--- a-orig/arch/mips/pci/fixup-ivr.c	Sat Oct 23 19:36:24 2004
+++ a/arch/mips/pci/fixup-ivr.c	Sat Oct 23 22:17:00 2004
@@ -54,7 +54,7 @@
 	IT8172_MC68K_IRQ
 };
 
-static char irq_tab_ivr[][5] __initdata = {
+static const char irq_tab_ivr[][5] __initdata = {
  [0x11] = { INTC, INTC, INTD, INTA, INTB },	/* Realtek RTL-8139	*/
  [0x12] = { INTB, INTB, INTB, INTC, INTC },	/* IVR slot		*/
  [0x13] = { INTA, INTA, INTB, INTC, INTD }	/* Expansion slot	*/
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-malta.c a/arch/mips/pci/fixup-malta.c
--- a-orig/arch/mips/pci/fixup-malta.c	Sat Oct 23 19:36:15 2004
+++ a/arch/mips/pci/fixup-malta.c	Sat Oct 23 22:19:11 2004
@@ -8,9 +8,9 @@
 #define PCID		4
 
 /* This table is filled in by interrogating the PIIX4 chip */
-static char pci_irq[5] __initdata;
+static const char pci_irq[5] __initdata;
 
-static char irq_tab[][5] __initdata = {
+static const char irq_tab[][5] __initdata = {
 	/*      INTA    INTB    INTC    INTD */
 	{0,	0,	0,	0,	0 },	/*  0: GT64120 PCI bridge */
 	{0,	0,	0,	0,	0 },	/*  1: Unused */
@@ -51,7 +51,7 @@
 static void __init malta_piix_func0_fixup(struct pci_dev *pdev)
 {
 	unsigned char reg_val;
-	static int piixirqmap[16] __initdata = {  /* PIIX PIRQC[A:D] irq mappings */
+	static const int piixirqmap[16] __initdata = {  /* PIIX PIRQC[A:D] irq mappings */
 		0,  0, 	0,  3,
 		4,  5,  6,  7,
 		0,  9, 10, 11,
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-mpc30x.c a/arch/mips/pci/fixup-mpc30x.c
--- a-orig/arch/mips/pci/fixup-mpc30x.c	Sat Oct 23 19:39:58 2004
+++ a/arch/mips/pci/fixup-mpc30x.c	Sat Oct 23 22:14:19 2004
@@ -29,7 +29,7 @@
 	VRC4173_USB_IRQ,
 };
 
-static char irq_tab_mpc30x[] __initdata = {
+static const int irq_tab_mpc30x[] __initdata = {
  [12] = VRC4173_PCMCIA1_IRQ,
  [13] = VRC4173_PCMCIA2_IRQ,
  [29] = MQ200_IRQ,
diff -urN -X dontdiff a-orig/arch/mips/pci/fixup-sni.c a/arch/mips/pci/fixup-sni.c
--- a-orig/arch/mips/pci/fixup-sni.c	Sat Oct 23 19:37:36 2004
+++ a/arch/mips/pci/fixup-sni.c	Sat Oct 23 22:15:54 2004
@@ -39,7 +39,7 @@
  * seem to be a documentation error.  At least on my RM200C the Cirrus
  * Logic CL-GD5434 VGA is device 3.
  */
-static char irq_tab_rm200[8][5] __initdata = {
+static const char irq_tab_rm200[8][5] __initdata = {
 	/*       INTA  INTB  INTC  INTD */
 	{     0,    0,    0,    0,    0 },	/* EISA bridge */
 	{  SCSI, SCSI, SCSI, SCSI, SCSI },	/* SCSI */
@@ -56,7 +56,7 @@
  *
  * The VGA card is optional for RM300 systems.
  */
-static char irq_tab_rm300d[8][5] __initdata = {
+static const char irq_tab_rm300d[8][5] __initdata = {
 	/*       INTA  INTB  INTC  INTD */
 	{     0,    0,    0,    0,    0 },	/* EISA bridge */
 	{  SCSI, SCSI, SCSI, SCSI, SCSI },	/* SCSI */
