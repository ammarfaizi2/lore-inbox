Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266911AbUAXLkf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUAXLkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 06:40:32 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36813 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266911AbUAXLkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 06:40:31 -0500
Date: Sat, 24 Jan 2004 12:40:16 +0100 (MET)
Message-Id: <200401241140.i0OBeG0G011524@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH] 2.4.25-pre7 load_LDT() bug in setup.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LDT changes in 2.4.25-pre7 are incomplete, resulting in:

setup.c: In function `cpu_init':
setup.c:3194: warning: passing arg 1 of `load_LDT' from incompatible pointer type

in arch/i386/kernel/setup.c. Fix below.

/Mikael

--- linux-2.4.25-pre7/arch/i386/kernel/setup.c.~1~	2004-01-24 11:45:10.000000000 +0100
+++ linux-2.4.25-pre7/arch/i386/kernel/setup.c	2004-01-24 12:18:53.000000000 +0100
@@ -3191,7 +3191,7 @@
 	set_tss_desc(nr,t);
 	gdt_table[__TSS(nr)].b &= 0xfffffdff;
 	load_TR(nr);
-	load_LDT(&init_mm);
+	load_LDT(&init_mm.context);
 
 	/*
 	 * Clear all 6 debug registers:
