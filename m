Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSLJL4w>; Tue, 10 Dec 2002 06:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266487AbSLJL4w>; Tue, 10 Dec 2002 06:56:52 -0500
Received: from nakyup.mizi.com ([203.239.30.70]:61619 "EHLO nakyup.mizi.com")
	by vger.kernel.org with ESMTP id <S266122AbSLJL4t>;
	Tue, 10 Dec 2002 06:56:49 -0500
Date: Tue, 10 Dec 2002 20:55:16 +0900
From: Young-Ho Cha <ganadist@nakyup.mizi.com>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Subject: agpgart kconfig patch for linux-2.5.51
Message-ID: <20021210115516.GA29831@nakyup.mizi.com>
Reply-To: ganadist@chollian.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

in agpgart 1.0 modules, each can be modules, but kconfig set "bool"

and many symbols are not exported.

this is patch against 2.5.51 vanilla



--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.51-agpgart.patch"

diff -uNr linux/drivers/char/agp/Kconfig linux-2.5.51/drivers/char/agp/Kconfig
--- linux/drivers/char/agp/Kconfig	2002-12-10 20:46:41.000000000 +0900
+++ linux-2.5.51/drivers/char/agp/Kconfig	2002-12-10 20:50:23.000000000 +0900
@@ -30,7 +30,7 @@
 	depends on GART_IOMMU
 
 config AGP_INTEL
-	bool "Intel 440LX/BX/GX and I815/I820/I830M/I830MP/I840/I845/I850/I860 support"
+	tristate "Intel 440LX/BX/GX and I815/I820/I830M/I830MP/I840/I845/I850/I860 support"
 	depends on AGP
 	help
 	  This option gives you AGP support for the GLX component of the
@@ -48,7 +48,7 @@
 #	  is required to do any useful video modes with these boards.
 
 config AGP_VIA
-	bool "VIA chipset support"
+	tristate "VIA chipset support"
 	depends on AGP
 	help
 	  This option gives you AGP support for the GLX component of the
@@ -58,7 +58,7 @@
 	  use GLX or DRI.  If unsure, say N.
 
 config AGP_AMD
-	bool "AMD Irongate, 761, and 762 support"
+	tristate "AMD Irongate, 761, and 762 support"
 	depends on AGP
 	help
 	  This option gives you AGP support for the GLX component of the
@@ -68,7 +68,7 @@
 	  use GLX or DRI.  If unsure, say N.
 
 config AGP_SIS
-	bool "Generic SiS support"
+	tristate "Generic SiS support"
 	depends on AGP
 	help
 	  This option gives you AGP support for the GLX component of the "soon
@@ -81,7 +81,7 @@
 	  use GLX or DRI.  If unsure, say N.
 
 config AGP_ALI
-	bool "ALI chipset support"
+	tristate "ALI chipset support"
 	depends on AGP
 	---help---
 	  This option gives you AGP support for the GLX component of the
@@ -99,14 +99,14 @@
 	  use GLX or DRI.  If unsure, say N.
 
 config AGP_SWORKS
-	bool "Serverworks LE/HE support"
+	tristate "Serverworks LE/HE support"
 	depends on AGP
 	help
 	  Say Y here to support the Serverworks AGP card.  See 
 	  <http://www.serverworks.com/> for product descriptions and images.
 
 config AGP_AMD_8151
-	bool "AMD 8151 support"
+	tristate "AMD 8151 support"
 	depends on AGP
 	default GART_IOMMU
 	help
@@ -114,14 +114,14 @@
 	  GART on the AMD Athlon64/Opteron ("Hammer") CPUs.
 
 config AGP_I460
-	bool "Intel 460GX support"
+	tristate "Intel 460GX support"
 	depends on AGP && IA64
 	help
 	  This option gives you AGP GART support for the Intel 460GX chipset
 	  for IA64 processors.
 
 config AGP_HP_ZX1
-	bool "HP ZX1 AGP support"
+	tristate "HP ZX1 AGP support"
 	depends on AGP && IA64
 	help
 	  This option gives you AGP GART support for the HP ZX1 chipset
diff -uNr linux/drivers/char/agp/backend.c linux-2.5.51/drivers/char/agp/backend.c
--- linux/drivers/char/agp/backend.c	2002-12-10 20:46:41.000000000 +0900
+++ linux-2.5.51/drivers/char/agp/backend.c	2002-12-10 20:32:43.000000000 +0900
@@ -286,6 +286,7 @@
 EXPORT_SYMBOL(agp_backend_acquire);
 EXPORT_SYMBOL(agp_backend_release);
 EXPORT_SYMBOL_GPL(agp_register_driver);
+EXPORT_SYMBOL_GPL(agp_unregister_driver);
 
 MODULE_AUTHOR("Dave Jones <davej@codemonkey.org.uk>");
 MODULE_LICENSE("GPL and additional rights");
diff -uNr linux/drivers/char/agp/generic.c linux-2.5.51/drivers/char/agp/generic.c
--- linux/drivers/char/agp/generic.c	2002-12-10 20:46:41.000000000 +0900
+++ linux-2.5.51/drivers/char/agp/generic.c	2002-12-10 20:26:48.000000000 +0900
@@ -693,7 +693,21 @@
 EXPORT_SYMBOL(agp_free_memory);
 EXPORT_SYMBOL(agp_allocate_memory);
 EXPORT_SYMBOL(agp_copy_info);
+EXPORT_SYMBOL(agp_create_memory);
 EXPORT_SYMBOL(agp_bind_memory);
 EXPORT_SYMBOL(agp_unbind_memory);
+EXPORT_SYMBOL(agp_free_key);
 EXPORT_SYMBOL(agp_enable);
-
+EXPORT_SYMBOL(agp_bridge);
+EXPORT_SYMBOL(agp_generic_alloc_page);
+EXPORT_SYMBOL(agp_generic_destroy_page);
+EXPORT_SYMBOL(agp_generic_suspend);
+EXPORT_SYMBOL(agp_generic_resume);
+EXPORT_SYMBOL(agp_generic_agp_enable);
+EXPORT_SYMBOL(agp_generic_create_gatt_table);
+EXPORT_SYMBOL(agp_generic_free_gatt_table);
+EXPORT_SYMBOL(agp_generic_insert_memory);
+EXPORT_SYMBOL(agp_generic_remove_memory);
+EXPORT_SYMBOL(agp_generic_alloc_by_type);
+EXPORT_SYMBOL(agp_generic_free_by_type);
+EXPORT_SYMBOL(global_cache_flush);

--OgqxwSJOaUobr8KG--
