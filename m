Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317940AbSGKXQE>; Thu, 11 Jul 2002 19:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317941AbSGKXQD>; Thu, 11 Jul 2002 19:16:03 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:61957 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317940AbSGKXP0>;
	Thu, 11 Jul 2002 19:15:26 -0400
Date: Thu, 11 Jul 2002 16:18:05 -0700
From: Greg KH <greg@kroah.com>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020711231804.GA5635@kroah.com>
References: <20020711230222.GA5143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020711230222.GA5143@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 13 Jun 2002 22:10:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here's the version against the 2.5.25-dj1 tree.  Dave, will you
please add it to your tree?

thanks,

greg k-h


diff -Nru a/drivers/char/Config.help b/drivers/char/Config.help
--- a/drivers/char/Config.help	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/Config.help	Thu Jul 11 16:15:37 2002
@@ -91,93 +91,6 @@
   The module will be called mwave.o. If you want to compile it as
   a module, say M here and read Documentation/modules.txt.
 
-CONFIG_AGP
-  AGP (Accelerated Graphics Port) is a bus system mainly used to
-  connect graphics cards to the rest of the system.
-
-  If you have an AGP system and you say Y here, it will be possible to
-  use the AGP features of your 3D rendering video card. This code acts
-  as a sort of "AGP driver" for the motherboard's chipset.
-
-  If you need more texture memory than you can get with the AGP GART
-  (theoretically up to 256 MB, but in practice usually 64 or 128 MB
-  due to kernel allocation issues), you could use PCI accesses
-  and have up to a couple gigs of texture space.
-
-  Note that this is the only means to have XFree4/GLX use
-  write-combining with MTRR support on the AGP bus. Without it, OpenGL
-  direct rendering will be a lot slower but still faster than PIO.
-
-  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-  use GLX or DRI.  If unsure, say N.
-
-  This driver is available as a module.  If you want to compile it as
-  a module, say M here and read <file:Documentation/modules.txt>.  The
-  module will be called agpgart.o.
-
-CONFIG_AGP_INTEL
-  This option gives you AGP support for the GLX component of the
-  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860 chipsets.
-
-  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-  use GLX or DRI.  If unsure, say N.
-
-CONFIG_AGP_I810
-  This option gives you AGP support for the Xserver on the Intel 810
-  815 and 830m chipset boards for their on-board integrated graphics. This
-  is required to do any useful video modes with these boards.
-
-CONFIG_AGP_I460
-  This option gives you AGP GART support for the Intel 460GX chipset
-  for IA64 processors.
-
-CONFIG_AGP_VIA
-  This option gives you AGP support for the GLX component of the
-  XFree86 4.x on VIA MPV3/Apollo Pro chipsets.
-
-  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-  use GLX or DRI.  If unsure, say N.
-
-CONFIG_AGP_AMD
-  This option gives you AGP support for the GLX component of the
-  XFree86 4.x on AMD Irongate, 761, and 762 chipsets.
-
-  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-  use GLX or DRI.  If unsure, say N.
-
-CONFIG_AGP_SIS
-  This option gives you AGP support for the GLX component of the "soon
-  to be released" XFree86 4.x on Silicon Integrated Systems [SiS]
-  chipsets.
-
-  Note that 5591/5592 AGP chipsets are NOT supported.
-
-  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-  use GLX or DRI.  If unsure, say N.
-
-CONFIG_AGP_SWORKS
-  Say Y here to support the Serverworks AGP card.  See 
-  <http://www.serverworks.com/> for product descriptions and images.
-
-CONFIG_AGP_ALI
-  This option gives you AGP support for the GLX component of the
-  XFree86 4.x on the following ALi chipsets.  The supported chipsets
-  include M1541, M1621, M1631, M1632, M1641,M1647,and M1651.
-  For the ALi-chipset question, ALi suggests you refer to
-  <http://www.ali.com.tw/eng/support/index.shtml>.
-
-  The M1541 chipset can do AGP 1x and 2x, but note that there is an
-  acknowledged incompatibility with Matrox G200 cards. Due to
-  timing issues, this chipset cannot do AGP 2x with the G200.
-  This is a hardware limitation. AGP 1x seems to be fine, though.
-
-  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
-  use GLX or DRI.  If unsure, say N.
-
-CONFIG_AGP_HP_ZX1
-  This option gives you AGP GART support for the HP ZX1 chipset
-  for IA64 processors.
-
 CONFIG_I810_TCO
   Hardware driver for the TCO timer built into the Intel i810 and i815
   chipset family.  The TCO (Total Cost of Ownership) timer is a
diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/Config.in	Thu Jul 11 16:15:37 2002
@@ -210,20 +210,7 @@
 fi
 endmenu
 
-dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
-if [ "$CONFIG_AGP" != "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I820/I830M/I830MP/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
-   bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
-   bool '  VIA chipset support' CONFIG_AGP_VIA
-   bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
-   bool '  Generic SiS support' CONFIG_AGP_SIS
-   bool '  ALI chipset support' CONFIG_AGP_ALI
-   bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
-   if [ "$CONFIG_IA64" = "y" ]; then
-     bool '  Intel 460GX support' CONFIG_AGP_I460
-     bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
-   fi
-fi
+source drivers/char/agp/Config.in
 
 source drivers/char/drm/Config.in
 
diff -Nru a/drivers/char/agp/Config.help b/drivers/char/agp/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/agp/Config.help	Thu Jul 11 16:15:37 2002
@@ -0,0 +1,88 @@
+CONFIG_AGP
+  AGP (Accelerated Graphics Port) is a bus system mainly used to
+  connect graphics cards to the rest of the system.
+
+  If you have an AGP system and you say Y here, it will be possible to
+  use the AGP features of your 3D rendering video card. This code acts
+  as a sort of "AGP driver" for the motherboard's chipset.
+
+  If you need more texture memory than you can get with the AGP GART
+  (theoretically up to 256 MB, but in practice usually 64 or 128 MB
+  due to kernel allocation issues), you could use PCI accesses
+  and have up to a couple gigs of texture space.
+
+  Note that this is the only means to have XFree4/GLX use
+  write-combining with MTRR support on the AGP bus. Without it, OpenGL
+  direct rendering will be a lot slower but still faster than PIO.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
+  This driver is available as a module.  If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.  The
+  module will be called agpgart.o.
+
+CONFIG_AGP_INTEL
+  This option gives you AGP support for the GLX component of the
+  XFree86 4.x on Intel 440LX/BX/GX, 815, 820, 830, 840, 845, 850 and 860 chipsets.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
+CONFIG_AGP_I810
+  This option gives you AGP support for the Xserver on the Intel 810
+  815 and 830m chipset boards for their on-board integrated graphics. This
+  is required to do any useful video modes with these boards.
+
+CONFIG_AGP_I460
+  This option gives you AGP GART support for the Intel 460GX chipset
+  for IA64 processors.
+
+CONFIG_AGP_VIA
+  This option gives you AGP support for the GLX component of the
+  XFree86 4.x on VIA MPV3/Apollo Pro chipsets.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
+CONFIG_AGP_AMD
+  This option gives you AGP support for the GLX component of the
+  XFree86 4.x on AMD Irongate, 761, and 762 chipsets.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
+CONFIG_AGP_SIS
+  This option gives you AGP support for the GLX component of the "soon
+  to be released" XFree86 4.x on Silicon Integrated Systems [SiS]
+  chipsets.
+
+  Note that 5591/5592 AGP chipsets are NOT supported.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
+CONFIG_AGP_SWORKS
+  Say Y here to support the Serverworks AGP card.  See 
+  <http://www.serverworks.com/> for product descriptions and images.
+
+CONFIG_AGP_ALI
+  This option gives you AGP support for the GLX component of the
+  XFree86 4.x on the following ALi chipsets.  The supported chipsets
+  include M1541, M1621, M1631, M1632, M1641,M1647,and M1651.
+  For the ALi-chipset question, ALi suggests you refer to
+  <http://www.ali.com.tw/eng/support/index.shtml>.
+
+  The M1541 chipset can do AGP 1x and 2x, but note that there is an
+  acknowledged incompatibility with Matrox G200 cards. Due to
+  timing issues, this chipset cannot do AGP 2x with the G200.
+  This is a hardware limitation. AGP 1x seems to be fine, though.
+
+  You should say Y here if you use XFree86 3.3.6 or 4.x and want to
+  use GLX or DRI.  If unsure, say N.
+
+CONFIG_AGP_HP_ZX1
+  This option gives you AGP GART support for the HP ZX1 chipset
+  for IA64 processors.
+
+
diff -Nru a/drivers/char/agp/Config.in b/drivers/char/agp/Config.in
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/agp/Config.in	Thu Jul 11 16:15:37 2002
@@ -0,0 +1,14 @@
+dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
+if [ "$CONFIG_AGP" != "n" ]; then
+   bool '  Intel 440LX/BX/GX and I815/I820/I830M/I830MP/I840/I845/I850/I860 support' CONFIG_AGP_INTEL
+   bool '  Intel I810/I815/I830M (on-board) support' CONFIG_AGP_I810
+   bool '  VIA chipset support' CONFIG_AGP_VIA
+   bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
+   bool '  Generic SiS support' CONFIG_AGP_SIS
+   bool '  ALI chipset support' CONFIG_AGP_ALI
+   bool '  Serverworks LE/HE support' CONFIG_AGP_SWORKS
+   if [ "$CONFIG_IA64" = "y" ]; then
+     bool '  Intel 460GX support' CONFIG_AGP_I460
+     bool '  HP ZX1 AGP support' CONFIG_AGP_HP_ZX1
+   fi
+fi
diff -Nru a/drivers/char/agp/Makefile b/drivers/char/agp/Makefile
--- a/drivers/char/agp/Makefile	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/Makefile	Thu Jul 11 16:15:37 2002
@@ -7,14 +7,14 @@
 
 agpgart-y := agpgart_fe.o agpgart_be.o
 
-agpgart-$(CONFIG_AGP_INTEL)		+=	agpgart_be-i8x0.o
-agpgart-$(CONFIG_AGP_I810)		+=	agpgart_be-i810.o
-agpgart-$(CONFIG_AGP_VIA)		+=	agpgart_be-via.o
-agpgart-$(CONFIG_AGP_AMD)		+=	agpgart_be-amd.o
-agpgart-$(CONFIG_AGP_SIS)		+=	agpgart_be-sis.o
-agpgart-$(CONFIG_AGP_ALI)		+=	agpgart_be-ali.o
+agpgart-$(CONFIG_AGP_INTEL)	+=	agpgart_be-i8x0.o
+agpgart-$(CONFIG_AGP_I810)	+=	agpgart_be-i810.o
+agpgart-$(CONFIG_AGP_VIA)	+=	agpgart_be-via.o
+agpgart-$(CONFIG_AGP_AMD)	+=	agpgart_be-amd.o
+agpgart-$(CONFIG_AGP_SIS)	+=	agpgart_be-sis.o
+agpgart-$(CONFIG_AGP_ALI)	+=	agpgart_be-ali.o
 agpgart-$(CONFIG_AGP_SWORKS)	+=	agpgart_be-sworks.o
-agpgart-$(CONFIG_AGP_I460)		+=	agpgart_be-i460.o
+agpgart-$(CONFIG_AGP_I460)	+=	agpgart_be-i460.o
 agpgart-$(CONFIG_AGP_HP_ZX1)	+=	agpgart_be-hp.o
 agpgart-objs := $(agpgart-y)
 
diff -Nru a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
--- a/drivers/char/agp/agp.h	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agp.h	Thu Jul 11 16:15:37 2002
@@ -72,19 +72,19 @@
 #ifdef CONFIG_SMP
 static void ipi_handler(void *null)
 {
-    flush_agp_cache();
+	flush_agp_cache();
 }
 
-static void global_cache_flush(void)
+static void __attribute__((unused)) global_cache_flush(void)
 {
-    if (smp_call_function(ipi_handler, NULL, 1, 1) != 0)
-        panic(PFX "timed out waiting for the other CPUs!\n");
-    flush_agp_cache();
+	if (smp_call_function(ipi_handler, NULL, 1, 1) != 0)
+		panic(PFX "timed out waiting for the other CPUs!\n");
+	flush_agp_cache();
 }
 #else
 static void global_cache_flush(void)
 {
-    flush_agp_cache();
+	flush_agp_cache();
 }
 #endif	/* !CONFIG_SMP */
 
@@ -96,55 +96,55 @@
 	FIXED_APER_SIZE
 };
 
-typedef struct _gatt_mask {
+struct gatt_mask {
 	unsigned long mask;
 	u32 type;
 	/* totally device specific, for integrated chipsets that 
 	 * might have different types of memory masks.  For other
 	 * devices this will probably be ignored */
-} gatt_mask;
+};
 
-typedef struct _aper_size_info_8 {
+struct aper_size_info_8 {
 	int size;
 	int num_entries;
 	int page_order;
 	u8 size_value;
-} aper_size_info_8;
+};
 
-typedef struct _aper_size_info_16 {
+struct aper_size_info_16 {
 	int size;
 	int num_entries;
 	int page_order;
 	u16 size_value;
-} aper_size_info_16;
+};
 
-typedef struct _aper_size_info_32 {
+struct aper_size_info_32 {
 	int size;
 	int num_entries;
 	int page_order;
 	u32 size_value;
-} aper_size_info_32;
+};
 
-typedef struct _aper_size_info_lvl2 {
+struct aper_size_info_lvl2 {
 	int size;
 	int num_entries;
 	u32 size_value;
-} aper_size_info_lvl2;
+};
 
-typedef struct _aper_size_info_fixed {
+struct aper_size_info_fixed {
 	int size;
 	int num_entries;
 	int page_order;
-} aper_size_info_fixed;
+};
 
 struct agp_bridge_data {
-	agp_version *version;
+	struct agp_version *version;
 	void *aperture_sizes;
 	void *previous_size;
 	void *current_size;
 	void *dev_private_data;
 	struct pci_dev *dev;
-	gatt_mask *masks;
+	struct gatt_mask *masks;
 	unsigned long *gatt_table;
 	unsigned long *gatt_table_real;
 	unsigned long scratch_page;
@@ -186,26 +186,26 @@
 	
 };
 
-#define OUTREG64(mmap, addr, val)   __raw_writeq((val), (mmap)+(addr))
-#define OUTREG32(mmap, addr, val)   __raw_writel((val), (mmap)+(addr))
-#define OUTREG16(mmap, addr, val)   __raw_writew((val), (mmap)+(addr))
-#define OUTREG8(mmap, addr, val)   __raw_writeb((val), (mmap)+(addr))
-
-#define INREG64(mmap, addr)         __raw_readq((mmap)+(addr))
-#define INREG32(mmap, addr)         __raw_readl((mmap)+(addr))
-#define INREG16(mmap, addr)         __raw_readw((mmap)+(addr))
-#define INREG8(mmap, addr)         __raw_readb((mmap)+(addr))
-
-#define KB(x) ((x) * 1024)
-#define MB(x) (KB (KB (x)))
-#define GB(x) (MB (KB (x)))
+#define OUTREG64(mmap, addr, val)	__raw_writeq((val), (mmap)+(addr))
+#define OUTREG32(mmap, addr, val)	__raw_writel((val), (mmap)+(addr))
+#define OUTREG16(mmap, addr, val)	__raw_writew((val), (mmap)+(addr))
+#define OUTREG8(mmap, addr, val)	__raw_writeb((val), (mmap)+(addr))
+
+#define INREG64(mmap, addr)		__raw_readq((mmap)+(addr))
+#define INREG32(mmap, addr)		__raw_readl((mmap)+(addr))
+#define INREG16(mmap, addr)		__raw_readw((mmap)+(addr))
+#define INREG8(mmap, addr)		__raw_readb((mmap)+(addr))
+
+#define KB(x)	((x) * 1024)
+#define MB(x)	(KB (KB (x)))
+#define GB(x)	(MB (KB (x)))
 
 #define CACHE_FLUSH	agp_bridge.cache_flush
-#define A_SIZE_8(x)	((aper_size_info_8 *) x)
-#define A_SIZE_16(x)	((aper_size_info_16 *) x)
-#define A_SIZE_32(x)	((aper_size_info_32 *) x)
-#define A_SIZE_LVL2(x)  ((aper_size_info_lvl2 *) x)
-#define A_SIZE_FIX(x)	((aper_size_info_fixed *) x)
+#define A_SIZE_8(x)	((struct aper_size_info_8 *) x)
+#define A_SIZE_16(x)	((struct aper_size_info_16 *) x)
+#define A_SIZE_32(x)	((struct aper_size_info_32 *) x)
+#define A_SIZE_LVL2(x)	((struct aper_size_info_lvl2 *) x)
+#define A_SIZE_FIX(x)	((struct aper_size_info_fixed *) x)
 #define A_IDX8()	(A_SIZE_8(agp_bridge.aperture_sizes) + i)
 #define A_IDX16()	(A_SIZE_16(agp_bridge.aperture_sizes) + i)
 #define A_IDX32()	(A_SIZE_32(agp_bridge.aperture_sizes) + i)
@@ -213,88 +213,88 @@
 #define A_IDXFIX()	(A_SIZE_FIX(agp_bridge.aperture_sizes) + i)
 #define MAXKEY		(4096 * 32)
 
-#define PGE_EMPTY(p) (!(p) || (p) == (unsigned long) agp_bridge.scratch_page)
+#define PGE_EMPTY(p)	(!(p) || (p) == (unsigned long) agp_bridge.scratch_page)
 
 #ifndef PCI_DEVICE_ID_VIA_82C691_0
-#define PCI_DEVICE_ID_VIA_82C691_0      0x0691
+#define PCI_DEVICE_ID_VIA_82C691_0	0x0691
 #endif
 #ifndef PCI_DEVICE_ID_VIA_8371_0
-#define PCI_DEVICE_ID_VIA_8371_0      0x0391
+#define PCI_DEVICE_ID_VIA_8371_0	0x0391
 #endif
 #ifndef PCI_DEVICE_ID_VIA_8363_0
-#define PCI_DEVICE_ID_VIA_8363_0      0x0305
+#define PCI_DEVICE_ID_VIA_8363_0	0x0305
 #endif
 #ifndef PCI_DEVICE_ID_VIA_82C694X_0
-#define PCI_DEVICE_ID_VIA_82C694X_0      0x0605
+#define PCI_DEVICE_ID_VIA_82C694X_0	0x0605
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_0
-#define PCI_DEVICE_ID_INTEL_810_0       0x7120
+#define PCI_DEVICE_ID_INTEL_810_0	0x7120
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_845_G_0
 #define PCI_DEVICE_ID_INTEL_845_G_0	0x2560
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_845_G_1
-#define PCI_DEVICE_ID_INTEL_845_G_1     0x2562
+#define PCI_DEVICE_ID_INTEL_845_G_1	0x2562
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_830_M_0
 #define PCI_DEVICE_ID_INTEL_830_M_0	0x3575
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_830_M_1
-#define PCI_DEVICE_ID_INTEL_830_M_1     0x3577
+#define PCI_DEVICE_ID_INTEL_830_M_1	0x3577
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_820_0
-#define PCI_DEVICE_ID_INTEL_820_0       0x2500
+#define PCI_DEVICE_ID_INTEL_820_0	0x2500
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_820_UP_0
-#define PCI_DEVICE_ID_INTEL_820_UP_0    0x2501
+#define PCI_DEVICE_ID_INTEL_820_UP_0	0x2501
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_840_0
-#define PCI_DEVICE_ID_INTEL_840_0		0x1a21
+#define PCI_DEVICE_ID_INTEL_840_0	0x1a21
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_845_0
-#define PCI_DEVICE_ID_INTEL_845_0     0x1a30
+#define PCI_DEVICE_ID_INTEL_845_0	0x1a30
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_850_0
-#define PCI_DEVICE_ID_INTEL_850_0     0x2530
+#define PCI_DEVICE_ID_INTEL_850_0	0x2530
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_860_0
-#define PCI_DEVICE_ID_INTEL_860_0     0x2531
+#define PCI_DEVICE_ID_INTEL_860_0	0x2531
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_0
-#define PCI_DEVICE_ID_INTEL_810_DC100_0 0x7122
+#define PCI_DEVICE_ID_INTEL_810_DC100_0	0x7122
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_E_0
-#define PCI_DEVICE_ID_INTEL_810_E_0     0x7124
+#define PCI_DEVICE_ID_INTEL_810_E_0	0x7124
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_82443GX_0
-#define PCI_DEVICE_ID_INTEL_82443GX_0   0x71a0
+#define PCI_DEVICE_ID_INTEL_82443GX_0	0x71a0
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_1
-#define PCI_DEVICE_ID_INTEL_810_1       0x7121
+#define PCI_DEVICE_ID_INTEL_810_1	0x7121
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_1
-#define PCI_DEVICE_ID_INTEL_810_DC100_1 0x7123
+#define PCI_DEVICE_ID_INTEL_810_DC100_1	0x7123
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_810_E_1
-#define PCI_DEVICE_ID_INTEL_810_E_1     0x7125
+#define PCI_DEVICE_ID_INTEL_810_E_1	0x7125
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_815_0
-#define PCI_DEVICE_ID_INTEL_815_0       0x1130
+#define PCI_DEVICE_ID_INTEL_815_0	0x1130
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_815_1
-#define PCI_DEVICE_ID_INTEL_815_1       0x1132
+#define PCI_DEVICE_ID_INTEL_815_1	0x1132
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_82443GX_1
-#define PCI_DEVICE_ID_INTEL_82443GX_1   0x71a1
+#define PCI_DEVICE_ID_INTEL_82443GX_1	0x71a1
 #endif
 #ifndef PCI_DEVICE_ID_INTEL_460GX
-#define PCI_DEVICE_ID_INTEL_460GX	 0x84ea
+#define PCI_DEVICE_ID_INTEL_460GX	0x84ea
 #endif
 #ifndef PCI_DEVICE_ID_AMD_IRONGATE_0
-#define PCI_DEVICE_ID_AMD_IRONGATE_0    0x7006
+#define PCI_DEVICE_ID_AMD_IRONGATE_0	0x7006
 #endif
 #ifndef PCI_DEVICE_ID_AMD_761_0
-#define PCI_DEVICE_ID_AMD_761_0         0x700e
+#define PCI_DEVICE_ID_AMD_761_0		0x700e
 #endif
 #ifndef PCI_DEVICE_ID_AMD_762_0
 #define PCI_DEVICE_ID_AMD_762_0		0x700C
@@ -328,12 +328,12 @@
 #endif
 
 /* intel register */
-#define INTEL_APBASE    0x10
-#define INTEL_APSIZE    0xb4
-#define INTEL_ATTBASE   0xb8
-#define INTEL_AGPCTRL   0xb0
-#define INTEL_NBXCFG    0x50
-#define INTEL_ERRSTS    0x91
+#define INTEL_APBASE	0x10
+#define INTEL_APSIZE	0xb4
+#define INTEL_ATTBASE	0xb8
+#define INTEL_AGPCTRL	0xb0
+#define INTEL_NBXCFG	0x50
+#define INTEL_ERRSTS	0x91
 
 /* Intel 460GX Registers */
 #define INTEL_I460_APBASE		0x10
@@ -345,120 +345,120 @@
 #define INTEL_I460_GATT_COHERENT	(1UL << 25)
 
 /* intel i830 registers */
-#define I830_GMCH_CTRL             0x52
-#define I830_GMCH_ENABLED          0x4
-#define I830_GMCH_MEM_MASK         0x1
-#define I830_GMCH_MEM_64M          0x1
-#define I830_GMCH_MEM_128M         0
-#define I830_GMCH_GMS_MASK         0x70
-#define I830_GMCH_GMS_DISABLED     0x00
-#define I830_GMCH_GMS_LOCAL        0x10
-#define I830_GMCH_GMS_STOLEN_512   0x20
-#define I830_GMCH_GMS_STOLEN_1024  0x30
-#define I830_GMCH_GMS_STOLEN_8192  0x40
-#define I830_RDRAM_CHANNEL_TYPE    0x03010
-#define I830_RDRAM_ND(x)           (((x) & 0x20) >> 5)
-#define I830_RDRAM_DDT(x)          (((x) & 0x18) >> 3)
+#define I830_GMCH_CTRL			0x52
+#define I830_GMCH_ENABLED		0x4
+#define I830_GMCH_MEM_MASK		0x1
+#define I830_GMCH_MEM_64M		0x1
+#define I830_GMCH_MEM_128M		0
+#define I830_GMCH_GMS_MASK		0x70
+#define I830_GMCH_GMS_DISABLED		0x00
+#define I830_GMCH_GMS_LOCAL		0x10
+#define I830_GMCH_GMS_STOLEN_512	0x20
+#define I830_GMCH_GMS_STOLEN_1024	0x30
+#define I830_GMCH_GMS_STOLEN_8192	0x40
+#define I830_RDRAM_CHANNEL_TYPE		0x03010
+#define I830_RDRAM_ND(x)		(((x) & 0x20) >> 5)
+#define I830_RDRAM_DDT(x)		(((x) & 0x18) >> 3)
 
 /* This one is for I830MP w. an external graphic card */
-#define INTEL_I830_ERRSTS          0x92
+#define INTEL_I830_ERRSTS	0x92
 
 /* intel 815 register */
 #define INTEL_815_APCONT	0x51
 #define INTEL_815_ATTBASE_MASK	~0x1FFFFFFF
 
 /* intel i820 registers */
-#define INTEL_I820_RDCR     0x51
-#define INTEL_I820_ERRSTS   0xc8
+#define INTEL_I820_RDCR		0x51
+#define INTEL_I820_ERRSTS	0xc8
 
 /* intel i840 registers */
-#define INTEL_I840_MCHCFG   0x50
-#define INTEL_I840_ERRSTS   0xc8
+#define INTEL_I840_MCHCFG	0x50
+#define INTEL_I840_ERRSTS	0xc8
  
 /* intel i845 registers */
-#define INTEL_I845_AGPM     0x51
-#define INTEL_I845_ERRSTS   0xc8
+#define INTEL_I845_AGPM		0x51
+#define INTEL_I845_ERRSTS	0xc8
 
 /* intel i850 registers */
-#define INTEL_I850_MCHCFG   0x50
-#define INTEL_I850_ERRSTS   0xc8
+#define INTEL_I850_MCHCFG	0x50
+#define INTEL_I850_ERRSTS	0xc8
 
 /* intel i860 registers */
 #define INTEL_I860_MCHCFG	0x50
 #define INTEL_I860_ERRSTS	0xc8
 
 /* intel i810 registers */
-#define I810_GMADDR 0x10
-#define I810_MMADDR 0x14
-#define I810_PTE_BASE          0x10000
-#define I810_PTE_MAIN_UNCACHED 0x00000000
-#define I810_PTE_LOCAL         0x00000002
-#define I810_PTE_VALID         0x00000001
-#define I810_SMRAM_MISCC       0x70
-#define I810_GFX_MEM_WIN_SIZE  0x00010000
-#define I810_GFX_MEM_WIN_32M   0x00010000
-#define I810_GMS               0x000000c0
-#define I810_GMS_DISABLE       0x00000000
-#define I810_PGETBL_CTL        0x2020
-#define I810_PGETBL_ENABLED    0x00000001
-#define I810_DRAM_CTL          0x3000
-#define I810_DRAM_ROW_0        0x00000001
-#define I810_DRAM_ROW_0_SDRAM  0x00000001
+#define I810_GMADDR		0x10
+#define I810_MMADDR		0x14
+#define I810_PTE_BASE		0x10000
+#define I810_PTE_MAIN_UNCACHED	0x00000000
+#define I810_PTE_LOCAL		0x00000002
+#define I810_PTE_VALID		0x00000001
+#define I810_SMRAM_MISCC	0x70
+#define I810_GFX_MEM_WIN_SIZE	0x00010000
+#define I810_GFX_MEM_WIN_32M	0x00010000
+#define I810_GMS		0x000000c0
+#define I810_GMS_DISABLE	0x00000000
+#define I810_PGETBL_CTL		0x2020
+#define I810_PGETBL_ENABLED	0x00000001
+#define I810_DRAM_CTL		0x3000
+#define I810_DRAM_ROW_0		0x00000001
+#define I810_DRAM_ROW_0_SDRAM	0x00000001
 
 
 
 /* VIA register */
-#define VIA_APBASE      0x10
-#define VIA_GARTCTRL    0x80
-#define VIA_APSIZE      0x84
-#define VIA_ATTBASE     0x88
+#define VIA_APBASE	0x10
+#define VIA_GARTCTRL	0x80
+#define VIA_APSIZE	0x84
+#define VIA_ATTBASE	0x88
 
 /* SiS registers */
-#define SIS_APBASE      0x10
-#define SIS_ATTBASE     0x90
-#define SIS_APSIZE      0x94
-#define SIS_TLBCNTRL    0x97
-#define SIS_TLBFLUSH    0x98
+#define SIS_APBASE	0x10
+#define SIS_ATTBASE	0x90
+#define SIS_APSIZE	0x94
+#define SIS_TLBCNTRL	0x97
+#define SIS_TLBFLUSH	0x98
 
 /* AMD registers */
-#define AMD_APBASE      0x10
-#define AMD_MMBASE      0x14
-#define AMD_APSIZE      0xac
-#define AMD_MODECNTL    0xb0
-#define AMD_MODECNTL2   0xb2
-#define AMD_GARTENABLE  0x02	/* In mmio region (16-bit register) */
-#define AMD_ATTBASE     0x04	/* In mmio region (32-bit register) */
-#define AMD_TLBFLUSH    0x0c	/* In mmio region (32-bit register) */
-#define AMD_CACHEENTRY  0x10	/* In mmio region (32-bit register) */
+#define AMD_APBASE	0x10
+#define AMD_MMBASE	0x14
+#define AMD_APSIZE	0xac
+#define AMD_MODECNTL	0xb0
+#define AMD_MODECNTL2	0xb2
+#define AMD_GARTENABLE	0x02	/* In mmio region (16-bit register) */
+#define AMD_ATTBASE	0x04	/* In mmio region (32-bit register) */
+#define AMD_TLBFLUSH	0x0c	/* In mmio region (32-bit register) */
+#define AMD_CACHEENTRY	0x10	/* In mmio region (32-bit register) */
 
 /* ALi registers */
-#define ALI_APBASE	0x10
-#define ALI_AGPCTRL	0xb8
-#define ALI_ATTBASE	0xbc
-#define ALI_TLBCTRL	0xc0
-#define ALI_TAGCTRL	0xc4
-#define ALI_CACHE_FLUSH_CTRL	0xD0
+#define ALI_APBASE			0x10
+#define ALI_AGPCTRL			0xb8
+#define ALI_ATTBASE			0xbc
+#define ALI_TLBCTRL			0xc0
+#define ALI_TAGCTRL			0xc4
+#define ALI_CACHE_FLUSH_CTRL		0xD0
 #define ALI_CACHE_FLUSH_ADDR_MASK	0xFFFFF000
-#define ALI_CACHE_FLUSH_EN	0x100
+#define ALI_CACHE_FLUSH_EN		0x100
 
 /* Serverworks Registers */
-#define SVWRKS_APSIZE 0x10
-#define SVWRKS_SIZE_MASK 0xfe000000
+#define SVWRKS_APSIZE		0x10
+#define SVWRKS_SIZE_MASK	0xfe000000
 
-#define SVWRKS_MMBASE 0x14
-#define SVWRKS_CACHING 0x4b
-#define SVWRKS_FEATURE 0x68
+#define SVWRKS_MMBASE		0x14
+#define SVWRKS_CACHING		0x4b
+#define SVWRKS_FEATURE		0x68
 
 /* func 1 registers */
-#define SVWRKS_AGP_ENABLE 0x60
-#define SVWRKS_COMMAND 0x04
+#define SVWRKS_AGP_ENABLE	0x60
+#define SVWRKS_COMMAND		0x04
 
 /* Memory mapped registers */
-#define SVWRKS_GART_CACHE 0x02
-#define SVWRKS_GATTBASE   0x04
-#define SVWRKS_TLBFLUSH   0x10
-#define SVWRKS_POSTFLUSH  0x14
-#define SVWRKS_DIRFLUSH   0x0c
+#define SVWRKS_GART_CACHE	0x02
+#define SVWRKS_GATTBASE		0x04
+#define SVWRKS_TLBFLUSH		0x10
+#define SVWRKS_POSTFLUSH	0x14
+#define SVWRKS_DIRFLUSH		0x0c
 
 /* HP ZX1 SBA registers */
 #define HP_ZX1_CTRL		0x200
diff -Nru a/drivers/char/agp/agpgart_be-ali.c b/drivers/char/agp/agpgart_be-ali.c
--- a/drivers/char/agp/agpgart_be-ali.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-ali.c	Thu Jul 11 16:15:37 2002
@@ -26,27 +26,10 @@
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
 #include <linux/config.h>
-#include <linux/version.h>
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
@@ -54,7 +37,7 @@
 {
 	int i;
 	u32 temp;
-	aper_size_info_32 *values;
+	struct aper_size_info_32 *values;
 
 	pci_read_config_dword(agp_bridge.dev, ALI_ATTBASE, &temp);
 	temp &= ~(0xfffffff0);
@@ -84,7 +67,7 @@
 
 static void ali_cleanup(void)
 {
-	aper_size_info_32 *previous_size;
+	struct aper_size_info_32 *previous_size;
 	u32 temp;
 
 	previous_size = A_SIZE_32(agp_bridge.previous_size);
@@ -102,7 +85,7 @@
 static int ali_configure(void)
 {
 	u32 temp;
-	aper_size_info_32 *current_size;
+	struct aper_size_info_32 *current_size;
 
 	current_size = A_SIZE_32(agp_bridge.current_size);
 
@@ -231,12 +214,12 @@
 }
 
 /* Setup function */
-static gatt_mask ali_generic_masks[] =
+static struct gatt_mask ali_generic_masks[] =
 {
-	{0x00000000, 0}
+	{mask: 0x00000000, type: 0}
 };
 
-static aper_size_info_32 ali_generic_sizes[7] =
+static struct aper_size_info_32 ali_generic_sizes[7] =
 {
 	{256, 65536, 6, 10},
 	{128, 32768, 5, 9},
diff -Nru a/drivers/char/agp/agpgart_be-amd.c b/drivers/char/agp/agpgart_be-amd.c
--- a/drivers/char/agp/agpgart_be-amd.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-amd.c	Thu Jul 11 16:15:37 2002
@@ -25,43 +25,25 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
-typedef struct _amd_page_map {
+struct amd_page_map {
 	unsigned long *real;
 	unsigned long *remapped;
-} amd_page_map;
+};
 
 static struct _amd_irongate_private {
 	volatile u8 *registers;
-	amd_page_map **gatt_pages;
+	struct amd_page_map **gatt_pages;
 	int num_tables;
 } amd_irongate_private;
 
-static int amd_create_page_map(amd_page_map *page_map)
+static int amd_create_page_map(struct amd_page_map *page_map)
 {
 	int i;
 
@@ -88,7 +70,7 @@
 	return 0;
 }
 
-static void amd_free_page_map(amd_page_map *page_map)
+static void amd_free_page_map(struct amd_page_map *page_map)
 {
 	iounmap(page_map->remapped);
 	ClearPageReserved(virt_to_page(page_map->real));
@@ -98,8 +80,8 @@
 static void amd_free_gatt_pages(void)
 {
 	int i;
-	amd_page_map **tables;
-	amd_page_map *entry;
+	struct amd_page_map **tables;
+	struct amd_page_map *entry;
 
 	tables = amd_irongate_private.gatt_pages;
 	for(i = 0; i < amd_irongate_private.num_tables; i++) {
@@ -116,24 +98,24 @@
 
 static int amd_create_gatt_pages(int nr_tables)
 {
-	amd_page_map **tables;
-	amd_page_map *entry;
+	struct amd_page_map **tables;
+	struct amd_page_map *entry;
 	int retval = 0;
 	int i;
 
-	tables = kmalloc((nr_tables + 1) * sizeof(amd_page_map *), 
+	tables = kmalloc((nr_tables + 1) * sizeof(struct amd_page_map *), 
 			 GFP_KERNEL);
 	if (tables == NULL) {
 		return -ENOMEM;
 	}
-	memset(tables, 0, sizeof(amd_page_map *) * (nr_tables + 1));
+	memset(tables, 0, sizeof(struct amd_page_map *) * (nr_tables + 1));
 	for (i = 0; i < nr_tables; i++) {
-		entry = kmalloc(sizeof(amd_page_map), GFP_KERNEL);
+		entry = kmalloc(sizeof(struct amd_page_map), GFP_KERNEL);
 		if (entry == NULL) {
 			retval = -ENOMEM;
 			break;
 		}
-		memset(entry, 0, sizeof(amd_page_map));
+		memset(entry, 0, sizeof(struct amd_page_map));
 		tables[i] = entry;
 		retval = amd_create_page_map(entry);
 		if (retval != 0) break;
@@ -159,8 +141,8 @@
 
 static int amd_create_gatt_table(void)
 {
-	aper_size_info_lvl2 *value;
-	amd_page_map page_dir;
+	struct aper_size_info_lvl2 *value;
+	struct amd_page_map page_dir;
 	unsigned long addr;
 	int retval;
 	u32 temp;
@@ -203,7 +185,7 @@
 
 static int amd_free_gatt_table(void)
 {
-	amd_page_map page_dir;
+	struct amd_page_map page_dir;
    
 	page_dir.real = agp_bridge.gatt_table_real;
 	page_dir.remapped = agp_bridge.gatt_table;
@@ -217,7 +199,7 @@
 {
 	int i;
 	u32 temp;
-	aper_size_info_lvl2 *values;
+	struct aper_size_info_lvl2 *values;
 
 	pci_read_config_dword(agp_bridge.dev, AMD_APSIZE, &temp);
 	temp = (temp & 0x0000000e);
@@ -237,7 +219,7 @@
 
 static int amd_irongate_configure(void)
 {
-	aper_size_info_lvl2 *current_size;
+	struct aper_size_info_lvl2 *current_size;
 	u32 temp;
 	u16 enable_reg;
 
@@ -277,7 +259,7 @@
 
 static void amd_irongate_cleanup(void)
 {
-	aper_size_info_lvl2 *previous_size;
+	struct aper_size_info_lvl2 *previous_size;
 	u32 temp;
 	u16 enable_reg;
 
@@ -375,7 +357,7 @@
 	return 0;
 }
 
-static aper_size_info_lvl2 amd_irongate_sizes[7] =
+static struct aper_size_info_lvl2 amd_irongate_sizes[7] =
 {
 	{2048, 524288, 0x0000000c},
 	{1024, 262144, 0x0000000a},
@@ -386,9 +368,9 @@
 	{32, 8192, 0x00000000}
 };
 
-static gatt_mask amd_irongate_masks[] =
+static struct gatt_mask amd_irongate_masks[] =
 {
-	{0x00000001, 0}
+	{mask: 0x00000001, type: 0}
 };
 
 int __init amd_irongate_setup (struct pci_dev *pdev)
diff -Nru a/drivers/char/agp/agpgart_be-hp.c b/drivers/char/agp/agpgart_be-hp.c
--- a/drivers/char/agp/agpgart_be-hp.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-hp.c	Thu Jul 11 16:15:37 2002
@@ -25,28 +25,10 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
@@ -64,14 +46,14 @@
 #define HP_ZX1_IOVA_TO_PDIR(va)	((va - hp_private.iova_base) >> \
 					hp_private.io_tlb_shift)
 
-static aper_size_info_fixed hp_zx1_sizes[] =
+static struct aper_size_info_fixed hp_zx1_sizes[] =
 {
 	{0, 0, 0},		/* filled in by hp_zx1_fetch_size() */
 };
 
-static gatt_mask hp_zx1_masks[] =
+static struct gatt_mask hp_zx1_masks[] =
 {
-	{HP_ZX1_PDIR_VALID_BIT, 0}
+	{mask: HP_ZX1_PDIR_VALID_BIT, type: 0}
 };
 
 static struct _hp_private {
diff -Nru a/drivers/char/agp/agpgart_be-i460.c b/drivers/char/agp/agpgart_be-i460.c
--- a/drivers/char/agp/agpgart_be-i460.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-i460.c	Thu Jul 11 16:15:37 2002
@@ -25,28 +25,10 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
@@ -87,7 +69,7 @@
 {
 	int i;
 	u8 temp;
-	aper_size_info_8 *values;
+	struct aper_size_info_8 *values;
 
 	/* Determine the GART page size */
 	pci_read_config_byte(agp_bridge.dev, INTEL_I460_GXBCTL, &temp);
@@ -160,7 +142,7 @@
 
 static void intel_i460_cleanup(void)
 {
-	aper_size_info_8 *previous_size;
+	struct aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
 	intel_i460_write_agpsiz(previous_size->size_value);
@@ -185,7 +167,7 @@
 	u8 scratch;
 	int i;
 
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	temp.large = 0;
 
@@ -548,11 +530,11 @@
 		agp_generic_destroy_page(page);
 }
 
-static gatt_mask intel_i460_masks[] =
+static struct gatt_mask intel_i460_masks[] =
 {
 	{
-	  INTEL_I460_GATT_VALID | INTEL_I460_GATT_COHERENT,
-	  0
+	  mask: INTEL_I460_GATT_VALID | INTEL_I460_GATT_COHERENT,
+	  type: 0
 	}
 };
 
@@ -569,7 +551,7 @@
 	return ((addr & 0xffffff) << 12);
 }
 
-static aper_size_info_8 intel_i460_sizes[3] =
+static struct aper_size_info_8 intel_i460_sizes[3] =
 {
 	/*
 	 * The 32GB aperture is only available with a 4M GART page size.
diff -Nru a/drivers/char/agp/agpgart_be-i810.c b/drivers/char/agp/agpgart_be-i810.c
--- a/drivers/char/agp/agpgart_be-i810.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-i810.c	Thu Jul 11 16:15:37 2002
@@ -25,32 +25,14 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
-static aper_size_info_fixed intel_i810_sizes[] =
+static struct aper_size_info_fixed intel_i810_sizes[] =
 {
 	{64, 16384, 4},
      /* The 32M mode still requires a 64k gatt */
@@ -60,11 +42,11 @@
 #define AGP_DCACHE_MEMORY 1
 #define AGP_PHYS_MEMORY   2
 
-static gatt_mask intel_i810_masks[] =
+static struct gatt_mask intel_i810_masks[] =
 {
-	{I810_PTE_VALID, 0},
-	{(I810_PTE_VALID | I810_PTE_LOCAL), AGP_DCACHE_MEMORY},
-	{I810_PTE_VALID, 0}
+	{mask: I810_PTE_VALID, type: 0},
+	{mask: (I810_PTE_VALID | I810_PTE_LOCAL), type: AGP_DCACHE_MEMORY},
+	{mask: I810_PTE_VALID, type: 0}
 };
 
 static struct _intel_i810_private {
@@ -76,7 +58,7 @@
 static int intel_i810_fetch_size(void)
 {
 	u32 smram_miscc;
-	aper_size_info_fixed *values;
+	struct aper_size_info_fixed *values;
 
 	pci_read_config_dword(agp_bridge.dev, I810_SMRAM_MISCC, &smram_miscc);
 	values = A_SIZE_FIX(agp_bridge.aperture_sizes);
@@ -102,7 +84,7 @@
 
 static int intel_i810_configure(void)
 {
-	aper_size_info_fixed *current_size;
+	struct aper_size_info_fixed *current_size;
 	u32 temp;
 	int i;
 
@@ -326,7 +308,7 @@
 	return 0;
 }
 
-static aper_size_info_fixed intel_i830_sizes[] =
+static struct aper_size_info_fixed intel_i830_sizes[] =
 {
 	{128, 32768, 5},
 	/* The 64M mode still requires a 128k gatt */
@@ -383,7 +365,7 @@
 static int intel_i830_create_gatt_table(void)
 {
 	int page_order;
-	aper_size_info_fixed *size;
+	struct aper_size_info_fixed *size;
 	int num_entries;
 	u32 temp;
 
@@ -422,7 +404,7 @@
 static int intel_i830_fetch_size(void)
 {
 	u16 gmch_ctrl;
-	aper_size_info_fixed *values;
+	struct aper_size_info_fixed *values;
 
 	pci_read_config_word(agp_bridge.dev,I830_GMCH_CTRL,&gmch_ctrl);
 	values = A_SIZE_FIX(agp_bridge.aperture_sizes);
@@ -442,7 +424,7 @@
 
 static int intel_i830_configure(void)
 {
-	aper_size_info_fixed *current_size;
+	struct aper_size_info_fixed *current_size;
 	u32 temp;
 	u16 gmch_ctrl;
 	int i;
diff -Nru a/drivers/char/agp/agpgart_be-i8x0.c b/drivers/char/agp/agpgart_be-i8x0.c
--- a/drivers/char/agp/agpgart_be-i8x0.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-i8x0.c	Thu Jul 11 16:15:37 2002
@@ -25,38 +25,19 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
 
-
 static int intel_fetch_size(void)
 {
 	int i;
 	u16 temp;
-	aper_size_info_16 *values;
+	struct aper_size_info_16 *values;
 
 	pci_read_config_word(agp_bridge.dev, INTEL_APSIZE, &temp);
 	values = A_SIZE_16(agp_bridge.aperture_sizes);
@@ -77,7 +58,7 @@
 {
 	int i;
 	u8 temp;
-	aper_size_info_8 *values;
+	struct aper_size_info_8 *values;
 
 	pci_read_config_byte(agp_bridge.dev, INTEL_APSIZE, &temp);
 	values = A_SIZE_8(agp_bridge.aperture_sizes);
@@ -114,7 +95,7 @@
 static void intel_cleanup(void)
 {
 	u16 temp;
-	aper_size_info_16 *previous_size;
+	struct aper_size_info_16 *previous_size;
 
 	previous_size = A_SIZE_16(agp_bridge.previous_size);
 	pci_read_config_word(agp_bridge.dev, INTEL_NBXCFG, &temp);
@@ -127,7 +108,7 @@
 static void intel_8xx_cleanup(void)
 {
 	u16 temp;
-	aper_size_info_8 *previous_size;
+	struct aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
 	pci_read_config_word(agp_bridge.dev, INTEL_NBXCFG, &temp);
@@ -141,7 +122,7 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_16 *current_size;
+	struct aper_size_info_16 *current_size;
 
 	current_size = A_SIZE_16(agp_bridge.current_size);
 
@@ -173,7 +154,7 @@
 {
 	u32 temp, addr;
 	u8 temp2;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -215,7 +196,7 @@
 static void intel_820_cleanup(void)
 {
 	u8 temp;
-	aper_size_info_8 *previous_size;
+	struct aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
 	pci_read_config_byte(agp_bridge.dev, INTEL_I820_RDCR, &temp);
@@ -230,7 +211,7 @@
 {
 	u32 temp;
  	u8 temp2; 
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -264,7 +245,7 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -296,7 +277,7 @@
 {
 	u32 temp;
 	u8 temp2;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -328,7 +309,7 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -360,7 +341,7 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -392,7 +373,7 @@
 {
 	u32 temp;
 	u16 temp2;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 
@@ -433,18 +414,18 @@
 }
 
 /* Setup function */
-static gatt_mask intel_generic_masks[] =
+static struct gatt_mask intel_generic_masks[] =
 {
-	{0x00000017, 0}
+	{mask: 0x00000017, type: 0}
 };
 
-static aper_size_info_8 intel_815_sizes[2] =
+static struct aper_size_info_8 intel_815_sizes[2] =
 {
 	{64, 16384, 4, 0},
 	{32, 8192, 3, 8},
 };
 	
-static aper_size_info_8 intel_8xx_sizes[7] =
+static struct aper_size_info_8 intel_8xx_sizes[7] =
 {
 	{256, 65536, 6, 0},
 	{128, 32768, 5, 32},
@@ -455,7 +436,7 @@
 	{4, 1024, 0, 63}
 };
 
-static aper_size_info_16 intel_generic_sizes[7] =
+static struct aper_size_info_16 intel_generic_sizes[7] =
 {
 	{256, 65536, 6, 0},
 	{128, 32768, 5, 32},
@@ -466,7 +447,7 @@
 	{4, 1024, 0, 63}
 };
 
-static aper_size_info_8 intel_830mp_sizes[4] = 
+static struct aper_size_info_8 intel_830mp_sizes[4] = 
 {
   {256, 65536, 6, 0},
   {128, 32768, 5, 32},
diff -Nru a/drivers/char/agp/agpgart_be-serverworks.c b/drivers/char/agp/agpgart_be-serverworks.c
--- a/drivers/char/agp/agpgart_be-serverworks.c	Thu Jul 11 16:15:37 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,644 +0,0 @@
-/*
- * AGPGART module version 0.99
- * Copyright (C) 1999 Jeff Hartmann
- * Copyright (C) 1999 Precision Insight, Inc.
- * Copyright (C) 1999 Xi Graphics, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * JEFF HARTMANN, OR ANY OTHER CONTRIBUTORS BE LIABLE FOR ANY CLAIM, 
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
- * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- * TODO: 
- * - Allocate more than order 0 pages to avoid too much linear map splitting.
- */
-#include <linux/config.h>
-#include <linux/version.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
-#include <linux/agp_backend.h>
-#include "agp.h"
-
-typedef struct _serverworks_page_map {
-	unsigned long *real;
-	unsigned long *remapped;
-} serverworks_page_map;
-
-static struct _serverworks_private {
-	struct pci_dev *svrwrks_dev;	/* device one */
-	volatile u8 *registers;
-	serverworks_page_map **gatt_pages;
-	int num_tables;
-	serverworks_page_map scratch_dir;
-
-	int gart_addr_ofs;
-	int mm_addr_ofs;
-} serverworks_private;
-
-static int serverworks_create_page_map(serverworks_page_map *page_map)
-{
-	int i;
-
-	page_map->real = (unsigned long *) __get_free_page(GFP_KERNEL);
-	if (page_map->real == NULL) {
-		return -ENOMEM;
-	}
-	SetPageReserved(virt_to_page(page_map->real));
-	CACHE_FLUSH();
-	page_map->remapped = ioremap_nocache(virt_to_phys(page_map->real), 
-					    PAGE_SIZE);
-	if (page_map->remapped == NULL) {
-		ClearPageReserved(virt_to_page(page_map->real));
-		free_page((unsigned long) page_map->real);
-		page_map->real = NULL;
-		return -ENOMEM;
-	}
-	CACHE_FLUSH();
-
-	for(i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++) {
-		page_map->remapped[i] = agp_bridge.scratch_page;
-	}
-
-	return 0;
-}
-
-static void serverworks_free_page_map(serverworks_page_map *page_map)
-{
-	iounmap(page_map->remapped);
-	ClearPageReserved(virt_to_page(page_map->real));
-	free_page((unsigned long) page_map->real);
-}
-
-static void serverworks_free_gatt_pages(void)
-{
-	int i;
-	serverworks_page_map **tables;
-	serverworks_page_map *entry;
-
-	tables = serverworks_private.gatt_pages;
-	for(i = 0; i < serverworks_private.num_tables; i++) {
-		entry = tables[i];
-		if (entry != NULL) {
-			if (entry->real != NULL) {
-				serverworks_free_page_map(entry);
-			}
-			kfree(entry);
-		}
-	}
-	kfree(tables);
-}
-
-static int serverworks_create_gatt_pages(int nr_tables)
-{
-	serverworks_page_map **tables;
-	serverworks_page_map *entry;
-	int retval = 0;
-	int i;
-
-	tables = kmalloc((nr_tables + 1) * sizeof(serverworks_page_map *), 
-			 GFP_KERNEL);
-	if (tables == NULL) {
-		return -ENOMEM;
-	}
-	memset(tables, 0, sizeof(serverworks_page_map *) * (nr_tables + 1));
-	for (i = 0; i < nr_tables; i++) {
-		entry = kmalloc(sizeof(serverworks_page_map), GFP_KERNEL);
-		if (entry == NULL) {
-			retval = -ENOMEM;
-			break;
-		}
-		memset(entry, 0, sizeof(serverworks_page_map));
-		tables[i] = entry;
-		retval = serverworks_create_page_map(entry);
-		if (retval != 0) break;
-	}
-	serverworks_private.num_tables = nr_tables;
-	serverworks_private.gatt_pages = tables;
-
-	if (retval != 0) serverworks_free_gatt_pages();
-
-	return retval;
-}
-
-#define SVRWRKS_GET_GATT(addr) (serverworks_private.gatt_pages[\
-	GET_PAGE_DIR_IDX(addr)]->remapped)
-
-#ifndef GET_PAGE_DIR_OFF
-#define GET_PAGE_DIR_OFF(addr) (addr >> 22)
-#endif
-
-#ifndef GET_PAGE_DIR_IDX
-#define GET_PAGE_DIR_IDX(addr) (GET_PAGE_DIR_OFF(addr) - \
-	GET_PAGE_DIR_OFF(agp_bridge.gart_bus_addr))
-#endif
-
-#ifndef GET_GATT_OFF
-#define GET_GATT_OFF(addr) ((addr & 0x003ff000) >> 12)
-#endif
-
-static int serverworks_create_gatt_table(void)
-{
-	aper_size_info_lvl2 *value;
-	serverworks_page_map page_dir;
-	int retval;
-	u32 temp;
-	int i;
-
-	value = A_SIZE_LVL2(agp_bridge.current_size);
-	retval = serverworks_create_page_map(&page_dir);
-	if (retval != 0) {
-		return retval;
-	}
-	retval = serverworks_create_page_map(&serverworks_private.scratch_dir);
-	if (retval != 0) {
-		serverworks_free_page_map(&page_dir);
-		return retval;
-	}
-	/* Create a fake scratch directory */
-	for(i = 0; i < 1024; i++) {
-		serverworks_private.scratch_dir.remapped[i] = (unsigned long) agp_bridge.scratch_page;
-		page_dir.remapped[i] =
-			virt_to_phys(serverworks_private.scratch_dir.real);
-		page_dir.remapped[i] |= 0x00000001;
-	}
-
-	retval = serverworks_create_gatt_pages(value->num_entries / 1024);
-	if (retval != 0) {
-		serverworks_free_page_map(&page_dir);
-		serverworks_free_page_map(&serverworks_private.scratch_dir);
-		return retval;
-	}
-
-	agp_bridge.gatt_table_real = page_dir.real;
-	agp_bridge.gatt_table = page_dir.remapped;
-	agp_bridge.gatt_bus_addr = virt_to_phys(page_dir.real);
-
-	/* Get the address for the gart region.
-	 * This is a bus address even on the alpha, b/c its
-	 * used to program the agp master not the cpu
-	 */
-
-	pci_read_config_dword(agp_bridge.dev,
-			      serverworks_private.gart_addr_ofs,
-			      &temp);
-	agp_bridge.gart_bus_addr = (temp & PCI_BASE_ADDRESS_MEM_MASK);
-
-	/* Calculate the agp offset */	
-
-	for(i = 0; i < value->num_entries / 1024; i++) {
-		page_dir.remapped[i] =
-			virt_to_phys(serverworks_private.gatt_pages[i]->real);
-		page_dir.remapped[i] |= 0x00000001;
-	}
-
-	return 0;
-}
-
-static int serverworks_free_gatt_table(void)
-{
-	serverworks_page_map page_dir;
-   
-	page_dir.real = agp_bridge.gatt_table_real;
-	page_dir.remapped = agp_bridge.gatt_table;
-
-	serverworks_free_gatt_pages();
-	serverworks_free_page_map(&page_dir);
-	serverworks_free_page_map(&serverworks_private.scratch_dir);
-	return 0;
-}
-
-static int serverworks_fetch_size(void)
-{
-	int i;
-	u32 temp;
-	u32 temp2;
-	aper_size_info_lvl2 *values;
-
-	values = A_SIZE_LVL2(agp_bridge.aperture_sizes);
-	pci_read_config_dword(agp_bridge.dev,
-			      serverworks_private.gart_addr_ofs,
-			      &temp);
-	pci_write_config_dword(agp_bridge.dev,
-			       serverworks_private.gart_addr_ofs,
-			       SVWRKS_SIZE_MASK);
-	pci_read_config_dword(agp_bridge.dev,
-			      serverworks_private.gart_addr_ofs,
-			      &temp2);
-	pci_write_config_dword(agp_bridge.dev,
-			       serverworks_private.gart_addr_ofs,
-			       temp);
-	temp2 &= SVWRKS_SIZE_MASK;
-
-	for (i = 0; i < agp_bridge.num_aperture_sizes; i++) {
-		if (temp2 == values[i].size_value) {
-			agp_bridge.previous_size =
-			    agp_bridge.current_size = (void *) (values + i);
-
-			agp_bridge.aperture_size_idx = i;
-			return values[i].size;
-		}
-	}
-
-	return 0;
-}
-
-static int serverworks_configure(void)
-{
-	aper_size_info_lvl2 *current_size;
-	u32 temp;
-	u8 enable_reg;
-	u8 cap_ptr;
-	u32 cap_id;
-	u16 cap_reg;
-
-	current_size = A_SIZE_LVL2(agp_bridge.current_size);
-
-	/* Get the memory mapped registers */
-	pci_read_config_dword(agp_bridge.dev,
-			      serverworks_private.mm_addr_ofs,
-			      &temp);
-	temp = (temp & PCI_BASE_ADDRESS_MEM_MASK);
-	serverworks_private.registers = (volatile u8 *) ioremap(temp, 4096);
-
-	OUTREG8(serverworks_private.registers, SVWRKS_GART_CACHE, 0x0a);
-
-	OUTREG32(serverworks_private.registers, SVWRKS_GATTBASE, 
-		 agp_bridge.gatt_bus_addr);
-
-	cap_reg = INREG16(serverworks_private.registers, SVWRKS_COMMAND);
-	cap_reg &= ~0x0007;
-	cap_reg |= 0x4;
-	OUTREG16(serverworks_private.registers, SVWRKS_COMMAND, cap_reg);
-
-	pci_read_config_byte(serverworks_private.svrwrks_dev,
-			     SVWRKS_AGP_ENABLE, &enable_reg);
-	enable_reg |= 0x1; /* Agp Enable bit */
-	pci_write_config_byte(serverworks_private.svrwrks_dev,
-			      SVWRKS_AGP_ENABLE, enable_reg);
-	agp_bridge.tlb_flush(NULL);
-
-	pci_read_config_byte(serverworks_private.svrwrks_dev, 0x34, &cap_ptr);
-	if (cap_ptr != 0x00) {
-		do {
-			pci_read_config_dword(serverworks_private.svrwrks_dev,
-					      cap_ptr, &cap_id);
-
-			if ((cap_id & 0xff) != 0x02)
-				cap_ptr = (cap_id >> 8) & 0xff;
-		}
-		while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-	}
-	agp_bridge.capndx = cap_ptr;
-
-	/* Fill in the mode register */
-	pci_read_config_dword(serverworks_private.svrwrks_dev,
-			      agp_bridge.capndx + 4,
-			      &agp_bridge.mode);
-
-	pci_read_config_byte(agp_bridge.dev,
-			     SVWRKS_CACHING,
-			     &enable_reg);
-	enable_reg &= ~0x3;
-	pci_write_config_byte(agp_bridge.dev,
-			      SVWRKS_CACHING,
-			      enable_reg);
-
-	pci_read_config_byte(agp_bridge.dev,
-			     SVWRKS_FEATURE,
-			     &enable_reg);
-	enable_reg |= (1<<6);
-	pci_write_config_byte(agp_bridge.dev,
-			      SVWRKS_FEATURE,
-			      enable_reg);
-
-	return 0;
-}
-
-static void serverworks_cleanup(void)
-{
-	iounmap((void *) serverworks_private.registers);
-}
-
-/*
- * This routine could be implemented by taking the addresses
- * written to the GATT, and flushing them individually.  However
- * currently it just flushes the whole table.  Which is probably
- * more efficent, since agp_memory blocks can be a large number of
- * entries.
- */
-
-static void serverworks_tlbflush(agp_memory * temp)
-{
-	unsigned long end;
-
-	OUTREG8(serverworks_private.registers, SVWRKS_POSTFLUSH, 0x01);
-	end = jiffies + 3*HZ;
-	while(INREG8(serverworks_private.registers, 
-		     SVWRKS_POSTFLUSH) == 0x01) {
-		if((signed)(end - jiffies) <= 0) {
-			printk(KERN_ERR "Posted write buffer flush took more"
-			       "then 3 seconds\n");
-		}
-	}
-	OUTREG32(serverworks_private.registers, SVWRKS_DIRFLUSH, 0x00000001);
-	end = jiffies + 3*HZ;
-	while(INREG32(serverworks_private.registers, 
-		     SVWRKS_DIRFLUSH) == 0x00000001) {
-		if((signed)(end - jiffies) <= 0) {
-			printk(KERN_ERR "TLB flush took more"
-			       "then 3 seconds\n");
-		}
-	}
-}
-
-static unsigned long serverworks_mask_memory(unsigned long addr, int type)
-{
-	/* Only type 0 is supported by the serverworks chipsets */
-
-	return addr | agp_bridge.masks[0].mask;
-}
-
-static int serverworks_insert_memory(agp_memory * mem,
-			     off_t pg_start, int type)
-{
-	int i, j, num_entries;
-	unsigned long *cur_gatt;
-	unsigned long addr;
-
-	num_entries = A_SIZE_LVL2(agp_bridge.current_size)->num_entries;
-
-	if (type != 0 || mem->type != 0) {
-		return -EINVAL;
-	}
-	if ((pg_start + mem->page_count) > num_entries) {
-		return -EINVAL;
-	}
-
-	j = pg_start;
-	while (j < (pg_start + mem->page_count)) {
-		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
-		cur_gatt = SVRWRKS_GET_GATT(addr);
-		if (!PGE_EMPTY(cur_gatt[GET_GATT_OFF(addr)])) {
-			return -EBUSY;
-		}
-		j++;
-	}
-
-	if (mem->is_flushed == FALSE) {
-		CACHE_FLUSH();
-		mem->is_flushed = TRUE;
-	}
-
-	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		addr = (j * PAGE_SIZE) + agp_bridge.gart_bus_addr;
-		cur_gatt = SVRWRKS_GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = mem->memory[i];
-	}
-	agp_bridge.tlb_flush(mem);
-	return 0;
-}
-
-static int serverworks_remove_memory(agp_memory * mem, off_t pg_start,
-			     int type)
-{
-	int i;
-	unsigned long *cur_gatt;
-	unsigned long addr;
-
-	if (type != 0 || mem->type != 0) {
-		return -EINVAL;
-	}
-
-	CACHE_FLUSH();
-	agp_bridge.tlb_flush(mem);
-
-	for (i = pg_start; i < (mem->page_count + pg_start); i++) {
-		addr = (i * PAGE_SIZE) + agp_bridge.gart_bus_addr;
-		cur_gatt = SVRWRKS_GET_GATT(addr);
-		cur_gatt[GET_GATT_OFF(addr)] = 
-			(unsigned long) agp_bridge.scratch_page;
-	}
-
-	agp_bridge.tlb_flush(mem);
-	return 0;
-}
-
-static gatt_mask serverworks_masks[] =
-{
-	{0x00000001, 0}
-};
-
-static aper_size_info_lvl2 serverworks_sizes[7] =
-{
-	{2048, 524288, 0x80000000},
-	{1024, 262144, 0xc0000000},
-	{512, 131072, 0xe0000000},
-	{256, 65536, 0xf0000000},
-	{128, 32768, 0xf8000000},
-	{64, 16384, 0xfc000000},
-	{32, 8192, 0xfe000000}
-};
-
-static void serverworks_agp_enable(u32 mode)
-{
-	struct pci_dev *device = NULL;
-	u32 command, scratch, cap_id;
-	u8 cap_ptr;
-
-	pci_read_config_dword(serverworks_private.svrwrks_dev,
-			      agp_bridge.capndx + 4,
-			      &command);
-
-	/*
-	 * PASS1: go throu all devices that claim to be
-	 *        AGP devices and collect their data.
-	 */
-
-
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00) {
-			do {
-				pci_read_config_dword(device,
-						      cap_ptr, &cap_id);
-
-				if ((cap_id & 0xff) != 0x02)
-					cap_ptr = (cap_id >> 8) & 0xff;
-			}
-			while (((cap_id & 0xff) != 0x02) && (cap_ptr != 0x00));
-		}
-		if (cap_ptr != 0x00) {
-			/*
-			 * Ok, here we have a AGP device. Disable impossible 
-			 * settings, and adjust the readqueue to the minimum.
-			 */
-
-			pci_read_config_dword(device, cap_ptr + 4, &scratch);
-
-			/* adjust RQ depth */
-			command =
-			    ((command & ~0xff000000) |
-			     min_t(u32, (mode & 0xff000000),
-				 min_t(u32, (command & 0xff000000),
-				     (scratch & 0xff000000))));
-
-			/* disable SBA if it's not supported */
-			if (!((command & 0x00000200) &&
-			      (scratch & 0x00000200) &&
-			      (mode & 0x00000200)))
-				command &= ~0x00000200;
-
-			/* disable FW */
-			command &= ~0x00000010;
-
-			command &= ~0x00000008;
-
-			if (!((command & 4) &&
-			      (scratch & 4) &&
-			      (mode & 4)))
-				command &= ~0x00000004;
-
-			if (!((command & 2) &&
-			      (scratch & 2) &&
-			      (mode & 2)))
-				command &= ~0x00000002;
-
-			if (!((command & 1) &&
-			      (scratch & 1) &&
-			      (mode & 1)))
-				command &= ~0x00000001;
-		}
-	}
-	/*
-	 * PASS2: Figure out the 4X/2X/1X setting and enable the
-	 *        target (our motherboard chipset).
-	 */
-
-	if (command & 4) {
-		command &= ~3;	/* 4X */
-	}
-	if (command & 2) {
-		command &= ~5;	/* 2X */
-	}
-	if (command & 1) {
-		command &= ~6;	/* 1X */
-	}
-	command |= 0x00000100;
-
-	pci_write_config_dword(serverworks_private.svrwrks_dev,
-			       agp_bridge.capndx + 8,
-			       command);
-
-	/*
-	 * PASS3: Go throu all AGP devices and update the
-	 *        command registers.
-	 */
-
-	pci_for_each_dev(device) {
-		cap_ptr = pci_find_capability(device, PCI_CAP_ID_AGP);
-		if (cap_ptr != 0x00)
-			pci_write_config_dword(device, cap_ptr + 8, command);
-	}
-}
-
-static int __init serverworks_setup (struct pci_dev *pdev)
-{
-	u32 temp;
-	u32 temp2;
-
-	serverworks_private.svrwrks_dev = pdev;
-
-	agp_bridge.masks = serverworks_masks;
-	agp_bridge.num_of_masks = 1;
-	agp_bridge.aperture_sizes = (void *) serverworks_sizes;
-	agp_bridge.size_type = LVL2_APER_SIZE;
-	agp_bridge.num_aperture_sizes = 7;
-	agp_bridge.dev_private_data = (void *) &serverworks_private;
-	agp_bridge.needs_scratch_page = TRUE;
-	agp_bridge.configure = serverworks_configure;
-	agp_bridge.fetch_size = serverworks_fetch_size;
-	agp_bridge.cleanup = serverworks_cleanup;
-	agp_bridge.tlb_flush = serverworks_tlbflush;
-	agp_bridge.mask_memory = serverworks_mask_memory;
-	agp_bridge.agp_enable = serverworks_agp_enable;
-	agp_bridge.cache_flush = global_cache_flush;
-	agp_bridge.create_gatt_table = serverworks_create_gatt_table;
-	agp_bridge.free_gatt_table = serverworks_free_gatt_table;
-	agp_bridge.insert_memory = serverworks_insert_memory;
-	agp_bridge.remove_memory = serverworks_remove_memory;
-	agp_bridge.alloc_by_type = agp_generic_alloc_by_type;
-	agp_bridge.free_by_type = agp_generic_free_by_type;
-	agp_bridge.agp_alloc_page = agp_generic_alloc_page;
-	agp_bridge.agp_destroy_page = agp_generic_destroy_page;
-	agp_bridge.suspend = agp_generic_suspend;
-	agp_bridge.resume = agp_generic_resume;
-	agp_bridge.cant_use_aperture = 0;
-
-	pci_read_config_dword(agp_bridge.dev,
-			      SVWRKS_APSIZE,
-			      &temp);
-
-	serverworks_private.gart_addr_ofs = 0x10;
-
-	if(temp & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		pci_read_config_dword(agp_bridge.dev,
-				      SVWRKS_APSIZE + 4,
-				      &temp2);
-		if(temp2 != 0) {
-			printk("Detected 64 bit aperture address, but top "
-			       "bits are not zero.  Disabling agp\n");
-			return -ENODEV;
-		}
-		serverworks_private.mm_addr_ofs = 0x18;
-	} else {
-		serverworks_private.mm_addr_ofs = 0x14;
-	}
-
-	pci_read_config_dword(agp_bridge.dev,
-			      serverworks_private.mm_addr_ofs,
-			      &temp);
-	if(temp & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		pci_read_config_dword(agp_bridge.dev,
-				      serverworks_private.mm_addr_ofs + 4,
-				      &temp2);
-		if(temp2 != 0) {
-			printk("Detected 64 bit MMIO address, but top "
-			       "bits are not zero.  Disabling agp\n");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
diff -Nru a/drivers/char/agp/agpgart_be-sis.c b/drivers/char/agp/agpgart_be-sis.c
--- a/drivers/char/agp/agpgart_be-sis.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-sis.c	Thu Jul 11 16:15:37 2002
@@ -25,28 +25,10 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
@@ -54,7 +36,7 @@
 {
 	u8 temp_size;
 	int i;
-	aper_size_info_8 *values;
+	struct aper_size_info_8 *values;
 
 	pci_read_config_byte(agp_bridge.dev, SIS_APSIZE, &temp_size);
 	values = A_SIZE_8(agp_bridge.aperture_sizes);
@@ -82,7 +64,7 @@
 static int sis_configure(void)
 {
 	u32 temp;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 	pci_write_config_byte(agp_bridge.dev, SIS_TLBCNTRL, 0x05);
@@ -97,7 +79,7 @@
 
 static void sis_cleanup(void)
 {
-	aper_size_info_8 *previous_size;
+	struct aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
 	pci_write_config_byte(agp_bridge.dev, SIS_APSIZE,
@@ -111,7 +93,7 @@
 	return addr | agp_bridge.masks[0].mask;
 }
 
-static aper_size_info_8 sis_generic_sizes[7] =
+static struct aper_size_info_8 sis_generic_sizes[7] =
 {
 	{256, 65536, 6, 99},
 	{128, 32768, 5, 83},
@@ -122,9 +104,9 @@
 	{4, 1024, 0, 3}
 };
 
-static gatt_mask sis_generic_masks[] =
+static struct gatt_mask sis_generic_masks[] =
 {
-	{0x00000000, 0}
+	{mask: 0x00000000, type: 0}
 };
 
 int __init sis_generic_setup (struct pci_dev *pdev)
diff -Nru a/drivers/char/agp/agpgart_be-sworks.c b/drivers/char/agp/agpgart_be-sworks.c
--- a/drivers/char/agp/agpgart_be-sworks.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-sworks.c	Thu Jul 11 16:15:37 2002
@@ -25,48 +25,30 @@
  * TODO: 
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
-#include <linux/config.h>
-#include <linux/version.h>
+
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
-typedef struct _serverworks_page_map {
+struct serverworks_page_map {
 	unsigned long *real;
 	unsigned long *remapped;
-} serverworks_page_map;
+};
 
 static struct _serverworks_private {
 	struct pci_dev *svrwrks_dev;	/* device one */
 	volatile u8 *registers;
-	serverworks_page_map **gatt_pages;
+	struct serverworks_page_map **gatt_pages;
 	int num_tables;
-	serverworks_page_map scratch_dir;
+	struct serverworks_page_map scratch_dir;
 
 	int gart_addr_ofs;
 	int mm_addr_ofs;
 } serverworks_private;
 
-static int serverworks_create_page_map(serverworks_page_map *page_map)
+static int serverworks_create_page_map(struct serverworks_page_map *page_map)
 {
 	int i;
 
@@ -93,7 +75,7 @@
 	return 0;
 }
 
-static void serverworks_free_page_map(serverworks_page_map *page_map)
+static void serverworks_free_page_map(struct serverworks_page_map *page_map)
 {
 	iounmap(page_map->remapped);
 	ClearPageReserved(virt_to_page(page_map->real));
@@ -103,8 +85,8 @@
 static void serverworks_free_gatt_pages(void)
 {
 	int i;
-	serverworks_page_map **tables;
-	serverworks_page_map *entry;
+	struct serverworks_page_map **tables;
+	struct serverworks_page_map *entry;
 
 	tables = serverworks_private.gatt_pages;
 	for(i = 0; i < serverworks_private.num_tables; i++) {
@@ -121,24 +103,24 @@
 
 static int serverworks_create_gatt_pages(int nr_tables)
 {
-	serverworks_page_map **tables;
-	serverworks_page_map *entry;
+	struct serverworks_page_map **tables;
+	struct serverworks_page_map *entry;
 	int retval = 0;
 	int i;
 
-	tables = kmalloc((nr_tables + 1) * sizeof(serverworks_page_map *), 
+	tables = kmalloc((nr_tables + 1) * sizeof(struct serverworks_page_map *), 
 			 GFP_KERNEL);
 	if (tables == NULL) {
 		return -ENOMEM;
 	}
-	memset(tables, 0, sizeof(serverworks_page_map *) * (nr_tables + 1));
+	memset(tables, 0, sizeof(struct serverworks_page_map *) * (nr_tables + 1));
 	for (i = 0; i < nr_tables; i++) {
-		entry = kmalloc(sizeof(serverworks_page_map), GFP_KERNEL);
+		entry = kmalloc(sizeof(struct serverworks_page_map), GFP_KERNEL);
 		if (entry == NULL) {
 			retval = -ENOMEM;
 			break;
 		}
-		memset(entry, 0, sizeof(serverworks_page_map));
+		memset(entry, 0, sizeof(struct serverworks_page_map));
 		tables[i] = entry;
 		retval = serverworks_create_page_map(entry);
 		if (retval != 0) break;
@@ -169,8 +151,8 @@
 
 static int serverworks_create_gatt_table(void)
 {
-	aper_size_info_lvl2 *value;
-	serverworks_page_map page_dir;
+	struct aper_size_info_lvl2 *value;
+	struct serverworks_page_map page_dir;
 	int retval;
 	u32 temp;
 	int i;
@@ -227,7 +209,7 @@
 
 static int serverworks_free_gatt_table(void)
 {
-	serverworks_page_map page_dir;
+	struct serverworks_page_map page_dir;
    
 	page_dir.real = agp_bridge.gatt_table_real;
 	page_dir.remapped = agp_bridge.gatt_table;
@@ -243,7 +225,7 @@
 	int i;
 	u32 temp;
 	u32 temp2;
-	aper_size_info_lvl2 *values;
+	struct aper_size_info_lvl2 *values;
 
 	values = A_SIZE_LVL2(agp_bridge.aperture_sizes);
 	pci_read_config_dword(agp_bridge.dev,
@@ -275,7 +257,7 @@
 
 static int serverworks_configure(void)
 {
-	aper_size_info_lvl2 *current_size;
+	struct aper_size_info_lvl2 *current_size;
 	u32 temp;
 	u8 enable_reg;
 	u8 cap_ptr;
@@ -454,12 +436,12 @@
 	return 0;
 }
 
-static gatt_mask serverworks_masks[] =
+static struct gatt_mask serverworks_masks[] =
 {
-	{0x00000001, 0}
+	{mask: 0x00000001, type: 0}
 };
 
-static aper_size_info_lvl2 serverworks_sizes[7] =
+static struct aper_size_info_lvl2 serverworks_sizes[7] =
 {
 	{2048, 524288, 0x80000000},
 	{1024, 262144, 0xc0000000},
diff -Nru a/drivers/char/agp/agpgart_be-via.c b/drivers/char/agp/agpgart_be-via.c
--- a/drivers/char/agp/agpgart_be-via.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be-via.c	Thu Jul 11 16:15:37 2002
@@ -26,27 +26,10 @@
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
 #include <linux/config.h>
-#include <linux/version.h>
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
-#include <linux/miscdevice.h>
-#include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
@@ -55,7 +38,7 @@
 {
 	int i;
 	u8 temp;
-	aper_size_info_8 *values;
+	struct aper_size_info_8 *values;
 
 	values = A_SIZE_8(agp_bridge.aperture_sizes);
 	pci_read_config_byte(agp_bridge.dev, VIA_APSIZE, &temp);
@@ -74,7 +57,7 @@
 static int via_configure(void)
 {
 	u32 temp;
-	aper_size_info_8 *current_size;
+	struct aper_size_info_8 *current_size;
 
 	current_size = A_SIZE_8(agp_bridge.current_size);
 	/* aperture size */
@@ -95,7 +78,7 @@
 
 static void via_cleanup(void)
 {
-	aper_size_info_8 *previous_size;
+	struct aper_size_info_8 *previous_size;
 
 	previous_size = A_SIZE_8(agp_bridge.previous_size);
 	pci_write_config_byte(agp_bridge.dev, VIA_APSIZE,
@@ -118,7 +101,7 @@
 	return addr | agp_bridge.masks[0].mask;
 }
 
-static aper_size_info_8 via_generic_sizes[7] =
+static struct aper_size_info_8 via_generic_sizes[7] =
 {
 	{256, 65536, 6, 0},
 	{128, 32768, 5, 128},
@@ -129,9 +112,9 @@
 	{4, 1024, 0, 252}
 };
 
-static gatt_mask via_generic_masks[] =
+static struct gatt_mask via_generic_masks[] =
 {
-	{0x00000000, 0}
+	{mask: 0x00000000, type: 0}
 };
 
 int __init via_generic_setup (struct pci_dev *pdev)
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_be.c	Thu Jul 11 16:15:37 2002
@@ -26,27 +26,12 @@
  * - Allocate more than order 0 pages to avoid too much linear map splitting.
  */
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/jiffies.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
-#include <asm/system.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/agp.h>
-
 #include <linux/agp_backend.h>
 #include "agp.h"
 
@@ -523,9 +508,9 @@
 		} while ((table == NULL) &&
 			 (i < agp_bridge.num_aperture_sizes));
 	} else {
-		size = ((aper_size_info_fixed *) temp)->size;
-		page_order = ((aper_size_info_fixed *) temp)->page_order;
-		num_entries = ((aper_size_info_fixed *) temp)->num_entries;
+		size = ((struct aper_size_info_fixed *) temp)->size;
+		page_order = ((struct aper_size_info_fixed *) temp)->page_order;
+		num_entries = ((struct aper_size_info_fixed *) temp)->num_entries;
 		table = (char *) __get_free_pages(GFP_KERNEL, page_order);
 	}
 
@@ -770,307 +755,401 @@
 } agp_bridge_info[] __initdata = {
 
 #ifdef CONFIG_AGP_ALI
-	{ PCI_DEVICE_ID_AL_M1541_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1541,
-		"Ali",
-		"M1541",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1621_0,  
-		PCI_VENDOR_ID_AL,
-		ALI_M1621,
-		"Ali",
-		"M1621",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1631_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1631,
-		"Ali",
-		"M1631",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1632_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1632,
-		"Ali",
-		"M1632",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1641_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1641,
-		"Ali",
-		"M1641",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1644_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1644,
-		"Ali",
-		"M1644",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1647_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1647,
-		"Ali",
-		"M1647",
-		ali_generic_setup },
-	{ PCI_DEVICE_ID_AL_M1651_0,
-		PCI_VENDOR_ID_AL,
-		ALI_M1651,
-		"Ali",
-		"M1651",
-		ali_generic_setup },  
-	{ 0,
-		PCI_VENDOR_ID_AL,
-		ALI_GENERIC,
-		"Ali",
-		"Generic",
-		ali_generic_setup },
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1541_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1541,
+		vendor_name:	"Ali",
+		chipset_name:	"M1541",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1621_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1621,
+		vendor_name:	"Ali",
+		chipset_name:	"M1621",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1631_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1631,
+		vendor_name:	"Ali",
+		chipset_name:	"M1631",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1632_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1632,
+		vendor_name:	"Ali",
+		chipset_name:	"M1632",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1641_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1641,
+		vendor_name:	"Ali",
+		chipset_name:	"M1641",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1644_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1644,
+		vendor_name:	"Ali",
+		chipset_name:	"M1644",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1647_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1647,
+		vendor_name:	"Ali",
+		chipset_name:	"M1647",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AL_M1651_0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_M1651,
+		vendor_name:	"Ali",
+		chipset_name:	"M1651",
+		chipset_setup:	ali_generic_setup,
+	},
+	{
+		device_id:	0,
+		vendor_id:	PCI_VENDOR_ID_AL,
+		chipset:	ALI_GENERIC,
+		vendor_name:	"Ali",
+		chipset_name:	"Generic",
+		chipset_setup:	ali_generic_setup,
+	},
 #endif /* CONFIG_AGP_ALI */
 
 #ifdef CONFIG_AGP_AMD
-	{ PCI_DEVICE_ID_AMD_IRONGATE_0,
-		PCI_VENDOR_ID_AMD,
-		AMD_IRONGATE,
-		"AMD",
-		"Irongate",
-		amd_irongate_setup },
-	{ PCI_DEVICE_ID_AMD_761_0,
-		PCI_VENDOR_ID_AMD,
-		AMD_761,
-		"AMD",
-		"761",
-		amd_irongate_setup },
-	{ PCI_DEVICE_ID_AMD_762_0,
-		PCI_VENDOR_ID_AMD,
-		AMD_762,
-		"AMD",
-		"760MP",
-		amd_irongate_setup },
-	{ 0,
-		PCI_VENDOR_ID_AMD,
-		AMD_GENERIC,
-		"AMD",
-		"Generic",
-		amd_irongate_setup },
+	{
+		device_id:	PCI_DEVICE_ID_AMD_IRONGATE_0,
+		vendor_id:	PCI_VENDOR_ID_AMD,
+		chipset:	AMD_IRONGATE,
+		vendor_name:	"AMD",
+		chipset_name:	"Irongate",
+		chipset_setup:	amd_irongate_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AMD_761_0,
+		vendor_id:	PCI_VENDOR_ID_AMD,
+		chipset:	AMD_761,
+		vendor_name:	"AMD",
+		chipset_name:	"761",
+		chipset_setup:	amd_irongate_setup,
+	},
+	{
+		device_id:	PCI_DEVICE_ID_AMD_762_0,
+		vendor_id:	PCI_VENDOR_ID_AMD,
+		chipset:	AMD_762,
+		vendor_name:	"AMD",
+		chipset_name:	"760MP",
+		chipset_setup:	amd_irongate_setup,
+	},
+	{
+		device_id:	0,
+		vendor_id:	PCI_VENDOR_ID_AMD,
+		chipset:	AMD_GENERIC,
+		vendor_name:	"AMD",
+		chipset_name:	"Generic",
+		chipset_setup:	amd_irongate_setup,
+	},
 #endif /* CONFIG_AGP_AMD */
 
 #ifdef CONFIG_AGP_INTEL
-	{ PCI_DEVICE_ID_INTEL_82443LX_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_LX,
-		"Intel",
-		"440LX",
-		intel_generic_setup },
-	{ PCI_DEVICE_ID_INTEL_82443BX_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_BX,
-		"Intel",
-		"440BX",
-		intel_generic_setup },
-	{ PCI_DEVICE_ID_INTEL_82443GX_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_GX,
-		"Intel",
-		"440GX",
-		intel_generic_setup },
-	{ PCI_DEVICE_ID_INTEL_815_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I815,
-		"Intel",
-		"i815",
-		intel_815_setup },
-	{ PCI_DEVICE_ID_INTEL_820_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I820,
-		"Intel",
-		"i820",
-		intel_820_setup },
-	{ PCI_DEVICE_ID_INTEL_820_UP_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I820,
-		"Intel",
-		"i820",
-		intel_820_setup },
-	{ PCI_DEVICE_ID_INTEL_830_M_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I830_M,
-		"Intel",
-		"i830M",
-		intel_830mp_setup },
-    { PCI_DEVICE_ID_INTEL_845_G_0,
-		 PCI_VENDOR_ID_INTEL,
-		 INTEL_I845_G,
-		 "Intel",
-		 "i845G",
-		 intel_830mp_setup },
-	{ PCI_DEVICE_ID_INTEL_840_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I840,
-		"Intel",
-		"i840",
-		intel_840_setup },
-	{ PCI_DEVICE_ID_INTEL_845_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I845,
-		"Intel",
-		"i845",
-		intel_845_setup },
-	{ PCI_DEVICE_ID_INTEL_850_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I850,
-		"Intel",
-		"i850",
-intel_850_setup },
-	{ PCI_DEVICE_ID_INTEL_860_0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_I860,
-		"Intel",
-		"i860",
-		intel_860_setup },
-	{ 0,
-		PCI_VENDOR_ID_INTEL,
-		INTEL_GENERIC,
-		"Intel",
-		"Generic",
-		intel_generic_setup },
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_82443LX_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_LX,
+		vendor_name:	"Intel",
+		chipset_name:	"440LX",
+		chipset_setup:	intel_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_82443BX_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_BX,
+		vendor_name:	"Intel",
+		chipset_name:	"440BX",
+		chipset_setup:	intel_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_82443GX_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_GX,
+		vendor_name:	"Intel",
+		chipset_name:	"440GX",
+		chipset_setup:	intel_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_815_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I815,
+		vendor_name:	"Intel",
+		chipset_name:	"i815",
+		chipset_setup:	intel_815_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_820_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I820,
+		vendor_name:	"Intel",
+		chipset_name:	"i820",
+		chipset_setup:	intel_820_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_820_UP_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I820,
+		vendor_name:	"Intel",
+		chipset_name:	"i820",
+		chipset_setup:	intel_820_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_830_M_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I830_M,
+		vendor_name:	"Intel",
+		chipset_name:	"i830M",
+		chipset_setup:	intel_830mp_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_845_G_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I845_G,
+		vendor_name:	"Intel",
+		chipset_name:	"i845G",
+		chipset_setup:	intel_830mp_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_840_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I840,
+		vendor_name:	"Intel",
+		chipset_name:	"i840",
+		chipset_setup:	intel_840_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_845_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I845,
+		vendor_name:	"Intel",
+		chipset_name:	"i845",
+		chipset_setup:	intel_845_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_850_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I850,
+		vendor_name:	"Intel",
+		chipset_name:	"i850",
+		chipset_setup:	intel_850_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_INTEL_860_0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_I860,
+		vendor_name:	"Intel",
+		chipset_name:	"i860",
+		chipset_setup:	intel_860_setup
+	},
+	{
+		device_id:	0,
+		vendor_id:	PCI_VENDOR_ID_INTEL,
+		chipset:	INTEL_GENERIC,
+		vendor_name:	"Intel",
+		chipset_name:	"Generic",
+		chipset_setup:	intel_generic_setup
+	},
 
 #endif /* CONFIG_AGP_INTEL */
 
 #ifdef CONFIG_AGP_SIS
-	{ PCI_DEVICE_ID_SI_740,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"740",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_650,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"650",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_645,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"645",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_735,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"735",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_745,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"745",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_730,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"730",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_630,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"630",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_540,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"540",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_620,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"620",
-		sis_generic_setup },
-	{ PCI_DEVICE_ID_SI_530,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"530",
-		sis_generic_setup },
-        { PCI_DEVICE_ID_SI_550,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-                "550",
-		sis_generic_setup },
-	{ 0,
-		PCI_VENDOR_ID_SI,
-		SIS_GENERIC,
-		"SiS",
-		"Generic",
-		sis_generic_setup },
+	{
+		device_id:	PCI_DEVICE_ID_SI_740,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"740",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_650,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"650",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_645,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"645",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_735,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"735",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_745,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"745",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_730,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"730",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_630,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"630",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_540,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"540",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_620,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"620",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_SI_530,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"530",
+		chipset_setup:	sis_generic_setup
+	},
+        {
+		device_id:	PCI_DEVICE_ID_SI_550,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"550",
+		chipset_setup:	sis_generic_setup
+	},
+	{
+		device_id:	0,
+		vendor_id:	PCI_VENDOR_ID_SI,
+		chipset:	SIS_GENERIC,
+		vendor_name:	"SiS",
+		chipset_name:	"Generic",
+		chipset_setup:	sis_generic_setup
+	},
 #endif /* CONFIG_AGP_SIS */
 
 #ifdef CONFIG_AGP_VIA
-	{ PCI_DEVICE_ID_VIA_8501_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_MVP4,
-		"Via",
-		"MVP4",
-		via_generic_setup },
-	{ PCI_DEVICE_ID_VIA_82C597_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_VP3,
-		"Via",
-		"VP3",
-		via_generic_setup },
-	{ PCI_DEVICE_ID_VIA_82C598_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_MVP3,
-		"Via",
-		"MVP3",
-		via_generic_setup },
-	{ PCI_DEVICE_ID_VIA_82C691_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_APOLLO_PRO,
-		"Via",
-		"Apollo Pro",
-		via_generic_setup },
-	{ PCI_DEVICE_ID_VIA_8371_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_APOLLO_KX133,
-		"Via",
-		"Apollo Pro KX133",
-		via_generic_setup },
-	{ PCI_DEVICE_ID_VIA_8363_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_APOLLO_KT133,
-		"Via",
-		"Apollo Pro KT133",
-		via_generic_setup },
-	{ PCI_DEVICE_ID_VIA_8367_0,
-		PCI_VENDOR_ID_VIA,
-		VIA_APOLLO_KT133,
-		"Via",
-		"Apollo Pro KT266",
-		via_generic_setup },
-	{ 0,
-		PCI_VENDOR_ID_VIA,
-		VIA_GENERIC,
-		"Via",
-		"Generic",
-		via_generic_setup },
+	{
+		device_id:	PCI_DEVICE_ID_VIA_8501_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_MVP4,
+		vendor_name:	"Via",
+		chipset_name:	"MVP4",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_VIA_82C597_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_VP3,
+		vendor_name:	"Via",
+		chipset_name:	"VP3",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_VIA_82C598_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_MVP3,
+		vendor_name:	"Via",
+		chipset_name:	"MVP3",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_VIA_82C691_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_APOLLO_PRO,
+		vendor_name:	"Via",
+		chipset_name:	"Apollo Pro",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_VIA_8371_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_APOLLO_KX133,
+		vendor_name:	"Via",
+		chipset_name:	"Apollo Pro KX133",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_VIA_8363_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_APOLLO_KT133,
+		vendor_name:	"Via",
+		chipset_name:	"Apollo Pro KT133",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	PCI_DEVICE_ID_VIA_8367_0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_APOLLO_KT133,
+		vendor_name:	"Via",
+		chipset_name:	"Apollo Pro KT266",
+		chipset_setup:	via_generic_setup
+	},
+	{
+		device_id:	0,
+		vendor_id:	PCI_VENDOR_ID_VIA,
+		chipset:	VIA_GENERIC,
+		vendor_name:	"Via",
+		chipset_name:	"Generic",
+		chipset_setup:	via_generic_setup
+	},
 #endif /* CONFIG_AGP_VIA */
 
 #ifdef CONFIG_AGP_HP_ZX1
-	{ PCI_DEVICE_ID_HP_ZX1_LBA,
-		PCI_VENDOR_ID_HP,
-		HP_ZX1,
-		"HP",
-		"ZX1",
-		hp_zx1_setup },
+	{
+		device_id:	PCI_DEVICE_ID_HP_ZX1_LBA,
+		vendor_id:	PCI_VENDOR_ID_HP,
+		chipset:	HP_ZX1,
+		vendor_name:	"HP",
+		chipset_name:	"ZX1",
+		chipset_setup:	hp_zx1_setup
+	},
 #endif
 
-	{ 0, }, /* dummy final entry, always present */
+	{ }, /* dummy final entry, always present */
 };
 
 
@@ -1151,14 +1230,10 @@
 
 /* Supported Device Scanning routine */
 
-static int __init agp_find_supported_device(void)
+static int __init agp_find_supported_device(struct pci_dev *dev)
 {
-	struct pci_dev *dev = NULL;
 	u8 cap_ptr = 0x00;
 
-	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) == NULL)
-		return -ENODEV;
-
 	agp_bridge.dev = dev;
 
 	/* Need to test for I810 here */
@@ -1257,12 +1332,12 @@
 		   
 		case PCI_DEVICE_ID_INTEL_830_M_0:
 			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-									   PCI_DEVICE_ID_INTEL_830_M_1,
-									   NULL);
+						   PCI_DEVICE_ID_INTEL_830_M_1,
+						   NULL);
 			if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0) {
 				i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-										   PCI_DEVICE_ID_INTEL_830_M_1,
-										   i810_dev);
+							   PCI_DEVICE_ID_INTEL_830_M_1,
+							   i810_dev);
 			}
 
 			if (i810_dev == NULL) {
@@ -1314,24 +1389,21 @@
 		}
 	}
 
-#endif	/* CONFIG_AGP_SWORKS */
+#endif /* CONFIG_AGP_SWORKS */
 
 #ifdef CONFIG_AGP_HP_ZX1
 	if (dev->vendor == PCI_VENDOR_ID_HP) {
-		do {
-			/* ZX1 LBAs can be either PCI or AGP bridges */
-			if (pci_find_capability(dev, PCI_CAP_ID_AGP)) {
-				printk(KERN_INFO PFX "Detected HP ZX1 AGP "
-				       "chipset at %s\n", dev->slot_name);
-				agp_bridge.type = HP_ZX1;
-				agp_bridge.dev = dev;
-				return hp_zx1_setup(dev);
-			}
-			dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, dev);
-		} while (dev);
+		/* ZX1 LBAs can be either PCI or AGP bridges */
+		if (pci_find_capability(dev, PCI_CAP_ID_AGP)) {
+			printk(KERN_INFO PFX "Detected HP ZX1 AGP "
+			       "chipset at %s\n", dev->slot_name);
+			agp_bridge.type = HP_ZX1;
+			agp_bridge.dev = dev;
+			return hp_zx1_setup(dev);
+		}
 		return -ENODEV;
 	}
-#endif	/* CONFIG_AGP_HP_ZX1 */
+#endif /* CONFIG_AGP_HP_ZX1 */
 
 	/* find capndx */
 	cap_ptr = pci_find_capability(dev, PCI_CAP_ID_AGP);
@@ -1392,13 +1464,13 @@
 #define AGPGART_VERSION_MAJOR 0
 #define AGPGART_VERSION_MINOR 99
 
-static agp_version agp_current_version =
+static struct agp_version agp_current_version =
 {
-	AGPGART_VERSION_MAJOR,
-	AGPGART_VERSION_MINOR
+	major:	AGPGART_VERSION_MAJOR,
+	minor:	AGPGART_VERSION_MINOR,
 };
 
-static int __init agp_backend_initialize(void)
+static int __init agp_backend_initialize(struct pci_dev *dev)
 {
 	int size_value, rc, got_gatt=0, got_keylist=0;
 
@@ -1407,7 +1479,7 @@
 	agp_bridge.max_memory_agp = agp_find_max();
 	agp_bridge.version = &agp_current_version;
 
-	rc = agp_find_supported_device();
+	rc = agp_find_supported_device(dev);
 	if (rc) {
 		/* not KERN_ERR because error msg should have already printed */
 		printk(KERN_DEBUG PFX "no supported devices found.\n");
@@ -1518,14 +1590,11 @@
 	&agp_copy_info
 };
 
-static int __init agp_init(void)
+static int agp_probe (struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	int ret_val;
 
-	printk(KERN_INFO "Linux agpgart interface v%d.%d (c) Jeff Hartmann\n",
-	       AGPGART_VERSION_MAJOR, AGPGART_VERSION_MINOR);
-
-	ret_val = agp_backend_initialize();
+	ret_val = agp_backend_initialize(dev);
 	if (ret_val) {
 		agp_bridge.type = NOT_SUPPORTED;
 		return ret_val;
@@ -1543,12 +1612,50 @@
 	return 0;
 }
 
+static struct pci_device_id agp_pci_table[] __initdata = {
+	{
+	class:		(PCI_CLASS_BRIDGE_HOST << 8),
+	class_mask:	~0,
+	vendor:		PCI_ANY_ID,
+	device:		PCI_ANY_ID,
+	subvendor:	PCI_ANY_ID,
+	subdevice:	PCI_ANY_ID,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, agp_pci_table);
+
+static struct pci_driver agp_pci_driver = {
+	name:		"agpgart",
+	id_table:	agp_pci_table,
+	probe:		agp_probe,
+};
+
+static int __init agp_init(void)
+{
+	int ret_val;
+
+	printk(KERN_INFO "Linux agpgart interface v%d.%d (c) Jeff Hartmann\n",
+	       AGPGART_VERSION_MAJOR, AGPGART_VERSION_MINOR);
+
+	ret_val = pci_module_init(&agp_pci_driver);
+	if (ret_val) {
+		agp_bridge.type = NOT_SUPPORTED;
+		return ret_val;
+	}
+	return 0;
+}
+
 static void __exit agp_cleanup(void)
 {
-	pm_unregister_all(agp_power);
-	agp_frontend_cleanup();
-	agp_backend_cleanup();
-	inter_module_unregister("drm_agp");
+	pci_unregister_driver(&agp_pci_driver);
+	if (agp_bridge.type != NOT_SUPPORTED) {
+		pm_unregister_all(agp_power);
+		agp_frontend_cleanup();
+		agp_backend_cleanup();
+		inter_module_unregister("drm_agp");
+	}
 }
 
 module_init(agp_init);
diff -Nru a/drivers/char/agp/agpgart_fe.c b/drivers/char/agp/agpgart_fe.c
--- a/drivers/char/agp/agpgart_fe.c	Thu Jul 11 16:15:37 2002
+++ b/drivers/char/agp/agpgart_fe.c	Thu Jul 11 16:15:37 2002
@@ -24,29 +24,16 @@
  *
  */
 
-#define __NO_VERSION__
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
+#include <linux/mman.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#include <linux/pagemap.h>
 #include <linux/miscdevice.h>
 #include <linux/agp_backend.h>
 #include <linux/agpgart.h>
-#include <linux/smp_lock.h>
-#include <asm/system.h>
 #include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/page.h>
-#include <asm/mman.h>
 
 #include "agp.h"
 
diff -Nru a/include/linux/agp_backend.h b/include/linux/agp_backend.h
--- a/include/linux/agp_backend.h	Thu Jul 11 16:15:37 2002
+++ b/include/linux/agp_backend.h	Thu Jul 11 16:15:37 2002
@@ -81,13 +81,13 @@
 	HP_ZX1,
 };
 
-typedef struct _agp_version {
+struct agp_version {
 	u16 major;
 	u16 minor;
-} agp_version;
+};
 
 typedef struct _agp_kern_info {
-	agp_version version;
+	struct agp_version version;
 	struct pci_dev *device;
 	enum chipset_type chipset;
 	unsigned long mode;
diff -Nru a/include/linux/agpgart.h b/include/linux/agpgart.h
--- a/include/linux/agpgart.h	Thu Jul 11 16:15:37 2002
+++ b/include/linux/agpgart.h	Thu Jul 11 16:15:37 2002
@@ -53,13 +53,13 @@
 #include <linux/types.h>
 #include <asm/types.h>
 
-typedef struct _agp_version {
+struct agp_version {
 	__u16 major;
 	__u16 minor;
-} agp_version;
+};
 
 typedef struct _agp_info {
-	agp_version version;	/* version of the driver        */
+	struct agp_version version;	/* version of the driver        */
 	__u32 bridge_id;	/* bridge vendor/device         */
 	__u32 agp_mode;		/* mode info of bridge          */
 	off_t aper_base;	/* base of aperture             */
@@ -117,7 +117,7 @@
 #define AGP_LOCK_INIT() 	sema_init(&(agp_fe.agp_mutex), 1)
 
 #ifndef _AGP_BACKEND_H
-typedef struct _agp_version {
+struct _agp_version {
 	u16 major;
 	u16 minor;
 } agp_version;
@@ -125,7 +125,7 @@
 #endif
 
 typedef struct _agp_info {
-	agp_version version;	/* version of the driver        */
+	struct agp_version version;	/* version of the driver        */
 	u32 bridge_id;		/* bridge vendor/device         */
 	u32 agp_mode;		/* mode info of bridge          */
 	off_t aper_base;	/* base of aperture             */
