Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTJLHdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 03:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTJLHdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 03:33:18 -0400
Received: from holomorphy.com ([66.224.33.161]:60545 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263429AbTJLHdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 03:33:17 -0400
Date: Sun, 12 Oct 2003 00:36:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: silence smp_read_mpc_oem() declared static but never defined warning
Message-ID: <20031012073628.GA765@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the static function prototype within the calling inline silences
this annoying warning.

diff -prauN linux-2.6.0-test7-bk3/include/asm-i386/mach-numaq/mach_mpparse.h numaq-2.6.0-test7-bk3-1/include/asm-i386/mach-numaq/mach_mpparse.h
--- linux-2.6.0-test7-bk3/include/asm-i386/mach-numaq/mach_mpparse.h	2003-10-08 12:24:04.000000000 -0700
+++ numaq-2.6.0-test7-bk3-1/include/asm-i386/mach-numaq/mach_mpparse.h	2003-10-12 00:22:31.000000000 -0700
@@ -1,9 +1,6 @@
 #ifndef __ASM_MACH_MPPARSE_H
 #define __ASM_MACH_MPPARSE_H
 
-static void __init smp_read_mpc_oem(struct mp_config_oemtable *oemtable,
-		        unsigned short oemsize);
-
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
 				struct mpc_config_translation *translation)
 {
@@ -27,6 +24,7 @@ static inline void mpc_oem_pci_bus(struc
 static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
+	static void smp_read_mpc_oem(struct mp_config_oemtable *, unsigned short);
 	if (strncmp(oem, "IBM NUMA", 8))
 		printk("Warning!  May not be a NUMA-Q system!\n");
 	if (mpc->mpc_oemptr)
