Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVADEz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVADEz2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVADEzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:55:15 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:32712 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262045AbVADEpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:45:13 -0500
Date: Tue, 4 Jan 2005 15:37:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/11] PPC64: use xPMCRegsInUse
Message-Id: <20050104153740.56622b4f.sfr@canb.auug.org.au>
In-Reply-To: <20050104153445.3777e689.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
	<20050104151229.521e8083.sfr@canb.auug.org.au>
	<20050104151906.6e50f1d2.sfr@canb.auug.org.au>
	<20050104152340.67219ccf.sfr@canb.auug.org.au>
	<20050104152705.6030abc5.sfr@canb.auug.org.au>
	<20050104153102.67284491.sfr@canb.auug.org.au>
	<20050104153445.3777e689.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_37_40_+1100_cLuV9_wN5ybBRky/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_37_40_+1100_cLuV9_wN5ybBRky/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This fixes an aweful piece of code that could have just referenced
xPMCRegsInUse in the lppaca structure.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.8/arch/ppc64/kernel/sysfs.c linus-bk-naca.9/arch/ppc64/kernel/sysfs.c
--- linus-bk-naca.8/arch/ppc64/kernel/sysfs.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.9/arch/ppc64/kernel/sysfs.c	2004-12-13 14:49:37.000000000 +1100
@@ -14,6 +14,8 @@
 #include <asm/hvcall.h>
 #include <asm/prom.h>
 #include <asm/systemcfg.h>
+#include <asm/paca.h>
+#include <asm/iSeries/ItLpPaca.h>
 
 
 /* SMT stuff */
@@ -154,10 +156,8 @@
 
 #ifdef CONFIG_PPC_PSERIES
 	/* instruct hypervisor to maintain PMCs */
-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-		char *ptr = (char *)&paca[smp_processor_id()].lppaca;
-		ptr[0xBB] = 1;
-	}
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
+		get_paca()->lppaca.xPMCRegsInUse = 1;
 
 	/*
 	 * On SMT machines we have to set the run latch in the ctrl register

--Signature=_Tue__4_Jan_2005_15_37_40_+1100_cLuV9_wN5ybBRky/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2h2U4CJfqux9a+8RAm/UAJ96J32tsS2r7JE7N/IzotDD1n+BrgCeNcXv
akaFXpMr/fOiYANtKQbh4gI=
=lyOk
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_37_40_+1100_cLuV9_wN5ybBRky/--
