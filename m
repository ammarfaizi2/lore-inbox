Return-Path: <linux-kernel-owner+w=401wt.eu-S1030306AbXAMXKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbXAMXKX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXAMXKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:10:23 -0500
Received: from gw.goop.org ([64.81.55.164]:59872 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030306AbXAMXKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:10:22 -0500
Message-Id: <20070113014647.240188180@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:41 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Gerd Hoffmann <kraxel@suse.de>
Subject: [patch 02/20] XEN-paravirt: Add a flag to allow the VGA console to be disabled
Content-Disposition: inline; filename=vgacon-enable-flag.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a flag to allow the VGA console to be disabled.  The VGA code will
spin forever if there isn't any real VGA hardware, which will happen
under Xen.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Gerd Hoffmann <kraxel@suse.de>
Cc: Andrew Morton <akpm@osdl.org>

===================================================================
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -71,6 +71,9 @@ unsigned long init_pg_tables_end __initd
 
 int disable_pse __devinitdata = 0;
 
+/* use to runtime disable vga_con */
+int vgacon_enabled = 1;
+ 
 /*
  * Machine setup..
  */
@@ -652,7 +655,7 @@ void __init setup_arch(char **cmdline_p)
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-	if (!efi_enabled || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY))
+	if (vgacon_enabled && (!efi_enabled || (efi_mem_type(0xa0000) != EFI_CONVENTIONAL_MEMORY)))
 		conswitchp = &vga_con;
 #elif defined(CONFIG_DUMMY_CONSOLE)
 	conswitchp = &dummy_con;
===================================================================
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -77,6 +77,8 @@ void __init add_memory_region(unsigned l
 void __init add_memory_region(unsigned long long start,
 			      unsigned long long size, int type);
 
+extern int vgacon_enabled;
+
 #endif /* __ASSEMBLY__ */
 
 #endif  /*  __KERNEL__  */

-- 

