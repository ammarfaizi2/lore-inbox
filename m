Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270027AbUIDDWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270027AbUIDDWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270033AbUIDDWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:22:24 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:61411 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S270027AbUIDDM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:12:28 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/5] fbdev: Add module_init() and fb_get_options() per driver
Date: Sat, 4 Sep 2004 11:09:03 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041109.03991.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on PATCH 4/5.

This adds module_init(xxxfb_init) in all drivers.  For drivers with
xxxfb_setup(), this patch also adds a 'xxxfb_setup(fb_get_options("xxxfb"))'
prior to initialization.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 68328fb.c              |    6 +++++-
 acornfb.c              |    3 +++
 amba-clcd.c            |    3 +--
 amifb.c                |   10 +++++-----
 asiliantfb.c           |    2 ++
 aty/atyfb_base.c       |    5 +++++
 aty/radeon_base.c      |    6 +++++-
 bw2.c                  |    3 ++-
 cg14.c                 |    3 ++-
 cg3.c                  |    3 ++-
 cg6.c                  |    3 ++-
 chipsfb.c              |    2 ++
 cirrusfb.c             |    7 ++++++-
 clps711xfb.c           |    2 --
 controlfb.c            |    3 +++
 cyber2000fb.c          |    8 ++++++--
 dnfb.c                 |    2 ++
 epson1355fb.c          |    3 ++-
 ffb.c                  |    3 ++-
 fm2fb.c                |    5 ++++-
 g364fb.c               |    1 +
 gbefb.c                |    7 ++++++-
 hgafb.c                |    2 +-
 hitfb.c                |    3 ++-
 hpfb.c                 |    1 +
 i810/i810_main.c       |    5 +++--
 igafb.c                |    1 +
 imsttfb.c              |    5 ++++-
 kyro/fbdev.c           |    6 +++++-
 leo.c                  |    2 +-
 macfb.c                |    3 +++
 matrox/matroxfb_base.c |    4 ++++
 maxinefb.c             |    2 +-
 neofb.c                |    7 +++++--
 offb.c                 |    1 +
 p9100.c                |    3 ++-
 platinumfb.c           |    5 ++++-
 pm2fb.c                |    8 ++++++--
 pmag-ba-fb.c           |    1 +
 pmagb-b-fb.c           |    1 +
 pvr2fb.c               |    5 +++--
 pxafb.c                |   16 ++++++++++------
 q40fb.c                |    1 +
 radeonfb.c             |    7 ++++++-
 riva/fbdev.c           |    6 +++++-
 sa1100fb.c             |    1 +
 sgivwfb.c              |    6 +++++-
 sis/sis_main.c         |   11 +++++++++++
 skeletonfb.c           |    9 +++++++--
 sstfb.c                |    5 ++++-
 stifb.c                |    8 ++++++--
 tcx.c                  |    3 ++-
 tdfxfb.c               |    9 +++++----
 tgafb.c                |   18 +++++++++++-------
 tridentfb.c            |    7 +++++--
 tx3912fb.c             |    5 +++++
 valkyriefb.c           |    3 +++
 vesafb.c               |    2 ++
 vfb.c                  |    7 ++++++-
 vga16fb.c              |    5 ++++-
 60 files changed, 216 insertions(+), 68 deletions(-)

diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/68328fb.c linux-2.6.9-rc1-mm3/drivers/video/68328fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/68328fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/68328fb.c	2004-09-04 09:17:19.021818656 +0800
@@ -439,6 +439,9 @@ int __init mc68x328fb_setup(char *option
 
 int __init mc68x328fb_init(void)
 {
+#ifndef MODULE
+	mc68x328fb_setup(fb_get_options("68328fb"));
+#endif
 	/*
 	 *  initialize the default mode from the LCD controller registers
 	 */
@@ -484,6 +487,8 @@ int __init mc68x328fb_init(void)
 	return 0;
 }
 
+module_init(mc68x328fb_init);
+
 #ifdef MODULE
 
 static void __exit mc68x328fb_cleanup(void)
@@ -491,7 +496,6 @@ static void __exit mc68x328fb_cleanup(vo
 	unregister_framebuffer(&fb_info);
 }
 
-module_init(mc68x328fb_init);
 module_exit(mc68x328fb_cleanup);
 
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/acornfb.c linux-2.6.9-rc1-mm3/drivers/video/acornfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/acornfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/acornfb.c	2004-09-04 09:17:19.024818200 +0800
@@ -1292,6 +1292,7 @@ acornfb_init(void)
 	u_int h_sync, v_sync;
 	int rc, i;
 
+	acornfb_setup(fb_get_options("acornfb"));
 	acornfb_init_fbinfo();
 
 	current_par.dev = &acornfb_device;
@@ -1456,6 +1457,8 @@ acornfb_init(void)
 	return 0;
 }
 
+module_init(acornfb_init);
+
 MODULE_AUTHOR("Russell King");
 MODULE_DESCRIPTION("VIDC 1/1a/20 framebuffer driver");
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/amba-clcd.c linux-2.6.9-rc1-mm3/drivers/video/amba-clcd.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/amba-clcd.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/amba-clcd.c	2004-09-04 09:17:19.027817744 +0800
@@ -496,12 +496,11 @@ static struct amba_driver clcd_driver = 
 
 int __init amba_clcdfb_init(void)
 {
+
 	return amba_driver_register(&clcd_driver);
 }
 
-#ifdef MODULE
 module_init(amba_clcdfb_init);
-#endif
 
 static void __exit amba_clcdfb_exit(void)
 {
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/amifb.c linux-2.6.9-rc1-mm3/drivers/video/amifb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/amifb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/amifb.c	2004-09-04 09:17:19.031817136 +0800
@@ -2257,6 +2257,9 @@ int __init amifb_init(void)
 	u_long chipptr;
 	u_int defmode;
 
+#ifndef MODULE
+	amifb_setup(fb_get_options("amifb"));
+#endif
 	if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(AMI_VIDEO))
 		return -ENXIO;
 
@@ -3814,14 +3817,11 @@ static void ami_rebuild_copper(void)
 }
 
 
+module_init(amifb_init);
+
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return amifb_init();
-}
-
 void cleanup_module(void)
 {
 	unregister_framebuffer(&fb_info);
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/asiliantfb.c linux-2.6.9-rc1-mm3/drivers/video/asiliantfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/asiliantfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/asiliantfb.c	2004-09-04 09:17:19.035816528 +0800
@@ -612,6 +612,8 @@ int __init asiliantfb_init(void)
 	return pci_module_init(&asiliantfb_driver);
 }
 
+module_init(asiliantfb_init);
+
 static void __exit asiliantfb_exit(void)
 {
 	pci_unregister_driver(&asiliantfb_driver);
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/aty/atyfb_base.c linux-2.6.9-rc1-mm3/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/aty/atyfb_base.c	2004-08-17 21:51:37.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/aty/atyfb_base.c	2004-09-04 09:30:40.299006008 +0800
@@ -1904,6 +1904,10 @@ static int __init aty_init(struct fb_inf
 
 int __init atyfb_init(void)
 {
+#ifndef MODULE
+	atyfb_setup(fb_get_options("atyfb"));
+#endif
+
 #if defined(CONFIG_PCI)
 	unsigned long addr, res_start, res_size;
 	struct atyfb_par *default_par;
@@ -2445,6 +2449,7 @@ int __init atyfb_setup(char *options)
 	}
 	return 0;
 }
+module_init(atyfb_init);
 #endif				/* !MODULE */
 
 #ifdef CONFIG_ATARI
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/aty/radeon_base.c linux-2.6.9-rc1-mm3/drivers/video/aty/radeon_base.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/aty/radeon_base.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/aty/radeon_base.c	2004-09-04 09:17:19.042815464 +0800
@@ -2438,9 +2438,13 @@ static struct pci_driver radeonfb_driver
 #endif /* CONFIG_PM */
 };
 
+int __init radeonfb_setup (char *options);
 
 int __init radeonfb_init (void)
 {
+#ifndef MODULE
+	radeonfb_setup(fb_get_options("radeonfb"));
+#endif
 	return pci_module_init (&radeonfb_driver);
 }
 
@@ -2485,9 +2489,9 @@ int __init radeonfb_setup (char *options
 	return 0;
 }
 
+module_init(radeonfb_init);
 
 #ifdef MODULE
-module_init(radeonfb_init);
 module_exit(radeonfb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/bw2.c linux-2.6.9-rc1-mm3/drivers/video/bw2.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/bw2.c	2004-09-04 04:26:37.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/bw2.c	2004-09-04 09:17:19.046814856 +0800
@@ -416,8 +416,9 @@ bw2_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(bw2_init);
+
+#ifdef MODULE
 module_exit(bw2_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/cg14.c linux-2.6.9-rc1-mm3/drivers/video/cg14.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/cg14.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/cg14.c	2004-09-04 09:17:19.048814552 +0800
@@ -626,8 +626,9 @@ cg14_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(cg14_init);
+
+#ifdef MODULE
 module_exit(cg14_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/cg3.c linux-2.6.9-rc1-mm3/drivers/video/cg3.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/cg3.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/cg3.c	2004-09-04 09:17:19.050814248 +0800
@@ -473,8 +473,9 @@ cg3_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(cg3_init);
+
+#ifdef MODULE
 module_exit(cg3_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/cg6.c linux-2.6.9-rc1-mm3/drivers/video/cg6.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/cg6.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/cg6.c	2004-09-04 09:17:19.053813792 +0800
@@ -789,8 +789,9 @@ cg6_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(cg6_init);
+
+#ifdef MODULE
 module_exit(cg6_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/chipsfb.c linux-2.6.9-rc1-mm3/drivers/video/chipsfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/chipsfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/chipsfb.c	2004-09-04 09:17:19.055813488 +0800
@@ -465,6 +465,8 @@ int __init chips_init(void)
 	return pci_module_init(&chipsfb_driver);
 }
 
+module_init(chips_init);
+
 static void __exit chipsfb_exit(void)
 {
 	pci_unregister_driver(&chipsfb_driver);
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/cirrusfb.c linux-2.6.9-rc1-mm3/drivers/video/cirrusfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/cirrusfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/cirrusfb.c	2004-09-04 09:17:19.059812880 +0800
@@ -2606,6 +2606,10 @@ int __init cirrusfb_init(void)
 {
 	int error = 0;
 
+#ifndef MODULE
+	cirrusfb_setup(fb_get_options("cirrusfb"));
+#endif
+
 #ifdef CONFIG_ZORRO
 	error |= zorro_module_init(&cirrusfb_zorro_driver);
 #endif
@@ -2663,8 +2667,9 @@ void __exit cirrusfb_exit (void)
 #endif
 }
 
-#ifdef MODULE
 module_init(cirrusfb_init);
+
+#ifdef MODULE
 module_exit(cirrusfb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/clps711xfb.c linux-2.6.9-rc1-mm3/drivers/video/clps711xfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/clps711xfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/clps711xfb.c	2004-09-04 09:17:19.063812272 +0800
@@ -432,9 +432,7 @@ static void __exit clps711xfb_exit(void)
 	}
 }
 
-#ifdef MODULE
 module_init(clps711xfb_init);
-#endif
 module_exit(clps711xfb_exit);
 
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/controlfb.c linux-2.6.9-rc1-mm3/drivers/video/controlfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/controlfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/controlfb.c	2004-09-04 09:17:19.065811968 +0800
@@ -557,6 +557,8 @@ int __init control_init(void)
 {
 	struct device_node *dp;
 
+	control_setup(fb_get_options("controlfb"));
+
 	dp = find_devices("control");
 	if (dp != 0 && !control_of_init(dp))
 		return 0;
@@ -564,6 +566,7 @@ int __init control_init(void)
 	return -ENXIO;
 }
 
+module_init(control_init);
 
 /* Work out which banks of VRAM we have installed. */
 /* danj: I guess the card just ignores writes to nonexistant VRAM... */
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/cyber2000fb.c linux-2.6.9-rc1-mm3/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/cyber2000fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/cyber2000fb.c	2004-09-04 09:17:19.069811360 +0800
@@ -1712,11 +1712,17 @@ static struct pci_driver cyberpro_driver
  * I don't think we can use the "module_init" stuff here because
  * the fbcon stuff may not be initialised yet.  Hence the #ifdef
  * around module_init.
+ *
+ * Tony: "module_init" is now required
  */
 int __init cyber2000fb_init(void)
 {
 	int ret = -1, err;
 
+#ifndef MODULE
+	cyber2000fb_setup(fb_get_options("cyber200fb"));
+#endif
+
 #ifdef CONFIG_ARCH_SHARK
 	err = cyberpro_vl_probe();
 	if (!err) {
@@ -1738,9 +1744,7 @@ static void __exit cyberpro_exit(void)
 	pci_unregister_driver(&cyberpro_driver);
 }
 
-#ifdef MODULE
 module_init(cyber2000fb_init);
-#endif
 module_exit(cyberpro_exit);
 
 MODULE_AUTHOR("Russell King");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/dnfb.c linux-2.6.9-rc1-mm3/drivers/video/dnfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/dnfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/dnfb.c	2004-09-04 09:17:19.072810904 +0800
@@ -294,4 +294,6 @@ int __init dnfb_init(void)
 	return ret;
 }
 
+module_init(dnfb_init);
+
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/epson1355fb.c linux-2.6.9-rc1-mm3/drivers/video/epson1355fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/epson1355fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/epson1355fb.c	2004-09-04 09:17:19.074810600 +0800
@@ -748,6 +748,8 @@ int __init epson1355fb_init(void)
 	}
 	return ret;
 }
+
+module_init(epson1355fb_init);
 	
 #ifdef MODULE
 static void __exit epson1355fb_exit(void)
@@ -758,7 +760,6 @@ static void __exit epson1355fb_exit(void
 
 /* ------------------------------------------------------------------------- */
 
-module_init(epson1355fb_init);
 module_exit(epson1355fb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/ffb.c linux-2.6.9-rc1-mm3/drivers/video/ffb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/ffb.c	2004-09-04 04:26:37.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/ffb.c	2004-09-04 09:17:19.077810144 +0800
@@ -1079,8 +1079,9 @@ ffb_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(ffb_init);
+
+#ifdef MODULE
 module_exit(ffb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/fm2fb.c linux-2.6.9-rc1-mm3/drivers/video/fm2fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/fm2fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/fm2fb.c	2004-09-04 09:17:19.079809840 +0800
@@ -292,12 +292,14 @@ static int __devinit fm2fb_probe(struct 
 	return 0;
 }
 
+int __init fm2fb_setup(char *options);
+
 int __init fm2fb_init(void)
 {
+	fm2fb_setup(fb_get_options("fb2fb"));
 	return zorro_register_driver(&fm2fb_driver);
 }
 
-int __init fm2fb_setup(char *options)
 {
 	char *this_opt;
 
@@ -313,4 +315,5 @@ int __init fm2fb_setup(char *options)
 	return 0;
 }
 
+module_init(fm2fb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/g364fb.c linux-2.6.9-rc1-mm3/drivers/video/g364fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/g364fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/g364fb.c	2004-09-04 09:17:19.081809536 +0800
@@ -250,4 +250,5 @@ int __init g364fb_init(void)
 	return 0;
 }
 
+module_init(g364fb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/gbefb.c linux-2.6.9-rc1-mm3/drivers/video/gbefb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/gbefb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/gbefb.c	2004-09-04 09:17:19.084809080 +0800
@@ -1083,6 +1083,10 @@ int __init gbefb_init(void)
 {
 	int i, ret = 0;
 
+#ifndef MODULE
+	gbefb_setup(fb_get_options("gbefb"));
+#endif
+
 	if (!request_mem_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
 		printk(KERN_ERR "gbefb: couldn't reserve mmio region\n");
 		return -EBUSY;
@@ -1192,8 +1196,9 @@ void __exit gbefb_exit(void)
 	iounmap(gbe);
 }
 
-#ifdef MODULE
 module_init(gbefb_init);
+
+#ifdef MODULE
 module_exit(gbefb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/hgafb.c linux-2.6.9-rc1-mm3/drivers/video/hgafb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/hgafb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/hgafb.c	2004-09-04 09:17:19.087808624 +0800
@@ -609,8 +609,8 @@ MODULE_LICENSE("GPL");
 
 MODULE_PARM(nologo, "i");
 MODULE_PARM_DESC(nologo, "Disables startup logo if != 0 (default=0)");
+module_init(hgafb_init);
 
 #ifdef MODULE
-module_init(hgafb_init);
 module_exit(hgafb_exit);
 #endif
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/hitfb.c linux-2.6.9-rc1-mm3/drivers/video/hitfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/hitfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/hitfb.c	2004-09-04 09:17:19.089808320 +0800
@@ -341,8 +341,9 @@ static void __exit hitfb_exit(void)
 	unregister_framebuffer(&fb_info);
 }
 
-#ifdef MODULE
 module_init(hitfb_init);
+
+#ifdef MODULE
 module_exit(hitfb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/hpfb.c linux-2.6.9-rc1-mm3/drivers/video/hpfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/hpfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/hpfb.c	2004-09-04 09:17:19.091808016 +0800
@@ -211,4 +211,5 @@ int __init hpfb_init(void)
 	return 0;
 }
 
+module_init(hpfb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/i810/i810_main.c linux-2.6.9-rc1-mm3/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/i810/i810_main.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/i810/i810_main.c	2004-09-04 09:17:19.094807560 +0800
@@ -1989,6 +1989,8 @@ static void __exit i810fb_remove_pci(str
 #ifndef MODULE
 int __init i810fb_init(void)
 {
+	i810fb_setup(fb_get_options("i810fb"));
+
 	if (agp_intel_init()) {
 		printk("i810fb_init: cannot initialize intel agpgart\n");
 		return -ENODEV;
@@ -2068,9 +2070,8 @@ static void __exit i810fb_exit(void)
 {
 	pci_unregister_driver(&i810fb_driver);
 }
-module_init(i810fb_init);
 module_exit(i810fb_exit);
 
 #endif /* MODULE */
 
-
+module_init(i810fb_init);
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/igafb.c linux-2.6.9-rc1-mm3/drivers/video/igafb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/igafb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/igafb.c	2004-09-04 09:17:19.098806952 +0800
@@ -572,4 +572,5 @@ int __init igafb_setup(char *options)
     return 0;
 }
 
+module_init(igafb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/imsttfb.c linux-2.6.9-rc1-mm3/drivers/video/imsttfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/imsttfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/imsttfb.c	2004-09-04 09:17:19.100806648 +0800
@@ -1602,6 +1602,9 @@ imsttfb_setup(char *options)
 
 int __init imsttfb_init(void)
 {
+#ifndef MODULE
+	imsttfb_setup(fb_get_options("imsttfb"));
+#endif
 	return pci_module_init(&imsttfb_pci_driver);
 }
  
@@ -1612,7 +1615,7 @@ static void __exit imsttfb_exit(void)
 
 #ifdef MODULE
 MODULE_LICENSE("GPL");
-module_init(imsttfb_init);
 #endif
+module_init(imsttfb_init);
 module_exit(imsttfb_exit);
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/kyro/fbdev.c linux-2.6.9-rc1-mm3/drivers/video/kyro/fbdev.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/kyro/fbdev.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/kyro/fbdev.c	2004-09-04 09:17:19.103806192 +0800
@@ -787,6 +787,9 @@ static void __devexit kyrofb_remove(stru
 
 int __init kyrofb_init(void)
 {
+#ifndef MODULE
+	kyrofb_setup(fb_get_options("kyrofb"));
+#endif
 	return pci_module_init(&kyrofb_pci_driver);
 }
 
@@ -795,8 +798,9 @@ static void __exit kyrofb_exit(void)
 	pci_unregister_driver(&kyrofb_pci_driver);
 }
 
-#ifdef MODULE
 module_init(kyrofb_init);
+
+#ifdef MODULE
 module_exit(kyrofb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/leo.c linux-2.6.9-rc1-mm3/drivers/video/leo.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/leo.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/leo.c	2004-09-04 09:17:19.106805736 +0800
@@ -654,8 +654,8 @@ leo_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(leo_init);
+#ifdef MODULE
 module_exit(leo_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/macfb.c linux-2.6.9-rc1-mm3/drivers/video/macfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/macfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/macfb.c	2004-09-04 09:17:19.109805280 +0800
@@ -615,6 +615,8 @@ void __init macfb_init(void)
 	int video_cmap_len, video_is_nubus = 0;
 	struct nubus_dev* ndev = NULL;
 
+	macfb_setup(fb_get_options("macfb"));
+
 	if (!MACH_IS_MAC) 
 		return;
 
@@ -961,4 +963,5 @@ void __init macfb_init(void)
 	       fb_info.node, fb_info.fix.id);
 }
 
+module_init(macfb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/matrox/matroxfb_base.c linux-2.6.9-rc1-mm3/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/matrox/matroxfb_base.c	2004-08-17 21:51:38.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/matrox/matroxfb_base.c	2004-09-04 09:17:19.112804824 +0800
@@ -2417,6 +2417,8 @@ int __init matroxfb_init(void)
 {
 	DBG(__FUNCTION__)
 
+	matroxfb_setup(fb_get_options("matroxfb"));
+
 	if (disabled)
 		return -ENXIO;
 	if (!initialized) {
@@ -2428,6 +2430,8 @@ int __init matroxfb_init(void)
 	return 0;
 }
 
+module_init(matroxfb_init);
+
 #else
 
 /* *************************** init module code **************************** */
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/maxinefb.c linux-2.6.9-rc1-mm3/drivers/video/maxinefb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/maxinefb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/maxinefb.c	2004-09-04 09:17:19.115804368 +0800
@@ -175,7 +175,7 @@ static void __exit maxinefb_exit(void)
 
 #ifdef MODULE
 MODULE_LICENSE("GPL");
-module_init(maxinefb_init);
 #endif
+module_init(maxinefb_init);
 module_exit(maxinefb_exit);
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/neofb.c linux-2.6.9-rc1-mm3/drivers/video/neofb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/neofb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/neofb.c	2004-09-04 09:17:19.119803760 +0800
@@ -2267,16 +2267,19 @@ int __init neofb_setup(char *options)
 
 int __init neofb_init(void)
 {
+#ifndef MODULE
+	neofb_setup(fb_get_options("neofb"));
+#endif
 	return pci_register_driver(&neofb_driver);
 }
 
-#ifdef MODULE
+module_init(neofb_init);
 
+#ifdef MODULE
 static void __exit neofb_exit(void)
 {
 	pci_unregister_driver(&neofb_driver);
 }
 
-module_init(neofb_init);
 module_exit(neofb_exit);
 #endif				/* MODULE */
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/offb.c linux-2.6.9-rc1-mm3/drivers/video/offb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/offb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/offb.c	2004-09-04 09:17:19.122803304 +0800
@@ -541,4 +541,5 @@ static void __init offb_init_fb(const ch
 	       info->node, full_name);
 }
 
+module_init(offb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/p9100.c linux-2.6.9-rc1-mm3/drivers/video/p9100.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/p9100.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/p9100.c	2004-09-04 09:17:19.124803000 +0800
@@ -368,8 +368,9 @@ p9100_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(p9100_init);
+
+#ifdef MODULE
 module_exit(p9100_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/platinumfb.c linux-2.6.9-rc1-mm3/drivers/video/platinumfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/platinumfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/platinumfb.c	2004-09-04 09:17:19.127802544 +0800
@@ -667,6 +667,9 @@ static struct of_platform_driver platinu
 
 int __init platinumfb_init(void)
 {
+#ifndef MODULE
+	platinumfb_setup(fb_get_options("platinumfb"));
+#endif
 	of_register_driver(&platinum_driver);
 
 	return 0;
@@ -679,8 +682,8 @@ void __exit platinumfb_exit(void)
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("framebuffer driver for Apple Platinum video");
+module_init(platinumfb_init);
 
 #ifdef MODULE
-module_init(platinumfb_init);
 module_exit(platinumfb_exit);
 #endif
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/pm2fb.c linux-2.6.9-rc1-mm3/drivers/video/pm2fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/pm2fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/pm2fb.c	2004-09-04 09:17:19.130802088 +0800
@@ -1215,8 +1215,14 @@ MODULE_DEVICE_TABLE(pci, pm2fb_id_table)
  *  Initialization
  */
 
+int __init pm2fb_setup(char *options);
+
 int __init pm2fb_init(void)
 {
+#ifndef MODULE
+	pm2fb_setup(fb_get_options("pm2fb"));
+#endif
+
 	return pci_module_init(&pm2fb_driver);
 }
 
@@ -1266,9 +1272,7 @@ int __init pm2fb_setup(char *options)
 
 
 
-#ifdef MODULE
 module_init(pm2fb_init);
-#endif 
 module_exit(pm2fb_exit);
 
 MODULE_PARM(mode,"s");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/pmag-ba-fb.c linux-2.6.9-rc1-mm3/drivers/video/pmag-ba-fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/pmag-ba-fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/pmag-ba-fb.c	2004-09-04 09:17:19.132801784 +0800
@@ -172,4 +172,5 @@ int __init pmagbafb_init(void)
 	}
 }
 
+module_init(pmagbafb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/pmagb-b-fb.c linux-2.6.9-rc1-mm3/drivers/video/pmagb-b-fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/pmagb-b-fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/pmagb-b-fb.c	2004-09-04 09:17:19.135801328 +0800
@@ -175,4 +175,5 @@ int __init pmagbbfb_init(void)
 	}
 }
 
+module_init(pmagbbfb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/pvr2fb.c linux-2.6.9-rc1-mm3/drivers/video/pvr2fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/pvr2fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/pvr2fb.c	2004-09-04 09:17:19.137801024 +0800
@@ -1057,6 +1057,9 @@ int __init pvr2fb_init(void)
 	int i, ret = -ENODEV;
 	int size;
 
+#ifndef MODULE
+	pvr2fb_setup(fb_get_options("pvr2fb"));
+#endif
 	size = sizeof(struct fb_info) + sizeof(struct pvr2fb_par) + 16 * sizeof(u32);
 
 	fb_info = kmalloc(size, GFP_KERNEL);
@@ -1108,9 +1111,7 @@ static void __exit pvr2fb_exit(void)
 	kfree(fb_info);
 }
 
-#ifdef MODULE
 module_init(pvr2fb_init);
-#endif
 module_exit(pvr2fb_exit);
 
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>, M. R. Brown <mrbrown@0xd6.org>");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/pxafb.c linux-2.6.9-rc1-mm3/drivers/video/pxafb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/pxafb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/pxafb.c	2004-09-04 09:17:19.140800568 +0800
@@ -1359,11 +1359,6 @@ static struct device_driver pxafb_driver
 #endif
 };
 
-int __devinit pxafb_init(void)
-{
-	return driver_register(&pxafb_driver);
-}
-
 #ifndef MODULE
 int __devinit pxafb_setup(char *options)
 {
@@ -1373,12 +1368,21 @@ int __devinit pxafb_setup(char *options)
 	return 0;
 }
 #else
-module_init(pxafb_init);
 # ifdef CONFIG_FB_PXA_PARAMETERS
 module_param_string(options, g_options, sizeof(g_options), 0);
 MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
 # endif
 #endif
 
+int __devinit pxafb_init(void)
+{
+#ifndef MODULE
+	pxafb_setup(fb_get_options("pxafb"));
+#endif
+	return driver_register(&pxafb_driver);
+}
+
+module_init(pxafb_init);
+
 MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/q40fb.c linux-2.6.9-rc1-mm3/drivers/video/q40fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/q40fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/q40fb.c	2004-09-04 09:17:19.143800112 +0800
@@ -153,4 +153,5 @@ int __init q40fb_init(void)
 	return ret;
 }
 
+module_init(q40fb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/radeonfb.c linux-2.6.9-rc1-mm3/drivers/video/radeonfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/radeonfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/radeonfb.c	2004-09-04 09:17:19.147799504 +0800
@@ -3132,9 +3132,13 @@ static struct pci_driver radeonfb_driver
 	.remove		= __devexit_p(radeonfb_pci_unregister),
 };
 
+int __init radeonfb_old_setup (char *options);
 
 int __init radeonfb_old_init (void)
 {
+#ifndef MODULE
+	radeonfb_old_setup(fb_get_options("radeonfb_old"));
+#endif
 	return pci_module_init (&radeonfb_driver);
 }
 
@@ -3172,8 +3176,9 @@ int __init radeonfb_old_setup (char *opt
 	return 0;
 }
 
-#ifdef MODULE
 module_init(radeonfb_old_init);
+
+#ifdef MODULE
 module_exit(radeonfb_old_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/riva/fbdev.c linux-2.6.9-rc1-mm3/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/riva/fbdev.c	2004-09-04 08:23:11.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/riva/fbdev.c	2004-09-04 09:17:19.152798744 +0800
@@ -2138,6 +2138,9 @@ static struct pci_driver rivafb_driver =
 
 int __devinit rivafb_init(void)
 {
+#ifndef MODULE
+	rivafb_setup(fb_get_options("rivafb"));
+#endif
 	if (pci_register_driver(&rivafb_driver) > 0)
 		return 0;
 	pci_unregister_driver(&rivafb_driver);
@@ -2145,13 +2148,14 @@ int __devinit rivafb_init(void)
 }
 
 
+module_init(rivafb_init);
+
 #ifdef MODULE
 static void __exit rivafb_exit(void)
 {
 	pci_unregister_driver(&rivafb_driver);
 }
 
-module_init(rivafb_init);
 module_exit(rivafb_exit);
 
 MODULE_PARM(flatpanel, "i");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/sa1100fb.c linux-2.6.9-rc1-mm3/drivers/video/sa1100fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/sa1100fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/sa1100fb.c	2004-09-04 09:17:19.155798288 +0800
@@ -1848,5 +1848,6 @@ int __init sa1100fb_setup(char *options)
 	return 0;
 }
 
+module_init(sa1100fb_init);
 MODULE_DESCRIPTION("StrongARM-1100/1110 framebuffer driver");
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/sgivwfb.c linux-2.6.9-rc1-mm3/drivers/video/sgivwfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/sgivwfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/sgivwfb.c	2004-09-04 09:17:19.158797832 +0800
@@ -869,6 +869,9 @@ int __init sgivwfb_init(void)
 {
 	int ret;
 
+#ifndef MODULE
+	sgivwfb_setup(fb_get_options("sgivwfb"));
+#endif
 	ret = driver_register(&sgivwfb_driver);
 	if (!ret) {
 		ret = platform_device_register(&sgivwfb_device);
@@ -878,6 +881,8 @@ int __init sgivwfb_init(void)
 	return ret;
 }
 
+module_init(sgivwfb_init);
+
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
@@ -887,7 +892,6 @@ static void __exit sgivwfb_exit(void)
 	driver_unregister(&sgivwfb_driver);
 }
 
-module_init(sgivwfb_init);
 module_exit(sgivwfb_exit);
 
 #endif				/* MODULE */
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/sis/sis_main.c linux-2.6.9-rc1-mm3/drivers/video/sis/sis_main.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/sis/sis_main.c	2004-08-17 21:51:40.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/sis/sis_main.c	2004-09-04 09:17:19.165796768 +0800
@@ -5718,9 +5718,20 @@ static struct pci_driver sisfb_driver = 
 
 int __init sisfb_init(void)
 {
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+#ifndef MODULE
+	sisfb_setup(fb_get_options("sisfb"));
+#endif
+#endif
 	return(pci_module_init(&sisfb_driver));
 }
 
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
+#ifndef MODULE
+module_init(sisfb_init);
+#endif
+#endif
+
 /*****************************************************/
 /*                      MODULE                       */
 /*****************************************************/
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/skeletonfb.c linux-2.6.9-rc1-mm3/drivers/video/skeletonfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/skeletonfb.c	2004-08-17 21:51:40.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/skeletonfb.c	2004-09-04 09:17:19.169796160 +0800
@@ -583,6 +583,13 @@ int __init xxxfb_init(void)
 static void __exit xxxfb_cleanup(void)
 {
     /*
+     *  For kernel boot options (in 'video=xxxfb:<options>' format)
+     */
+#ifndef MODULE
+    xxxfb_setup(fb_get_options("xxxfb"));
+#endif
+
+    /*
      *  If your driver supports multiple boards, you should unregister and
      *  clean up all instances.
      */
@@ -639,9 +646,7 @@ static struct fb_ops xxxfb_ops = {
      *  Modularization
      */
 
-#ifdef MODULE
 module_init(xxxfb_init);
-#endif 
 module_exit(xxxfb_cleanup);
 
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/sstfb.c linux-2.6.9-rc1-mm3/drivers/video/sstfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/sstfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/sstfb.c	2004-09-04 09:17:19.172795704 +0800
@@ -1571,6 +1571,9 @@ static struct pci_driver sstfb_driver = 
 
 int __devinit sstfb_init(void)
 {
+#ifndef MODULE
+	sstfb_setup(fb_get_options("sstfb"));
+#endif
 	return pci_module_init(&sstfb_driver);
 }
 
@@ -1693,9 +1696,9 @@ static void sstfb_drawdebugimage(struct 
 	sstfb_drawrect_XY(info, 250, 250, 120, 100, 0xf800, idx);
 }
 
+module_init(sstfb_init);
 
 #ifdef MODULE
-module_init(sstfb_init);
 module_exit(sstfb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/stifb.c linux-2.6.9-rc1-mm3/drivers/video/stifb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/stifb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/stifb.c	2004-09-04 09:17:19.175795248 +0800
@@ -1377,11 +1377,17 @@ out_err0:
 static int stifb_disabled __initdata;
 
 int __init
+stifb_setup(char *options);
+
+int __init
 stifb_init(void)
 {
 	struct sti_struct *sti;
 	int i;
 	
+#ifndef MODULE
+	stifb_setup(fb_get_options("stifb"));
+#endif
 	if (stifb_disabled) {
 		printk(KERN_INFO "stifb: disabled by \"stifb=off\" kernel parameter\n");
 		return -ENXIO;
@@ -1452,9 +1458,7 @@ stifb_setup(char *options)
 
 __setup("stifb=", stifb_setup);
 
-#ifdef MODULE
 module_init(stifb_init);
-#endif
 module_exit(stifb_cleanup);
 
 MODULE_AUTHOR("Helge Deller <deller@gmx.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/tcx.c linux-2.6.9-rc1-mm3/drivers/video/tcx.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/tcx.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/tcx.c	2004-09-04 09:17:19.178794792 +0800
@@ -496,8 +496,9 @@ tcx_setup(char *arg)
 	return 0;
 }
 
-#ifdef MODULE
 module_init(tcx_init);
+
+#ifdef MODULE
 module_exit(tcx_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm3/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/tdfxfb.c	2004-09-04 08:26:19.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/tdfxfb.c	2004-09-04 09:17:19.181794336 +0800
@@ -155,7 +155,7 @@ MODULE_DEVICE_TABLE(pci, tdfxfb_id_table
  *  Frame buffer device API
  */
 int tdfxfb_init(void);
-void tdfxfb_setup(char *options, int *ints); 
+void tdfxfb_setup(char *options);
 
 static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *fb); 
 static int tdfxfb_set_par(struct fb_info *info); 
@@ -1362,6 +1362,9 @@ static void __devexit tdfxfb_remove(stru
 
 int __init tdfxfb_init(void)
 {
+#ifndef MODULE
+	tdfxfb_setup(fb_get_options("tdfxfb"));
+#endif
         return pci_module_init(&tdfxfb_driver);
 }
 
@@ -1374,14 +1377,12 @@ MODULE_AUTHOR("Hannu Mallat <hmallat@cc.
 MODULE_DESCRIPTION("3Dfx framebuffer device driver");
 MODULE_LICENSE("GPL");
  
-#ifdef MODULE
 module_init(tdfxfb_init);
-#endif
 module_exit(tdfxfb_exit);
 
 
 #ifndef MODULE
-void tdfxfb_setup(char *options, int *ints)
+void tdfxfb_setup(char *options)
 { 
 	char* this_opt;
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/tgafb.c linux-2.6.9-rc1-mm3/drivers/video/tgafb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/tgafb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/tgafb.c	2004-09-04 09:17:19.184793880 +0800
@@ -1477,12 +1477,6 @@ tgafb_pci_register(struct pci_dev *pdev,
 	return ret;
 }
 
-int __init
-tgafb_init(void)
-{
-	return pci_module_init(&tgafb_driver);
-}
-
 #ifdef MODULE
 static void __exit
 tgafb_pci_unregister(struct pci_dev *pdev)
@@ -1529,12 +1523,22 @@ tgafb_setup(char *arg)
 }
 #endif /* !MODULE */
 
+int __init
+tgafb_init(void)
+{
+#ifndef MODULE
+	tgafb_setup(fb_get_options("tgafb"));
+#endif
+	return pci_module_init(&tgafb_driver);
+}
+
 /*
  *  Modularisation
  */
 
-#ifdef MODULE
 module_init(tgafb_init);
+
+#ifdef MODULE
 module_exit(tgafb_exit);
 #endif
 
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/tridentfb.c linux-2.6.9-rc1-mm3/drivers/video/tridentfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/tridentfb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/tridentfb.c	2004-09-04 09:17:19.188793272 +0800
@@ -1218,8 +1218,13 @@ static struct pci_driver tridentfb_pci_d
 	.remove		= __devexit_p(trident_pci_remove)
 };
 
+int tridentfb_setup(char *options);
+
 int __init tridentfb_init(void)
 {
+#ifndef MODULE
+	tridentfb_setup(fb_get_options("tridentfb"));
+#endif
 	output("Trident framebuffer %s initializing\n", VERSION);
 	return pci_module_init(&tridentfb_pci_driver);
 }
@@ -1279,9 +1284,7 @@ static struct fb_ops tridentfb_ops = {
 	.fb_cursor = soft_cursor,
 };
 
-#ifdef MODULE
 module_init(tridentfb_init);
-#endif
 module_exit(tridentfb_exit);
 
 MODULE_AUTHOR("Jani Monoses <jani@iv.ro>");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/tx3912fb.c linux-2.6.9-rc1-mm3/drivers/video/tx3912fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/tx3912fb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/tx3912fb.c	2004-09-04 09:17:19.190792968 +0800
@@ -208,6 +208,8 @@ static int tx3912fb_setcolreg(u_int regn
 	return 0;
 }
 
+int __init tx3912fb_setup(char *options);
+
 /*
  * Initialization of the framebuffer
  */
@@ -216,6 +218,8 @@ int __init tx3912fb_init(void)
 	u_long tx3912fb_paddr = 0;
 	int size = (info->var.bits_per_pixel == 8) ? 256 : 16;
 
+	tx3912fb_setup(fb_get_options("tx3912fb"));
+
 	/* Disable the video logic */
 	outl(inl(TX3912_VIDEO_CTRL1) &
 	     ~(TX3912_VIDEO_CTRL1_ENVID | TX3912_VIDEO_CTRL1_DISPON),
@@ -329,4 +333,5 @@ int __init tx3912fb_setup(char *options)
 	return 0;
 }
 
+module_init(tx3912fb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/valkyriefb.c linux-2.6.9-rc1-mm3/drivers/video/valkyriefb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/valkyriefb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/valkyriefb.c	2004-09-04 09:17:19.193792512 +0800
@@ -323,6 +323,8 @@ int __init valkyriefb_init(void)
 	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
 	int err;
 
+	valkyriefb_setup(fb_get_options("valkyriefb"));
+
 #ifdef CONFIG_MAC
 	if (!MACH_IS_MAC)
 		return 0;
@@ -579,4 +581,5 @@ int __init valkyriefb_setup(char *option
 	return 0;
 }
 
+module_init(valkyriefb_init);
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/vesafb.c linux-2.6.9-rc1-mm3/drivers/video/vesafb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/vesafb.c	2004-08-26 23:04:25.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/vesafb.c	2004-09-04 09:17:19.195792208 +0800
@@ -411,6 +411,7 @@ int __init vesafb_init(void)
 {
 	int ret;
 
+	vesafb_setup(fb_get_options("vesafb"));
 	ret = driver_register(&vesafb_driver);
 
 	if (!ret) {
@@ -420,6 +421,7 @@ int __init vesafb_init(void)
 	}
 	return ret;
 }
+module_init(vesafb_init);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/vfb.c linux-2.6.9-rc1-mm3/drivers/video/vfb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/vfb.c	2004-08-17 21:50:50.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/vfb.c	2004-09-04 09:17:19.197791904 +0800
@@ -496,6 +496,10 @@ int __init vfb_init(void)
 {
 	int ret = 0;
 
+#ifndef MODULE
+	vfb_setup(fb_get_options("vfb"));
+#endif
+
 	if (!vfb_enable)
 		return -ENXIO;
 
@@ -509,6 +513,8 @@ int __init vfb_init(void)
 	return ret;
 }
 
+module_init(vfb_init);
+
 #ifdef MODULE
 static void __exit vfb_exit(void)
 {
@@ -516,7 +522,6 @@ static void __exit vfb_exit(void)
 	driver_unregister(&vfb_driver);
 }
 
-module_init(vfb_init);
 module_exit(vfb_exit);
 
 MODULE_LICENSE("GPL");
diff -uprN linux-2.6.9-rc1-mm3-orig/drivers/video/vga16fb.c linux-2.6.9-rc1-mm3/drivers/video/vga16fb.c
--- linux-2.6.9-rc1-mm3-orig/drivers/video/vga16fb.c	2004-08-17 21:51:40.000000000 +0800
+++ linux-2.6.9-rc1-mm3/drivers/video/vga16fb.c	2004-09-04 09:17:19.200791448 +0800
@@ -1343,6 +1343,9 @@ int __init vga16fb_init(void)
 	int i;
 	int ret;
 
+#ifndef MODULE
+	vga16fb_setup(fb_get_options("vga16fb"));
+#endif
 	printk(KERN_DEBUG "vga16fb: initializing\n");
 
 	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
@@ -1418,8 +1421,8 @@ static void __exit vga16fb_exit(void)
 
 #ifdef MODULE
 MODULE_LICENSE("GPL");
-module_init(vga16fb_init);
 #endif
+module_init(vga16fb_init);
 module_exit(vga16fb_exit);
 
 



