Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267571AbUHXNlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267571AbUHXNlu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHXNlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:41:50 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:56297 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267571AbUHXNlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:41:40 -0400
Message-Id: <200408241341.i7ODfRK7016008@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: kkeil@suse.de
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 - #ifdef fixes for drivers/isdn/hifax/*
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1212390809P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 09:41:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1212390809P
Content-Type: text/plain; charset=us-ascii

Hopefully -rc1 is a good time for small cleanups.. ;)

This patch changes a bunch of '#if CONFIG_PCI' to '#ifdef' instead,
to make the kernel source cleaner for compiling with 'gcc -Wundef'.

As an aside, while doing this cleanup I spotted a number of
obviously null #ifdef/#endif pairs that had absolutely nothing
between them - anybody have a clue what *that* is all about?

--- linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a4t.c.ifdef	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a4t.c	2004-08-24 09:29:46.003834717 -0400
@@ -265,7 +265,7 @@ setup_bkm_a4t(struct IsdnCard *card)
 	char tmp[64];
 	u_int pci_memaddr = 0, found = 0;
 	I20_REGISTER_FILE *pI20_Regs;
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 #endif
 
 	strcpy(tmp, bkm_a4t_revision);
@@ -275,7 +275,7 @@ setup_bkm_a4t(struct IsdnCard *card)
 	} else
 		return (0);
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	while ((dev_a4t = pci_find_device(PCI_VENDOR_ID_ZORAN,
 		PCI_DEVICE_ID_ZORAN_36120, dev_a4t))) {
 		u16 sub_sys;
--- linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a8.c.ifdef	2004-08-14 01:37:39.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a8.c	2004-08-24 09:30:51.656586568 -0400
@@ -21,7 +21,7 @@
 #include <linux/pci.h>
 #include "bkm_ax.h"
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 
 #define	ATTEMPT_PCI_REMAPPING	/* Required for PLX rev 1 */
 
@@ -285,7 +285,7 @@ static u_char pci_irq __initdata = 0;
 int __init
 setup_sct_quadro(struct IsdnCard *card)
 {
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	struct IsdnCardState *cs = card->cs;
 	char tmp[64];
 	u_char pci_rev_id;
--- linux-2.6.9-rc1/drivers/isdn/hisax/diva.c.ifdef	2004-08-14 01:38:04.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/diva.c	2004-08-24 09:31:04.869725312 -0400
@@ -1027,7 +1027,7 @@ setup_diva(struct IsdnCard *card)
 			}
 		}
 #endif
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		cs->subtyp = 0;
 		if ((dev_diva = pci_find_device(PCI_VENDOR_ID_EICON,
 			PCI_DEVICE_ID_EICON_DIVA20, dev_diva))) {
--- linux-2.6.9-rc1/drivers/isdn/hisax/elsa.c.ifdef	2004-08-14 01:36:17.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/elsa.c	2004-08-24 09:28:59.297414044 -0400
@@ -1022,7 +1022,7 @@ setup_elsa(struct IsdnCard *card)
 		       cs->hw.elsa.base,
 		       cs->irq);
 	} else if (cs->typ == ISDN_CTYPE_ELSA_PCI) {
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		cs->subtyp = 0;
 		if ((dev_qs1000 = pci_find_device(PCI_VENDOR_ID_ELSA,
 			PCI_DEVICE_ID_ELSA_MICROLINK, dev_qs1000))) {
--- linux-2.6.9-rc1/drivers/isdn/hisax/enternow_pci.c.ifdef	2004-08-14 01:37:38.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/enternow_pci.c	2004-08-24 09:30:36.606706557 -0400
@@ -299,7 +299,7 @@ setup_enternow_pci(struct IsdnCard *card
 	struct IsdnCardState *cs = card->cs;
 	char tmp[64];
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 #ifdef __BIG_ENDIAN
 #error "not running on big endian machines now"
 #endif
--- linux-2.6.9-rc1/drivers/isdn/hisax/gazel.c.ifdef	2004-08-14 01:36:59.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/gazel.c	2004-08-24 09:30:17.574387534 -0400
@@ -634,7 +634,7 @@ setup_gazel(struct IsdnCard *card)
 			return (0);
 	} else {
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		if (setup_gazelpci(cs))
 			return (0);
 #else
--- linux-2.6.9-rc1/drivers/isdn/hisax/hfc_pci.c.ifdef	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/hfc_pci.c	2004-08-24 09:30:05.104144152 -0400
@@ -65,7 +65,7 @@ static const PCI_ENTRY id_list[] =
 };
 
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 
 /******************************************/
 /* free hardware resources used by driver */
@@ -1655,7 +1655,7 @@ setup_hfcpci(struct IsdnCard *card)
 #endif
 	strcpy(tmp, hfcpci_revision);
 	printk(KERN_INFO "HiSax: HFC-PCI driver Rev. %s\n", HiSax_getrev(tmp));
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	cs->hw.hfcpci.int_s1 = 0;
 	cs->dc.hfcpci.ph_state = 0;
 	cs->hw.hfcpci.fifo = 255;
--- linux-2.6.9-rc1/drivers/isdn/hisax/niccy.c.ifdef	2004-08-14 01:36:56.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/niccy.c	2004-08-24 09:29:30.065079935 -0400
@@ -309,7 +309,7 @@ setup_niccy(struct IsdnCard *card)
 			return (0);
 		}
 	} else {
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		u_int pci_ioaddr;
 		cs->subtyp = 0;
 		if ((niccy_dev = pci_find_device(PCI_VENDOR_ID_SATSAGEM,
--- linux-2.6.9-rc1/drivers/isdn/hisax/nj_s.c.ifdef	2004-08-14 01:36:33.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/nj_s.c	2004-08-24 09:29:22.592132616 -0400
@@ -167,7 +167,7 @@ setup_netjet_s(struct IsdnCard *card)
 		return(0);
 	test_and_clear_bit(FLG_LOCK_ATOMIC, &cs->HW_Flags);
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 
 	for ( ;; )
 	{
--- linux-2.6.9-rc1/drivers/isdn/hisax/nj_u.c.ifdef	2004-08-14 01:36:32.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/nj_u.c	2004-08-24 09:31:36.739236058 -0400
@@ -137,7 +137,7 @@ setup_netjet_u(struct IsdnCard *card)
 	int bytecnt;
 	struct IsdnCardState *cs = card->cs;
 	char tmp[64];
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 #endif
 #ifdef __BIG_ENDIAN
 #error "not running on big endian machines now"
@@ -148,7 +148,7 @@ setup_netjet_u(struct IsdnCard *card)
 		return(0);
 	test_and_clear_bit(FLG_LOCK_ATOMIC, &cs->HW_Flags);
 
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 
 	for ( ;; )
 	{
--- linux-2.6.9-rc1/drivers/isdn/hisax/sedlbauer.c.ifdef	2004-08-14 01:38:08.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/sedlbauer.c	2004-08-24 09:31:11.044855460 -0400
@@ -618,7 +618,7 @@ setup_sedlbauer(struct IsdnCard *card)
 		}
 #endif
 /* Probe for Sedlbauer speed pci */
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 		if ((dev_sedl = pci_find_device(PCI_VENDOR_ID_TIGERJET,
 				PCI_DEVICE_ID_TIGERJET_100, dev_sedl))) {
 			if (pci_enable_device(dev_sedl))
--- linux-2.6.9-rc1/drivers/isdn/hisax/telespci.c.ifdef	2004-08-14 01:37:25.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/telespci.c	2004-08-24 09:30:27.559980918 -0400
@@ -300,7 +300,7 @@ setup_telespci(struct IsdnCard *card)
 	printk(KERN_INFO "HiSax: Teles/PCI driver Rev. %s\n", HiSax_getrev(tmp));
 	if (cs->typ != ISDN_CTYPE_TELESPCI)
 		return (0);
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	if ((dev_tel = pci_find_device (PCI_VENDOR_ID_ZORAN, PCI_DEVICE_ID_ZORAN_36120, dev_tel))) {
 		if (pci_enable_device(dev_tel))
 			return(0);
--- linux-2.6.9-rc1/drivers/isdn/hisax/w6692.c.ifdef	2004-08-14 01:37:40.000000000 -0400
+++ linux-2.6.9-rc1/drivers/isdn/hisax/w6692.c	2004-08-24 09:30:58.456628686 -0400
@@ -1012,7 +1012,7 @@ setup_w6692(struct IsdnCard *card)
 	printk(KERN_INFO "HiSax: W6692 driver Rev. %s\n", HiSax_getrev(tmp));
 	if (cs->typ != ISDN_CTYPE_W6692)
 		return (0);
-#if CONFIG_PCI
+#ifdef CONFIG_PCI
 	while (id_list[id_idx].vendor_id) {
 		dev_w6692 = pci_find_device(id_list[id_idx].vendor_id,
 					    id_list[id_idx].device_id,



--==_Exmh_-1212390809P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBK0WHcC3lWbTT17ARArXvAKDsg/VU9eJR3gxpjSthdpVrNqtqWQCgsknh
ccHundp9jtuubnoD/aeupj0=
=vEt5
-----END PGP SIGNATURE-----

--==_Exmh_-1212390809P--
