Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267867AbUHXOUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267867AbUHXOUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267881AbUHXOUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:20:01 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1408 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267867AbUHXOTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:19:40 -0400
Message-Id: <200408241419.i7OEJVru030232@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: kumar.gala@freescale.com, paulus@samba.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 - #ifdef cleanup for PPC
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-979074621P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 10:19:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-979074621P
Content-Type: text/plain; charset=us-ascii

Another few #if/#ifdef cleanups, this time for the PPC architecture.

Signed-off-by: valdis.kletnieks@vt.edu

--- linux-2.6.9-rc1/arch/ppc/kernel/process.c.ifdef	2004-08-14 01:36:57.000000000 -0400
+++ linux-2.6.9-rc1/arch/ppc/kernel/process.c	2004-08-24 10:17:03.857097999 -0400
@@ -662,7 +662,7 @@ void show_stack(struct task_struct *tsk,
 		++count;
 		sp = *(unsigned long *)sp;
 	}
-#if !CONFIG_KALLSYMS
+#ifndef CONFIG_KALLSYMS
 	if (count > 0)
 		printk("\n");
 #endif
--- linux-2.6.9-rc1/arch/ppc/platforms/85xx/mpc85xx_cds_common.c.ifdef	2004-08-14 01:37:42.000000000 -0400
+++ linux-2.6.9-rc1/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-08-24 10:12:15.501717142 -0400
@@ -307,7 +307,7 @@ mpc85xx_exclude_device(u_char bus, u_cha
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-#if CONFIG_85xx_PCI2
+#ifdef CONFIG_85xx_PCI2
 	/* With the current code we know PCI2 will be bus 2, however this may
 	 * not be guarnteed */
 	if (bus == 2 && PCI_SLOT(devfn) == 0)
--- linux-2.6.9-rc1/arch/ppc/syslib/ppc85xx_setup.c.ifdef	2004-08-14 01:37:41.000000000 -0400
+++ linux-2.6.9-rc1/arch/ppc/syslib/ppc85xx_setup.c	2004-08-24 10:11:16.571016663 -0400
@@ -277,7 +277,7 @@ mpc85xx_setup_hose(void)
 	hose_a->io_space.start = MPC85XX_PCI1_LOWER_IO;
 	hose_a->io_space.end = MPC85XX_PCI1_UPPER_IO;
 	hose_a->io_base_phys = MPC85XX_PCI1_IO_BASE;
-#if CONFIG_85xx_PCI2
+#ifdef CONFIG_85xx_PCI2
 	isa_io_base =
 		(unsigned long) ioremap(MPC85XX_PCI1_IO_BASE,
 					MPC85XX_PCI1_IO_SIZE +
@@ -304,7 +304,7 @@ mpc85xx_setup_hose(void)
 
 	hose_a->last_busno = pciauto_bus_scan(hose_a, hose_a->first_busno);
 
-#if CONFIG_85xx_PCI2
+#ifdef CONFIG_85xx_PCI2
 	hose_b = pcibios_alloc_controller();
 
 	if (!hose_b)



--==_Exmh_-979074621P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBK05zcC3lWbTT17ARAkEzAJ9dc2j0tcVO/omvUNnftQ5pgdErygCeJ7y6
ZKTfZtkz5mgoVqzh8iRBYTE=
=/hCQ
-----END PGP SIGNATURE-----

--==_Exmh_-979074621P--
