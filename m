Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUIJVJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUIJVJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUIJVJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:09:23 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:37061 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267881AbUIJVFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:05:19 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 05:04:09 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston>
In-Reply-To: <1094783022.2667.106.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409110504.09812.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> Recent changes upstream are breaking fbdev on pmacs.
>
> I haven't had time to go deep into that (but I suspect Linus sees it
> too on his own g5 unless he removed offb from his .config).
>
> From what I see, it seems that offb is kicking in by default, reserves
> the mmio regions, and then whatever chip driver loads can't access them.
>
> offb is supposed to be a "fallback" driver in case no fbdev is taking
> over, it should also be "forced" in with video=ofonly kernel command
> line. This logic has been broken.
>

Hi Ben,

How about this patch?  This brings back the old way of setting up the
drivers, supports:

video=xxxfb:off
video=ofonly

Your patch that brings offb to the very last of the Makefile is needed.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/68328fb.c               |    6 +++-
 drivers/video/acornfb.c               |    6 +++-
 drivers/video/amba-clcd.c             |    2 +
 drivers/video/amifb.c                 |    6 +++-
 drivers/video/asiliantfb.c            |    3 ++
 drivers/video/aty/aty128fb.c          |   11 +++++++-
 drivers/video/aty/atyfb_base.c        |   19 ++++++++++----
 drivers/video/aty/radeon_base.c       |    6 +++-
 drivers/video/bw2.c                   |    3 ++
 drivers/video/cg14.c                  |    3 ++
 drivers/video/cg3.c                   |    3 ++
 drivers/video/cg6.c                   |    3 ++
 drivers/video/chipsfb.c               |    3 ++
 drivers/video/cirrusfb.c              |    6 +++-
 drivers/video/clps711xfb.c            |    3 ++
 drivers/video/controlfb.c             |    5 +++
 drivers/video/cyber2000fb.c           |    6 +++-
 drivers/video/dnfb.c                  |    3 ++
 drivers/video/epson1355fb.c           |    3 ++
 drivers/video/fbmem.c                 |   44 ++++++++++++++++++++--------------
 drivers/video/ffb.c                   |    3 ++
 drivers/video/fm2fb.c                 |    6 +++-
 drivers/video/g364fb.c                |    3 ++
 drivers/video/gbefb.c                 |    6 +++-
 drivers/video/hgafb.c                 |    3 ++
 drivers/video/hitfb.c                 |    3 ++
 drivers/video/hpfb.c                  |    3 ++
 drivers/video/i810/i810_main.c        |    6 +++-
 drivers/video/igafb.c                 |    3 ++
 drivers/video/imsttfb.c               |    7 ++++-
 drivers/video/kyro/fbdev.c            |    6 +++-
 drivers/video/leo.c                   |    3 ++
 drivers/video/macfb.c                 |    5 +++
 drivers/video/matrox/matroxfb_base.c  |    6 +++-
 drivers/video/matrox/matroxfb_crtc2.c |    3 ++
 drivers/video/maxinefb.c              |    3 ++
 drivers/video/neofb.c                 |    6 +++-
 drivers/video/offb.c                  |    5 +++
 drivers/video/p9100.c                 |    3 ++
 drivers/video/platinumfb.c            |    6 +++-
 drivers/video/pm2fb.c                 |    6 +++-
 drivers/video/pmag-ba-fb.c            |    3 ++
 drivers/video/pmagb-b-fb.c            |    3 ++
 drivers/video/pvr2fb.c                |    6 +++-
 drivers/video/pxafb.c                 |    6 +++-
 drivers/video/q40fb.c                 |    3 ++
 drivers/video/radeonfb.c              |    6 +++-
 drivers/video/riva/fbdev.c            |    6 +++-
 drivers/video/sa1100fb.c              |    3 ++
 drivers/video/sgivwfb.c               |    6 +++-
 drivers/video/sis/sis_main.c          |    6 +++-
 drivers/video/skeletonfb.c            |    6 +++-
 drivers/video/sstfb.c                 |    6 +++-
 drivers/video/stifb.c                 |    6 +++-
 drivers/video/tcx.c                   |    3 ++
 drivers/video/tdfxfb.c                |    7 ++++-
 drivers/video/tgafb.c                 |    6 +++-
 drivers/video/tridentfb.c             |    6 +++-
 drivers/video/tx3912fb.c              |    5 +++
 drivers/video/valkyriefb.c            |    5 +++
 drivers/video/vesafb.c                |    5 +++
 drivers/video/vfb.c                   |    6 +++-
 drivers/video/vga16fb.c               |    8 ++++--
 include/linux/fb.h                    |    2 -

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/68328fb.c linux-2.6.9-rc1-mm4/drivers/video/68328fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/68328fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/68328fb.c	2004-09-10 21:32:01.665230560 +0800
@@ -440,7 +440,11 @@ int __init mc68x328fb_setup(char *option
 int __init mc68x328fb_init(void)
 {
 #ifndef MODULE
-	mc68x328fb_setup(fb_get_options("68328fb"));
+	char *option = NULL;
+
+	if (fb_get_options("68328fb", &option))
+		return -ENODEV;
+	mc68x328fb_setup(option);
 #endif
 	/*
 	 *  initialize the default mode from the LCD controller registers
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/acornfb.c linux-2.6.9-rc1-mm4/drivers/video/acornfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/acornfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/acornfb.c	2004-09-10 21:32:01.671229648 +0800
@@ -1291,8 +1291,12 @@ acornfb_init(void)
 	unsigned long size;
 	u_int h_sync, v_sync;
 	int rc, i;
+	char *option = NULL;
+
+	if (fb_get_options("acornfb", &option))
+		return -ENODEV;
+	acornfb_setup(option);
 
-	acornfb_setup(fb_get_options("acornfb"));
 	acornfb_init_fbinfo();
 
 	current_par.dev = &acornfb_device;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/amba-clcd.c linux-2.6.9-rc1-mm4/drivers/video/amba-clcd.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/amba-clcd.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/amba-clcd.c	2004-09-10 21:32:01.676228888 +0800
@@ -496,6 +496,8 @@ static struct amba_driver clcd_driver = 
 
 int __init amba_clcdfb_init(void)
 {
+	if (fb_get_options("ambafb", NULL))
+		return -ENODEV;
 
 	return amba_driver_register(&clcd_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/amifb.c linux-2.6.9-rc1-mm4/drivers/video/amifb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/amifb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/amifb.c	2004-09-10 21:32:01.683227824 +0800
@@ -2258,7 +2258,11 @@ int __init amifb_init(void)
 	u_int defmode;
 
 #ifndef MODULE
-	amifb_setup(fb_get_options("amifb"));
+	char *option = NULL;
+
+	if (fb_get_options("amifb", &option))
+		return -ENODEV;
+	amifb_setup(option);
 #endif
 	if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(AMI_VIDEO))
 		return -ENXIO;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/asiliantfb.c linux-2.6.9-rc1-mm4/drivers/video/asiliantfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/asiliantfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/asiliantfb.c	2004-09-10 21:32:01.689226912 +0800
@@ -609,6 +609,9 @@ static struct pci_driver asiliantfb_driv
 
 int __init asiliantfb_init(void)
 {
+	if (fb_get_options("asiliantfb", NULL))
+		return -ENODEV;
+
 	return pci_module_init(&asiliantfb_driver);
 }
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/aty/aty128fb.c linux-2.6.9-rc1-mm4/drivers/video/aty/aty128fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/aty/aty128fb.c	2004-09-08 12:44:12.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/aty/aty128fb.c	2004-09-10 21:32:01.695226000 +0800
@@ -2439,6 +2439,14 @@ static int aty128_pci_resume(struct pci_
 
 int __init aty128fb_init(void)
 {
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("aty128fb", &option))
+		return -ENODEV;
+	aty128fb_setup(option);
+#endif
+
 	return pci_module_init(&aty128fb_driver);
 }
 
@@ -2447,8 +2455,9 @@ static void __exit aty128fb_exit(void)
 	pci_unregister_driver(&aty128fb_driver);
 }
 
-#ifdef MODULE
 module_init(aty128fb_init);
+
+#ifdef MODULE
 module_exit(aty128fb_exit);
 
 MODULE_AUTHOR("(c)1999-2003 Brad Douglas <brad@neruo.com>");
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/aty/atyfb_base.c linux-2.6.9-rc1-mm4/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/aty/atyfb_base.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/aty/atyfb_base.c	2004-09-10 21:32:01.702224936 +0800
@@ -1902,12 +1902,8 @@ static int __init aty_init(struct fb_inf
 	return 1;
 }
 
-int __init atyfb_init(void)
+static int __init atyfb_do_init(void)
 {
-#ifndef MODULE
-	atyfb_setup(fb_get_options("atyfb"));
-#endif
-
 #if defined(CONFIG_PCI)
 	unsigned long addr, res_start, res_size;
 	struct atyfb_par *default_par;
@@ -2381,6 +2377,19 @@ int __init atyfb_init(void)
 	return 0;
 }
 
+int __init atyfb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("atyfb", &option))
+		return -ENODEV;
+	atyfb_setup(option);
+#endif
+	return atyfb_do_init();
+}
+
+
 #ifndef MODULE
 int __init atyfb_setup(char *options)
 {
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/aty/radeon_base.c linux-2.6.9-rc1-mm4/drivers/video/aty/radeon_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/aty/radeon_base.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/aty/radeon_base.c	2004-09-10 21:32:01.708224024 +0800
@@ -2443,7 +2443,11 @@ int __init radeonfb_setup (char *options
 int __init radeonfb_init (void)
 {
 #ifndef MODULE
-	radeonfb_setup(fb_get_options("radeonfb"));
+	char *option = NULL;
+
+	if (fb_get_options("radeonfb", &option))
+		return -ENODEV;
+	radeonfb_setup(option);
 #endif
 	return pci_module_init (&radeonfb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/bw2.c linux-2.6.9-rc1-mm4/drivers/video/bw2.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/bw2.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/bw2.c	2004-09-10 21:32:01.714223112 +0800
@@ -386,6 +386,9 @@ int __init bw2_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("bw2fb", &option))
+		return -ENODEV;
+
 #ifdef CONFIG_SUN4
 	bw2_init_one(NULL);
 #endif
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cg14.c linux-2.6.9-rc1-mm4/drivers/video/cg14.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cg14.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cg14.c	2004-09-10 21:32:01.719222352 +0800
@@ -584,6 +584,9 @@ int __init cg14_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("cg14fb", NULL))
+		return -ENODEV;
+
 #ifdef CONFIG_SPARC32
 	{
 		int root, node;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cg3.c linux-2.6.9-rc1-mm4/drivers/video/cg3.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cg3.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cg3.c	2004-09-10 21:32:01.724221592 +0800
@@ -444,6 +444,9 @@ int __init cg3_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("cg3fb", NULL))
+		return -ENODEV;
+
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "cgthree") ||
 		    !strcmp(sdev->prom_name, "cgRDI"))
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cg6.c linux-2.6.9-rc1-mm4/drivers/video/cg6.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cg6.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cg6.c	2004-09-10 21:32:01.729220832 +0800
@@ -760,6 +760,9 @@ int __init cg6_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("cg6fb", NULL))
+		return -ENODEV;
+
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "cgsix") ||
 		    !strcmp(sdev->prom_name, "cgthree+"))
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/chipsfb.c linux-2.6.9-rc1-mm4/drivers/video/chipsfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/chipsfb.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/chipsfb.c	2004-09-10 21:32:01.734220072 +0800
@@ -462,6 +462,9 @@ static struct pci_driver chipsfb_driver 
 
 int __init chips_init(void)
 {
+	if (fb_get_options("chipsfb", NULL))
+		return -ENODEV;
+
 	return pci_module_init(&chipsfb_driver);
 }
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cirrusfb.c linux-2.6.9-rc1-mm4/drivers/video/cirrusfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cirrusfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cirrusfb.c	2004-09-10 21:32:01.741219008 +0800
@@ -2607,7 +2607,11 @@ int __init cirrusfb_init(void)
 	int error = 0;
 
 #ifndef MODULE
-	cirrusfb_setup(fb_get_options("cirrusfb"));
+	char *option = NULL;
+
+	if (fb_get_options("cirrusfb", &option))
+		return -ENODEV;
+	cirrusfb_setup(option);
 #endif
 
 #ifdef CONFIG_ZORRO
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/clps711xfb.c linux-2.6.9-rc1-mm4/drivers/video/clps711xfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/clps711xfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/clps711xfb.c	2004-09-10 21:32:01.747218096 +0800
@@ -364,6 +364,9 @@ int __init clps711xfb_init(void)
 {
 	int err = -ENOMEM;
 
+	if (fb_get_options("clps711xfb", NULL))
+		return -ENODEV;
+
 	cfb = kmalloc(sizeof(*cfb), GFP_KERNEL);
 	if (!cfb)
 		goto out;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/controlfb.c linux-2.6.9-rc1-mm4/drivers/video/controlfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/controlfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/controlfb.c	2004-09-10 21:32:01.752217336 +0800
@@ -556,8 +556,11 @@ static void control_set_hardware(struct 
 int __init control_init(void)
 {
 	struct device_node *dp;
+	char *option = NULL;
 
-	control_setup(fb_get_options("controlfb"));
+	if (fb_get_options("controlfb", &option))
+		return -ENODEV;
+	control_setup(option);
 
 	dp = find_devices("control");
 	if (dp != 0 && !control_of_init(dp))
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cyber2000fb.c linux-2.6.9-rc1-mm4/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cyber2000fb.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cyber2000fb.c	2004-09-10 21:32:01.758216424 +0800
@@ -1722,7 +1722,11 @@ int __init cyber2000fb_init(void)
 	int ret = -1, err;
 
 #ifndef MODULE
-	cyber2000fb_setup(fb_get_options("cyber200fb"));
+	char *option = NULL;
+
+	if (fb_get_options("cyber2000fb", NULL))
+		return -ENODEV;
+	cyber2000fb_setup(option);
 #endif
 
 #ifdef CONFIG_ARCH_SHARK
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/dnfb.c linux-2.6.9-rc1-mm4/drivers/video/dnfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/dnfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/dnfb.c	2004-09-10 21:32:01.763215664 +0800
@@ -284,6 +284,9 @@ int __init dnfb_init(void)
 {
 	int ret;
 
+	if (fb_get_options("dnfb", NULL))
+		return -ENODEV;
+
 	ret = driver_register(&dnfb_driver);
 
 	if (!ret) {
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/epson1355fb.c linux-2.6.9-rc1-mm4/drivers/video/epson1355fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/epson1355fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/epson1355fb.c	2004-09-10 21:32:01.768214904 +0800
@@ -740,6 +740,9 @@ int __init epson1355fb_init(void)
 {
 	int ret = 0;
 
+	if (fb_get_options("epson1355fb", NULL))
+		return -ENODEV;
+
 	ret = driver_register(&epson1355fb_driver);
 	if (!ret) {
 		ret = platform_device_register(&epson1355fb_device);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm4/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-10 05:29:28.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-10 21:32:01.774213992 +0800
@@ -1288,6 +1288,7 @@ module_init(fbmem_init);
 
 #define NR_FB_DRIVERS 64
 static char *video_options[NR_FB_DRIVERS];
+static int ofonly;
 
 /**
  * fb_get_options - get kernel boot parameters
@@ -1297,30 +1298,35 @@ static char *video_options[NR_FB_DRIVERS
  *
  * NOTE: Needed to maintain backwards compatibility
  */
-char* fb_get_options(char *name)
+int fb_get_options(char *name, char **option)
 {
-	char *option = NULL;
-	char *opt;
-	int opt_len;
+	char *opt, *options = NULL;
+	int opt_len, retval = 0;
 	int name_len = strlen(name), i;
 
-	if (!name_len)
-		return option;
+	if (name_len && ofonly && strncmp(name, "offb", 4))
+		retval = 1;
 
-	for (i = 0; i < NR_FB_DRIVERS; i++) {
-		if (video_options[i] == NULL)
-			continue;
-		opt_len = strlen(video_options[i]);
-		if (!opt_len)
-			continue;
-		opt = video_options[i];
-		if (!strncmp(name, opt, name_len) &&
-		    opt[name_len] == ':') {
-			option = opt + name_len + 1;
-			break;
+	if (name_len && !retval) {
+		for (i = 0; i < NR_FB_DRIVERS; i++) {
+			if (video_options[i] == NULL)
+				continue;
+			opt_len = strlen(video_options[i]);
+			if (!opt_len)
+				continue;
+			opt = video_options[i];
+			if (!strncmp(name, opt, name_len) &&
+			    opt[name_len] == ':')
+				options = opt + name_len + 1;
 		}
 	}
-	return option;
+	if (options && !strncmp(options, "off", 3))
+		retval = 1;
+
+	if (option)
+		*option = options;
+
+	return retval;
 }
 
 /**
@@ -1345,6 +1351,8 @@ int __init video_setup(char *options)
 		return 0;
 
 	for (i = 0; i < NR_FB_DRIVERS; i++) {
+		if (!strncmp(options, "ofonly", 6))
+			ofonly = 1;
 		if (video_options[i] == NULL) {
 			video_options[i] = options;
 			break;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/ffb.c linux-2.6.9-rc1-mm4/drivers/video/ffb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/ffb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/ffb.c	2004-09-10 21:32:01.779213232 +0800
@@ -1049,6 +1049,9 @@ int __init ffb_init(void)
 {
 	int root;
 
+	if (fb_get_options("ffb", NULL))
+		return -ENODEV;
+
 	ffb_scan_siblings(prom_root_node);
 
 	root = prom_getchild(prom_root_node);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fm2fb.c linux-2.6.9-rc1-mm4/drivers/video/fm2fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fm2fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fm2fb.c	2004-09-10 21:32:01.784212472 +0800
@@ -296,7 +296,11 @@ int __init fm2fb_setup(char *options);
 
 int __init fm2fb_init(void)
 {
-	fm2fb_setup(fb_get_options("fb2fb"));
+	char *option = NULL;
+
+	if (fb_get_options("fm2fb", &option))
+		return -ENODEV;
+	fm2fb_setup(option);
 	return zorro_register_driver(&fm2fb_driver);
 }
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/g364fb.c linux-2.6.9-rc1-mm4/drivers/video/g364fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/g364fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/g364fb.c	2004-09-10 21:32:01.788211864 +0800
@@ -202,6 +202,9 @@ int __init g364fb_init(void)
 	    (volatile unsigned int *) CURS_PAL_REG;
 	int mem, i, j;
 
+	if (fb_get_options("g364fb", NULL))
+		return -ENODEV;
+
 	/* TBD: G364 detection */
 
 	/* get the resolution set by ARC console */
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/gbefb.c linux-2.6.9-rc1-mm4/drivers/video/gbefb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/gbefb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/gbefb.c	2004-09-10 21:32:01.792211256 +0800
@@ -1084,7 +1084,11 @@ int __init gbefb_init(void)
 	int i, ret = 0;
 
 #ifndef MODULE
-	gbefb_setup(fb_get_options("gbefb"));
+	char *option = NULL;
+
+	if (fb_get_options("gbefb", &option))
+		return -ENODEV;
+	gbefb_setup(options);
 #endif
 
 	if (!request_mem_region(GBE_BASE, sizeof(struct sgi_gbe), "GBE")) {
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/hgafb.c linux-2.6.9-rc1-mm4/drivers/video/hgafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/hgafb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/hgafb.c	2004-09-10 21:32:01.797210496 +0800
@@ -547,6 +547,9 @@ static struct fb_ops hgafb_ops = {
 
 int __init hgafb_init(void)
 {
+	if (fb_get_options("hgafb", NULL))
+		return -ENODEV;
+
 	if (! hga_card_detect()) {
 		printk(KERN_INFO "hgafb: HGA card not detected.\n");
 		return -EINVAL;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/hitfb.c linux-2.6.9-rc1-mm4/drivers/video/hitfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/hitfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/hitfb.c	2004-09-10 21:32:01.801209888 +0800
@@ -270,6 +270,9 @@ int __init hitfb_init(void)
 	unsigned short lcdclor, ldr3, ldvndr;
 	int size;
 
+	if (fb_get_options("hitfb", NULL))
+		return -ENODEV;
+
 	hitfb_fix.smem_start = CONFIG_HD64461_IOBASE + 0x02000000;
 	hitfb_fix.smem_len = (MACH_HP690) ? 1024 * 1024 : 512 * 1024;
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/hpfb.c linux-2.6.9-rc1-mm4/drivers/video/hpfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/hpfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/hpfb.c	2004-09-10 21:32:01.804209432 +0800
@@ -115,6 +115,9 @@ int __init hpfb_init_one(unsigned long b
 {
 	unsigned long fboff;
 
+	if (fb_get_options("hpfb", NULL))
+		return -ENODEV;
+
 	fboff = (in_8(base + TOPCAT_FBOMSB) << 8) | in_8(base + TOPCAT_FBOLSB);
 
 	hpfb_fix.smem_start = 0xf0000000 | (in_8(base + fboff) << 16);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c	2004-09-10 21:32:01.808208824 +0800
@@ -1980,7 +1980,11 @@ static void __exit i810fb_remove_pci(str
 #ifndef MODULE
 int __init i810fb_init(void)
 {
-	i810fb_setup(fb_get_options("i810fb"));
+	char *option = NULL;
+
+	if (fb_get_options("i810fb", &option))
+		return -ENODEV;
+	i810fb_setup(option);
 
 	if (pci_register_driver(&i810fb_driver) > 0)
 		return 0;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/igafb.c linux-2.6.9-rc1-mm4/drivers/video/igafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/igafb.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/igafb.c	2004-09-10 21:32:01.812208216 +0800
@@ -381,6 +381,9 @@ int __init igafb_init(void)
 	unsigned long addr;
 	int size, iga2000 = 0;
 
+	if (fb_get_options("igafb", NULL))
+		return -ENODEV;
+
         /* Do not attach when we have a serial console. */
         if (!con_is_present())
                 return -ENXIO;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/imsttfb.c linux-2.6.9-rc1-mm4/drivers/video/imsttfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/imsttfb.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/imsttfb.c	2004-09-10 21:32:01.816207608 +0800
@@ -1604,7 +1604,12 @@ imsttfb_setup(char *options)
 int __init imsttfb_init(void)
 {
 #ifndef MODULE
-	imsttfb_setup(fb_get_options("imsttfb"));
+	char *option = NULL;
+
+	if (fb_get_options("imsttfb", &option))
+		return -ENODEV;
+
+	imsttfb_setup(option);
 #endif
 	return pci_module_init(&imsttfb_pci_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/kyro/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/kyro/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/kyro/fbdev.c	2004-09-10 05:29:20.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/kyro/fbdev.c	2004-09-10 21:32:01.820207000 +0800
@@ -789,7 +789,11 @@ static void __devexit kyrofb_remove(stru
 int __init kyrofb_init(void)
 {
 #ifndef MODULE
-	kyrofb_setup(fb_get_options("kyrofb"));
+	char *option = NULL;
+
+	if (fb_get_options("kyrofb", &option))
+		return -ENODEV;
+	kyrofb_setup(option);
 #endif
 	return pci_module_init(&kyrofb_pci_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/leo.c linux-2.6.9-rc1-mm4/drivers/video/leo.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/leo.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/leo.c	2004-09-10 21:32:01.823206544 +0800
@@ -626,6 +626,9 @@ int __init leo_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("leofb", NULL))
+		return -ENODEV;
+
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "leo"))
 			leo_init_one(sdev);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/macfb.c linux-2.6.9-rc1-mm4/drivers/video/macfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/macfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/macfb.c	2004-09-10 21:32:01.827205936 +0800
@@ -614,8 +614,11 @@ void __init macfb_init(void)
 {
 	int video_cmap_len, video_is_nubus = 0;
 	struct nubus_dev* ndev = NULL;
+	char *option = NULL;
 
-	macfb_setup(fb_get_options("macfb"));
+	if (fb_get_options("macfb", &option))
+		return -ENODEV;
+	macfb_setup(option);
 
 	if (!MACH_IS_MAC) 
 		return;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_base.c linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_base.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_base.c	2004-09-10 21:32:01.831205328 +0800
@@ -2416,9 +2416,13 @@ static int __initdata initialized = 0;
 
 int __init matroxfb_init(void)
 {
+	char *option = NULL;
+
 	DBG(__FUNCTION__)
 
-	matroxfb_setup(fb_get_options("matroxfb"));
+	if (fb_get_options("matroxfb", &option))
+		return -ENODEV;
+	matroxfb_setup(option);
 
 	if (disabled)
 		return -ENXIO;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_crtc2.c linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_crtc2.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_crtc2.c	2004-09-08 12:44:12.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_crtc2.c	2004-09-10 21:32:01.835204720 +0800
@@ -721,6 +721,9 @@ static struct matroxfb_driver crtc2 = {
 		.remove =	matroxfb_crtc2_remove };
 
 static int matroxfb_crtc2_init(void) {
+	if (fb_get_options("matrox_crtc2fb", NULL))
+		return -ENODEV;
+
 	matroxfb_register_driver(&crtc2);
 	return 0;
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/maxinefb.c linux-2.6.9-rc1-mm4/drivers/video/maxinefb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/maxinefb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/maxinefb.c	2004-09-10 21:32:01.838204264 +0800
@@ -126,6 +126,9 @@ int __init maxinefb_init(void)
 	unsigned long fb_start;
 	int i;
 
+	if (fb_get_options("maxinefb", NULL))
+		return -ENODEV;
+
 	/* Validate we're on the proper machine type */
 	if (mips_machtype != MACH_DS5000_XX) {
 		return -EINVAL;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/neofb.c linux-2.6.9-rc1-mm4/drivers/video/neofb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/neofb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/neofb.c	2004-09-10 21:32:01.842203656 +0800
@@ -2268,7 +2268,11 @@ int __init neofb_setup(char *options)
 int __init neofb_init(void)
 {
 #ifndef MODULE
-	neofb_setup(fb_get_options("neofb"));
+	char *option = NULL;
+
+	if (fb_get_options("neofb", &option))
+		return -ENODEV;
+	neofb_setup(option);
 #endif
 	return pci_register_driver(&neofb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/offb.c linux-2.6.9-rc1-mm4/drivers/video/offb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/offb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/offb.c	2004-09-10 21:32:01.846203048 +0800
@@ -247,10 +247,15 @@ int __init offb_init(void)
 {
 	struct device_node *dp;
 	unsigned int dpy;
+	char *option = NULL;
 #if defined(CONFIG_BOOTX_TEXT) && defined(CONFIG_PPC32)
 	struct device_node *displays = find_type_devices("display");
 	struct device_node *macos_display = NULL;
+#endif
+	if (fb_get_options("offb", NULL))
+		return -ENODEV;
 
+#if defined(CONFIG_BOOTX_TEXT) && defined(CONFIG_PPC32)
 	/* If we're booted from BootX... */
 	if (prom_num_displays == 0 && boot_infos != 0) {
 		unsigned long addr =
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/p9100.c linux-2.6.9-rc1-mm4/drivers/video/p9100.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/p9100.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/p9100.c	2004-09-10 21:32:01.849202592 +0800
@@ -340,6 +340,9 @@ int __init p9100_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("p9100fb", NULL))
+		return -ENODEV;
+
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "p9100"))
 			p9100_init_one(sdev);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/platinumfb.c linux-2.6.9-rc1-mm4/drivers/video/platinumfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/platinumfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/platinumfb.c	2004-09-10 21:32:01.852202136 +0800
@@ -668,7 +668,11 @@ static struct of_platform_driver platinu
 int __init platinumfb_init(void)
 {
 #ifndef MODULE
-	platinumfb_setup(fb_get_options("platinumfb"));
+	char *option = NULL;
+
+	if (fb_get_options("platinumfb", &option))
+		return -ENODEV;
+	platinumfb_setup(option);
 #endif
 	of_register_driver(&platinum_driver);
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pm2fb.c linux-2.6.9-rc1-mm4/drivers/video/pm2fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pm2fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pm2fb.c	2004-09-10 21:32:01.856201528 +0800
@@ -1220,7 +1220,11 @@ int __init pm2fb_setup(char *options);
 int __init pm2fb_init(void)
 {
 #ifndef MODULE
-	pm2fb_setup(fb_get_options("pm2fb"));
+	char *option = NULL;
+
+	if (fb_get_options("pm2fb", &option))
+		return -ENODEV;
+	pm2fb_setup(option);
 #endif
 
 	return pci_module_init(&pm2fb_driver);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pmag-ba-fb.c linux-2.6.9-rc1-mm4/drivers/video/pmag-ba-fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pmag-ba-fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pmag-ba-fb.c	2004-09-10 21:32:01.859201072 +0800
@@ -160,6 +160,9 @@ int __init pmagbafb_init(void)
 	int sid;
 	int found = 0;
 
+	if (fb_get_options("pmagbafb", NULL))
+		return -ENODEV;
+
 	if (TURBOCHANNEL) {
 		while ((sid = search_tc_card("PMAG-BA")) >= 0) {
 			found = 1;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pmagb-b-fb.c linux-2.6.9-rc1-mm4/drivers/video/pmagb-b-fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pmagb-b-fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pmagb-b-fb.c	2004-09-10 21:32:01.862200616 +0800
@@ -163,6 +163,9 @@ int __init pmagbbfb_init(void)
 	int sid;
 	int found = 0;
 
+	if (fb_get_options("pmagbbfb", NULL))
+		return -ENODEV;
+
 	if (TURBOCHANNEL) {
 		while ((sid = search_tc_card("PMAGB-BA")) >= 0) {
 			found = 1;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pvr2fb.c linux-2.6.9-rc1-mm4/drivers/video/pvr2fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pvr2fb.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pvr2fb.c	2004-09-10 21:32:01.866200008 +0800
@@ -1059,7 +1059,11 @@ int __init pvr2fb_init(void)
 	int size;
 
 #ifndef MODULE
-	pvr2fb_setup(fb_get_options("pvr2fb"));
+	char *option = NULL;
+
+	if (fb_get_options("pvr2fb", &option))
+		return -ENODEV;
+	pvr2fb_setup(option);
 #endif
 	size = sizeof(struct fb_info) + sizeof(struct pvr2fb_par) + 16 * sizeof(u32);
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pxafb.c linux-2.6.9-rc1-mm4/drivers/video/pxafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pxafb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pxafb.c	2004-09-10 21:32:01.869199552 +0800
@@ -1377,7 +1377,11 @@ MODULE_PARM_DESC(options, "LCD parameter
 int __devinit pxafb_init(void)
 {
 #ifndef MODULE
-	pxafb_setup(fb_get_options("pxafb"));
+	char *option = NULL;
+
+	if (fb_get_options("pxafb", &option))
+		return -ENODEV;
+	pxafb_setup(option);
 #endif
 	return driver_register(&pxafb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/q40fb.c linux-2.6.9-rc1-mm4/drivers/video/q40fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/q40fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/q40fb.c	2004-09-10 21:32:01.873198944 +0800
@@ -143,6 +143,9 @@ int __init q40fb_init(void)
 {
 	int ret = 0;
 
+	if (fb_get_options("q40fb", NULL))
+		return -ENODEV;
+
 	ret = driver_register(&q40fb_driver);
 
 	if (!ret) {
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/radeonfb.c linux-2.6.9-rc1-mm4/drivers/video/radeonfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/radeonfb.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/radeonfb.c	2004-09-10 21:32:01.877198336 +0800
@@ -3137,7 +3137,11 @@ int __init radeonfb_old_setup (char *opt
 int __init radeonfb_old_init (void)
 {
 #ifndef MODULE
-	radeonfb_old_setup(fb_get_options("radeonfb_old"));
+	char *option = NULL;
+
+	if (fb_get_options("radeonfb_old", &option))
+		return -ENODEV;
+	radeonfb_old_setup(option);
 #endif
 	return pci_module_init (&radeonfb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c	2004-09-10 21:32:01.882197576 +0800
@@ -2133,7 +2133,11 @@ static struct pci_driver rivafb_driver =
 int __devinit rivafb_init(void)
 {
 #ifndef MODULE
-	rivafb_setup(fb_get_options("rivafb"));
+	char *option = NULL;
+
+	if (fb_get_options("rivafb", &option))
+		return -ENODEV;
+	rivafb_setup(option);
 #endif
 	if (pci_register_driver(&rivafb_driver) > 0)
 		return 0;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/sa1100fb.c linux-2.6.9-rc1-mm4/drivers/video/sa1100fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/sa1100fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/sa1100fb.c	2004-09-10 21:32:01.886196968 +0800
@@ -1804,6 +1804,9 @@ static struct device_driver sa1100fb_dri
 
 int __init sa1100fb_init(void)
 {
+	if (fb_get_options("sa1100fb", NULL))
+		return -ENODEV;
+
 	return driver_register(&sa1100fb_driver);
 }
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/sgivwfb.c linux-2.6.9-rc1-mm4/drivers/video/sgivwfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/sgivwfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/sgivwfb.c	2004-09-10 21:32:01.890196360 +0800
@@ -870,7 +870,11 @@ int __init sgivwfb_init(void)
 	int ret;
 
 #ifndef MODULE
-	sgivwfb_setup(fb_get_options("sgivwfb"));
+	char *option = NULL;
+
+	if (fb_get_options("sgivwfb", &option))
+		return -ENODEV;
+	sgivwfb_setup(option);
 #endif
 	ret = driver_register(&sgivwfb_driver);
 	if (!ret) {
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/sis/sis_main.c linux-2.6.9-rc1-mm4/drivers/video/sis/sis_main.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/sis/sis_main.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/sis/sis_main.c	2004-09-10 21:32:01.897195296 +0800
@@ -5720,7 +5720,11 @@ int __init sisfb_init(void)
 {
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
 #ifndef MODULE
-	sisfb_setup(fb_get_options("sisfb"));
+	char *option = NULL;
+
+	if (fb_get_options("sisfb", &option))
+		return -ENODEV;
+	sisfb_setup(option);
 #endif
 #endif
 	return(pci_module_init(&sisfb_driver));
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/skeletonfb.c linux-2.6.9-rc1-mm4/drivers/video/skeletonfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/skeletonfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/skeletonfb.c	2004-09-10 21:32:01.901194688 +0800
@@ -586,7 +586,11 @@ static void __exit xxxfb_cleanup(void)
      *  For kernel boot options (in 'video=xxxfb:<options>' format)
      */
 #ifndef MODULE
-    xxxfb_setup(fb_get_options("xxxfb"));
+    char *option = NULL;
+
+    if (fb_get_options("xxxfb", &option))
+	    return -ENODEV;
+    xxxfb_setup(option);
 #endif
 
     /*
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/sstfb.c linux-2.6.9-rc1-mm4/drivers/video/sstfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/sstfb.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/sstfb.c	2004-09-10 21:32:01.905194080 +0800
@@ -1573,7 +1573,11 @@ static struct pci_driver sstfb_driver = 
 int __devinit sstfb_init(void)
 {
 #ifndef MODULE
-	sstfb_setup(fb_get_options("sstfb"));
+	char *option = NULL;
+
+	if (fb_get_options("sstfb", &option))
+		return -ENODEV;
+	sstfb_setup(option);
 #endif
 	return pci_module_init(&sstfb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/stifb.c linux-2.6.9-rc1-mm4/drivers/video/stifb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/stifb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/stifb.c	2004-09-10 21:32:01.909193472 +0800
@@ -1386,7 +1386,11 @@ stifb_init(void)
 	int i;
 	
 #ifndef MODULE
-	stifb_setup(fb_get_options("stifb"));
+	char *option = NULL;
+
+	if (fb_get_options("stifb", &option))
+		return -ENODEV;
+	stifb_setup(option);
 #endif
 	if (stifb_disabled) {
 		printk(KERN_INFO "stifb: disabled by \"stifb=off\" kernel parameter\n");
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tcx.c linux-2.6.9-rc1-mm4/drivers/video/tcx.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tcx.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tcx.c	2004-09-10 21:32:01.913192864 +0800
@@ -468,6 +468,9 @@ int __init tcx_init(void)
 	struct sbus_bus *sbus;
 	struct sbus_dev *sdev;
 
+	if (fb_get_options("tcxfb", NULL))
+		return -ENODEV;
+
 	for_all_sbusdev(sdev, sbus) {
 		if (!strcmp(sdev->prom_name, "tcx"))
 			tcx_init_one(sdev);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tdfxfb.c linux-2.6.9-rc1-mm4/drivers/video/tdfxfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tdfxfb.c	2004-09-10 05:28:42.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tdfxfb.c	2004-09-10 21:32:01.916192408 +0800
@@ -1359,7 +1359,12 @@ static void __devexit tdfxfb_remove(stru
 int __init tdfxfb_init(void)
 {
 #ifndef MODULE
-	tdfxfb_setup(fb_get_options("tdfxfb"));
+	char *option = NULL;
+
+	if (fb_get_options("tdfxfb", &option))
+		return -ENODEV;
+
+	tdfxfb_setup(option);
 #endif
         return pci_module_init(&tdfxfb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tgafb.c linux-2.6.9-rc1-mm4/drivers/video/tgafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tgafb.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tgafb.c	2004-09-10 21:32:01.920191800 +0800
@@ -1528,7 +1528,11 @@ int __init
 tgafb_init(void)
 {
 #ifndef MODULE
-	tgafb_setup(fb_get_options("tgafb"));
+	char *option = NULL;
+
+	if (fb_get_options("tgafb", &option))
+		return -ENODEV;
+	tgafb_setup(option);
 #endif
 	return pci_module_init(&tgafb_driver);
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tridentfb.c linux-2.6.9-rc1-mm4/drivers/video/tridentfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tridentfb.c	2004-09-10 05:29:21.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tridentfb.c	2004-09-10 21:32:01.924191192 +0800
@@ -1224,7 +1224,11 @@ int tridentfb_setup(char *options);
 int __init tridentfb_init(void)
 {
 #ifndef MODULE
-	tridentfb_setup(fb_get_options("tridentfb"));
+	char *option = NULL;
+
+	if (fb_get_options("tridentfb", &option))
+		return -ENODEV;
+	tridentfb_setup(option);
 #endif
 	output("Trident framebuffer %s initializing\n", VERSION);
 	return pci_module_init(&tridentfb_pci_driver);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tx3912fb.c linux-2.6.9-rc1-mm4/drivers/video/tx3912fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tx3912fb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tx3912fb.c	2004-09-10 21:32:01.927190736 +0800
@@ -217,8 +217,11 @@ int __init tx3912fb_init(void)
 {
 	u_long tx3912fb_paddr = 0;
 	int size = (info->var.bits_per_pixel == 8) ? 256 : 16;
+	char *option = NULL;
 
-	tx3912fb_setup(fb_get_options("tx3912fb"));
+	if (fb_get_options("tx3912fb", &option))
+		return -ENODEV;
+	tx3912fb_setup(option);
 
 	/* Disable the video logic */
 	outl(inl(TX3912_VIDEO_CTRL1) &
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/valkyriefb.c linux-2.6.9-rc1-mm4/drivers/video/valkyriefb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/valkyriefb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/valkyriefb.c	2004-09-10 21:32:01.930190280 +0800
@@ -322,8 +322,11 @@ int __init valkyriefb_init(void)
 	struct fb_info_valkyrie	*p;
 	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
 	int err;
+	char *option = NULL;
 
-	valkyriefb_setup(fb_get_options("valkyriefb"));
+	if (fb_get_options("valkyriefb", &option))
+		return -ENODEV;
+	valkyriefb_setup(option);
 
 #ifdef CONFIG_MAC
 	if (!MACH_IS_MAC)
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/vesafb.c linux-2.6.9-rc1-mm4/drivers/video/vesafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/vesafb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/vesafb.c	2004-09-10 21:32:01.934189672 +0800
@@ -410,8 +410,11 @@ static struct platform_device vesafb_dev
 int __init vesafb_init(void)
 {
 	int ret;
+	char *option = NULL;
 
-	vesafb_setup(fb_get_options("vesafb"));
+	/* ignore error return of fb_get_options */
+	fb_get_options("vesafb", &option);
+	vesafb_setup(option);
 	ret = driver_register(&vesafb_driver);
 
 	if (!ret) {
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/vfb.c linux-2.6.9-rc1-mm4/drivers/video/vfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/vfb.c	2004-09-08 12:45:11.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/vfb.c	2004-09-10 21:32:01.937189216 +0800
@@ -497,7 +497,11 @@ int __init vfb_init(void)
 	int ret = 0;
 
 #ifndef MODULE
-	vfb_setup(fb_get_options("vfb"));
+	char *option = NULL;
+
+	if (fb_get_options("vfb", &option))
+		return -ENODEV;
+	vfb_setup(option);
 #endif
 
 	if (!vfb_enable)
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c	2004-09-10 05:28:48.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c	2004-09-10 21:32:01.940188760 +0800
@@ -1342,9 +1342,13 @@ int __init vga16fb_init(void)
 {
 	int i;
 	int ret;
-
 #ifndef MODULE
-	vga16fb_setup(fb_get_options("vga16fb"));
+	char *option = NULL;
+
+	if (fb_get_options("vga16fb", &option))
+		return -ENODEV;
+
+	vga16fb_setup(option);
 #endif
 	printk(KERN_DEBUG "vga16fb: initializing\n");
 
diff -uprN linux-2.6.9-rc1-mm4-orig/include/linux/fb.h linux-2.6.9-rc1-mm4/include/linux/fb.h
--- linux-2.6.9-rc1-mm4-orig/include/linux/fb.h	2004-09-10 05:29:28.000000000 +0800
+++ linux-2.6.9-rc1-mm4/include/linux/fb.h	2004-09-10 21:36:55.522557456 +0800
@@ -789,7 +789,7 @@ extern void fb_sysmove_buf_aligned(struc
 extern void fb_load_cursor_image(struct fb_info *);
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_info *info);
-extern char* fb_get_options(char *name);
+extern int fb_get_options(char *name, char **option);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;



