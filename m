Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280657AbRKBLaP>; Fri, 2 Nov 2001 06:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280658AbRKBLaG>; Fri, 2 Nov 2001 06:30:06 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:62989 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S280657AbRKBL3s>;
	Fri, 2 Nov 2001 06:29:48 -0500
Message-ID: <3BE283AA.7060209@epfl.ch>
Date: Fri, 02 Nov 2001 12:29:46 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] agp for i820 chipset
In-Reply-To: <linux.kernel.3BE25263.9080108@epfl.ch>
Content-Type: multipart/mixed;
 boundary="------------020209040109000506030907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020209040109000506030907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello again

The patch I posted previously lacks the documentation/configure updates. 
Sorry about that. Below is the (hopefully) correct version of the patch...

Nicolas.
PS: My previous question about SBA and FWP still holds ...

-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

--------------020209040109000506030907
Content-Type: text/plain;
 name="agp_i820_2.4.9-6_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="agp_i820_2.4.9-6_v2.patch"

diff -Nru /usr/src/linux-2.4.9-6/Documentation/Configure.help /tmppc41/linux.agp_i820/Documentation/Configure.help
--- /usr/src/linux-2.4.9-6/Documentation/Configure.help	Thu Oct 18 15:00:29 2001
+++ /tmppc41/linux.agp_i820/Documentation/Configure.help	Fri Nov  2 12:27:22 2001
@@ -3092,10 +3092,10 @@
   a module, say M here and read <file:Documentation/modules.txt>.  The
   module will be called agpgart.o.
 
-Intel 440LX/BX/GX/815/840/850 support
+Intel 440LX/BX/GX/815/820/840/850 support
 CONFIG_AGP_INTEL
   This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 840 and 850 chipsets.
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 840 and 850 chipsets.
 
   For the moment, you should probably say N, unless you want to test
   the GLX component for XFree86 3.3.6, which can be downloaded from
diff -Nru /usr/src/linux-2.4.9-6/drivers/char/Config.in /tmppc41/linux.agp_i820/drivers/char/Config.in
--- /usr/src/linux-2.4.9-6/drivers/char/Config.in	Thu Oct 18 15:00:28 2001
+++ /tmppc41/linux.agp_i820/drivers/char/Config.in	Fri Nov  2 11:20:50 2001
@@ -208,7 +208,7 @@
 
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I820/I840/I850 support' CONFIG_AGP_INTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate support' CONFIG_AGP_AMD
diff -Nru /usr/src/linux-2.4.9-6/drivers/char/agp/agp.h /tmppc41/linux.agp_i820/drivers/char/agp/agp.h
--- /usr/src/linux-2.4.9-6/drivers/char/agp/agp.h	Thu Oct 18 15:00:01 2001
+++ /tmppc41/linux.agp_i820/drivers/char/agp/agp.h	Fri Nov  2 08:38:22 2001
@@ -170,6 +170,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_810_0
 #define PCI_DEVICE_ID_INTEL_810_0       0x7120
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_820_0
+#define PCI_DEVICE_ID_INTEL_820_0       0x2500
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_840_0
 #define PCI_DEVICE_ID_INTEL_840_0		0x1a21
 #endif
@@ -188,6 +191,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_810_1
 #define PCI_DEVICE_ID_INTEL_810_1       0x7121
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_820_1
+#define PCI_DEVICE_ID_INTEL_820_1       0x250f
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_1
 #define PCI_DEVICE_ID_INTEL_810_DC100_1 0x7123
 #endif
@@ -242,6 +248,10 @@
 #define INTEL_NBXCFG    0x50
 #define INTEL_ERRSTS    0x91
 
+/* intel i820 registers */
+#define INTEL_I820_RDCR     0x51
+#define INTEL_I820_ERRSTS   0xc8
+
 /* intel i840 registers */
 #define INTEL_I840_MCHCFG   0x50
 #define INTEL_I840_ERRSTS	0xc8
@@ -268,6 +278,7 @@
 #define I810_DRAM_ROW_0        0x00000001
 #define I810_DRAM_ROW_0_SDRAM  0x00000001
 
+
 /* VIA register */
 #define VIA_APBASE      0x10
 #define VIA_GARTCTRL    0x80
diff -Nru /usr/src/linux-2.4.9-6/drivers/char/agp/agpgart_be.c /tmppc41/linux.agp_i820/drivers/char/agp/agpgart_be.c
--- /usr/src/linux-2.4.9-6/drivers/char/agp/agpgart_be.c	Thu Oct 18 15:00:01 2001
+++ /tmppc41/linux.agp_i820/drivers/char/agp/agpgart_be.c	Fri Nov  2 11:26:32 2001
@@ -1188,6 +1188,40 @@
 	return 0;
 }
 
+static int intel_820_configure(void)
+{
+	u32 temp;
+ 	u8 temp2; 
+	aper_size_info_16 *current_size;
+
+	current_size = A_SIZE_16(agp_bridge.current_size);
+
+	/* aperture size */
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      (char)current_size->size_value); 
+
+	/* address to map to */
+	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
+	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* attbase - aperture base */
+	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE,
+			       agp_bridge.gatt_bus_addr); 
+
+	/* agpctrl */
+	pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, 0x0000); 
+
+	/* global enable aperture access */
+	/* This flag is not accessed through MCHCFG register as in */
+	/* i850 chipset. */
+	pci_read_config_byte(agp_bridge.dev, INTEL_I820_RDCR, &temp2);
+	pci_write_config_byte(agp_bridge.dev, INTEL_I820_RDCR, 
+			      temp2 | (1 << 1));
+	/* clear any possible AGP-related error conditions */
+	pci_write_config_word(agp_bridge.dev, INTEL_I820_ERRSTS, 0x001c); 
+	return 0;
+}
+
 static int intel_840_configure(void)
 {
 	u32 temp;
@@ -1314,6 +1348,36 @@
 	(void) pdev; /* unused */
 }
 
+static int __init intel_820_setup (struct pci_dev *pdev)
+{
+       agp_bridge.masks = intel_generic_masks;
+       agp_bridge.num_of_masks = 1;
+       agp_bridge.aperture_sizes = (void *) intel_generic_sizes;
+       agp_bridge.size_type = U16_APER_SIZE;
+       agp_bridge.num_aperture_sizes = 7;
+       agp_bridge.dev_private_data = NULL;
+       agp_bridge.needs_scratch_page = FALSE;
+       agp_bridge.configure = intel_820_configure;
+       agp_bridge.fetch_size = intel_fetch_size;
+       agp_bridge.cleanup = intel_cleanup;
+       agp_bridge.tlb_flush = intel_tlbflush;
+       agp_bridge.mask_memory = intel_mask_memory;
+       agp_bridge.agp_enable = agp_generic_agp_enable;
+       agp_bridge.cache_flush = global_cache_flush;
+       agp_bridge.create_gatt_table = agp_generic_create_gatt_table;
+       agp_bridge.free_gatt_table = agp_generic_free_gatt_table;
+       agp_bridge.insert_memory = agp_generic_insert_memory;
+       agp_bridge.remove_memory = agp_generic_remove_memory;
+       agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
+       agp_bridge.free_by_type = agp_generic_free_by_type;
+       agp_bridge.agp_alloc_page = agp_generic_alloc_page;
+       agp_bridge.agp_destroy_page = agp_generic_destroy_page;
+
+       return 0;
+
+       (void) pdev; /* unused */
+}
+
 static int __init intel_840_setup (struct pci_dev *pdev)
 {
 	agp_bridge.masks = intel_generic_masks;
@@ -2971,6 +3035,12 @@
 		"Intel",
 		"i815",
 		intel_generic_setup },
+	{ PCI_DEVICE_ID_INTEL_820_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I820,
+		"Intel",
+		"i820",
+		intel_820_setup },
 	{ PCI_DEVICE_ID_INTEL_840_0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_I840,
diff -Nru /usr/src/linux-2.4.9-6/drivers/char/drm/drm_agpsupport.h /tmppc41/linux.agp_i820/drivers/char/drm/drm_agpsupport.h
--- /usr/src/linux-2.4.9-6/drivers/char/drm/drm_agpsupport.h	Thu Oct 18 15:00:01 2001
+++ /tmppc41/linux.agp_i820/drivers/char/drm/drm_agpsupport.h	Thu Nov  1 10:50:41 2001
@@ -273,6 +273,7 @@
 
 #if LINUX_VERSION_CODE >= 0x020400
 		case INTEL_I815:	head->chipset = "Intel i815";	 break;
+	        case INTEL_I820:	head->chipset = "Intel i820";    break;
 		case INTEL_I840:	head->chipset = "Intel i840";    break;
 		case INTEL_I850:	head->chipset = "Intel i850";	 break;
 #endif
diff -Nru /usr/src/linux-2.4.9-6/include/linux/agp_backend.h /tmppc41/linux.agp_i820/include/linux/agp_backend.h
--- /usr/src/linux-2.4.9-6/include/linux/agp_backend.h	Thu Oct 18 15:00:08 2001
+++ /tmppc41/linux.agp_i820/include/linux/agp_backend.h	Thu Nov  1 08:36:26 2001
@@ -46,6 +46,7 @@
 	INTEL_GX,
 	INTEL_I810,
 	INTEL_I815,
+	INTEL_I820,
 	INTEL_I840,
 	INTEL_I850,
 	VIA_GENERIC,

--------------020209040109000506030907--

