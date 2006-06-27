Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWF0TD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWF0TD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWF0TD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:03:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:29870 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932533AbWF0TDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:03:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mCgVR//5+P35L1UonRgaKps88ctK3opC8dX9BpXO/DGSU/90zVp9V+f3eBbn68+B4Mf58X2Qs5QXPJ0ATVyfXG9FcPA8FRAJ8yrpEHtcgkeb4GzlYgZqhp5xFZf5G+IgvYdsW3O+Fu/kfd6gQCsCr3lrzF2wAehPO2/CLRQa+NI=
Message-ID: <9e4733910606271203w4ceb6216g92f5fefee654aaf3@mail.gmail.com>
Date: Tue, 27 Jun 2006 15:03:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] move MAX_NR_CONSOLES from tty.h to vt.h
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_NR_CONSOLES is more of a function of the VT layer than the TTY
one. Moving this to vt.h allows all of the framebuffer drivers to
remove their dependency on tty.h. Note that console drivers in
video/console still depend on tty.h but fbdev drivers should not
depend on the tty layer.

Signed-off-by: Jon Smirl <jonsmir@gmail.com>

diff --git a/drivers/video/68328fb.c b/drivers/video/68328fb.c
index 78488bb..0dda73d 100644
--- a/drivers/video/68328fb.c
+++ b/drivers/video/68328fb.c
@@ -32,7 +32,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/S3triofb.c b/drivers/video/S3triofb.c
index 455fda9..0850eac 100644
--- a/drivers/video/S3triofb.c
+++ b/drivers/video/S3triofb.c
@@ -29,7 +29,6 @@ #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 3033c72..9c06446 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -45,7 +45,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/config.h>
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 4660428..a84b0c0 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -39,7 +39,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
index 29f9f0d..b9d3541 100644
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -35,7 +35,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index e69ab65..5831893 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -53,7 +53,6 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index db878fd..facd6f7 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -53,7 +53,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index c5ecbb0..e9d4b9e 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -59,7 +59,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/time.h>
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
index d76bbfa..f75dee9 100644
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -20,7 +20,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 1103010..17e00d3 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -42,7 +42,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 1ecda91..5f70fc2 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -7,7 +7,6 @@

 #include <linux/types.h>
 #include <linux/kdev_t.h>
-#include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/init.h>
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 7f939d0..1b7ec3d 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -31,7 +31,6 @@ #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/tty.h>
 #include <linux/console.h>
 #include <linux/string.h>
 #include <linux/kd.h>
diff --git a/drivers/video/console/newport_con.c
b/drivers/video/console/newport_con.c
index e99fe30..c08cb7b 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/tty.h>
 #include <linux/kd.h>
 #include <linux/selection.h>
 #include <linux/console.h>
diff --git a/drivers/video/console/softcursor.c
b/drivers/video/console/softcursor.c
index 3957fc7..557c563 100644
--- a/drivers/video/console/softcursor.c
+++ b/drivers/video/console/softcursor.c
@@ -10,7 +10,6 @@

 #include <linux/module.h>
 #include <linux/string.h>
-#include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/slab.h>

diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
index 655301a..8f69231 100644
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -37,7 +37,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
index 55a3514..0dce249 100644
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -42,7 +42,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/cyberfb.c b/drivers/video/cyberfb.c
index a3e189f..c40e72d 100644
--- a/drivers/video/cyberfb.c
+++ b/drivers/video/cyberfb.c
@@ -81,7 +81,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/zorro.h>
diff --git a/drivers/video/dnfb.c b/drivers/video/dnfb.c
index 5abd3cb..b083ea7 100644
--- a/drivers/video/dnfb.c
+++ b/drivers/video/dnfb.c
@@ -2,7 +2,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index 0827594..5921f88 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -48,7 +48,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
index 1f98392..e8b135f 100644
--- a/drivers/video/fbcmap.c
+++ b/drivers/video/fbcmap.c
@@ -13,7 +13,6 @@

 #include <linux/string.h>
 #include <linux/module.h>
-#include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/slab.h>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 372aa17..f968d10 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -24,7 +24,7 @@ #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/tty.h>
+#include <linux/vt.h>
 #include <linux/init.h>
 #include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 53beeb4..64cec86 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -26,7 +26,6 @@
  * for more details.
  *
  */
-#include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
 #include <video/edid.h>
diff --git a/drivers/video/g364fb.c b/drivers/video/g364fb.c
index 605d1a1..1b981b6 100644
--- a/drivers/video/g364fb.c
+++ b/drivers/video/g364fb.c
@@ -21,7 +21,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 20e6915..96782fa 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -15,7 +15,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 89c34b1..a067532 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -25,7 +25,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/hgafb.c b/drivers/video/hgafb.c
index 4e39035..fb9e672 100644
--- a/drivers/video/hgafb.c
+++ b/drivers/video/hgafb.c
@@ -36,7 +36,6 @@ #include <linux/errno.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/hitfb.c b/drivers/video/hitfb.c
index f04ca72..36e2499 100644
--- a/drivers/video/hitfb.c
+++ b/drivers/video/hitfb.c
@@ -18,7 +18,6 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
index abd920a..91cf3b5 100644
--- a/drivers/video/hpfb.c
+++ b/drivers/video/hpfb.c
@@ -11,7 +11,6 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 44aa2ff..685e243 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -34,7 +34,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
 #include <linux/init.h>
diff --git a/drivers/video/igafb.c b/drivers/video/igafb.c
index 8a0c2d3..67f384f 100644
--- a/drivers/video/igafb.c
+++ b/drivers/video/igafb.c
@@ -33,7 +33,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index f73c642..5a32bb6 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -22,7 +22,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/intelfb/intelfbdrv.c
b/drivers/video/intelfb/intelfbdrv.c
index 0a0a8b1..283a173 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -114,7 +114,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/intelfb/intelfbhw.c
b/drivers/video/intelfb/intelfbhw.c
index 7533b3d..4511c2d 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -25,7 +25,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index 477ad29..19da5f4 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -17,7 +17,6 @@ #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/string.h>
-#include <linux/tty.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/ioctl.h>
diff --git a/drivers/video/macfb.c b/drivers/video/macfb.c
index e6cbd9d..80a0438 100644
--- a/drivers/video/macfb.c
+++ b/drivers/video/macfb.c
@@ -24,7 +24,6 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/nubus.h>
diff --git a/drivers/video/matrox/matroxfb_base.h
b/drivers/video/matrox/matroxfb_base.h
index b717371..e48e1c7 100644
--- a/drivers/video/matrox/matroxfb_base.h
+++ b/drivers/video/matrox/matroxfb_base.h
@@ -31,7 +31,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/maxinefb.c b/drivers/video/maxinefb.c
index f85421b..38c8d38 100644
--- a/drivers/video/maxinefb.c
+++ b/drivers/video/maxinefb.c
@@ -29,7 +29,6 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 26a1c61..33023fb 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -12,7 +12,6 @@
  */

 #include <linux/module.h>
-#include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/sched.h>

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 24b12f7..1348f71 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -60,7 +60,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 03a7c1e..e6a8ef1 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -15,7 +15,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index ad1434e..6ebaee3 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -18,7 +18,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 335e374..bff64b4 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -23,7 +23,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 4e96393..81bd3db 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -34,7 +34,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 52c18a3..3383add 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -58,7 +58,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/pmag-aa-fb.c b/drivers/video/pmag-aa-fb.c
index d92f352..68ca3cc 100644
--- a/drivers/video/pmag-aa-fb.c
+++ b/drivers/video/pmag-aa-fb.c
@@ -29,7 +29,6 @@ #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index ec4bacf..c6c904b 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -53,7 +53,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/config.h>
diff --git a/drivers/video/q40fb.c b/drivers/video/q40fb.c
index fc91dbf..48536c3 100644
--- a/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -14,7 +14,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/video/retz3fb.c b/drivers/video/retz3fb.c
index 5e2c64f..cf41ff1 100644
--- a/drivers/video/retz3fb.c
+++ b/drivers/video/retz3fb.c
@@ -25,7 +25,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index d4384ab..b2e0f17 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -35,7 +35,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 9451932..7a32ade 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -76,7 +76,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/savage/savagefb_driver.c
b/drivers/video/savage/savagefb_driver.c
index 0da624e..79e84a1 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -47,7 +47,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 8adf5bf..4da2cd6 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -45,7 +45,6 @@ #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
 #include <linux/selection.h>
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 9b70777..b2725a2 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -47,7 +47,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/sun3fb.c b/drivers/video/sun3fb.c
index 9b36b9d..3373491 100644
--- a/drivers/video/sun3fb.c
+++ b/drivers/video/sun3fb.c
@@ -31,7 +31,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 5e5328d..07edecb 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -64,7 +64,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index 7398bd4..9bdd4bb 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -17,7 +17,6 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff --git a/drivers/video/tx3912fb.c b/drivers/video/tx3912fb.c
index d904da4..07389ba 100644
--- a/drivers/video/tx3912fb.c
+++ b/drivers/video/tx3912fb.c
@@ -14,7 +14,6 @@ #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
-#include <linux/tty.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/drivers/video/valkyriefb.c b/drivers/video/valkyriefb.c
index 2bdeb4b..895ea90 100644
--- a/drivers/video/valkyriefb.c
+++ b/drivers/video/valkyriefb.c
@@ -45,7 +45,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index b0b9acf..059d85c 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -13,7 +13,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 77eed1f..57d8077 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -15,7 +15,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 4fd2a27..608fba0 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -15,13 +15,13 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/screen_info.h>

 #include <asm/io.h>
 #include <video/vga.h>
diff --git a/drivers/video/virgefb.c b/drivers/video/virgefb.c
index 5ea2345..6437895 100644
--- a/drivers/video/virgefb.c
+++ b/drivers/video/virgefb.c
@@ -39,7 +39,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/zorro.h>
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index f8e5587..25423f7 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -9,6 +9,7 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */

+#include <linux/wait.h>
 #include <linux/vt.h>

 struct vt_struct;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f128168..57b0273 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -377,7 +377,6 @@ #ifdef __KERNEL__

 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/tty.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/devfs_fs_kernel.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index cb35ca5..32aac7a 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -5,16 +5,6 @@ #define _LINUX_TTY_H
  * 'tty.h' defines some structures used by tty_io.c and some defines.
  */

-/*
- * These constants are also useful for user-level apps (e.g., VC
- * resizing).
- */
-#define MIN_NR_CONSOLES 1       /* must be at least 1 */
-#define MAX_NR_CONSOLES	63	/* serial lines start at 64 */
-#define MAX_NR_USER_CONSOLES 63	/* must be root to allocate above this */
-		/* Note: the ioctl VT_GETSTATE does not work for
-		   consoles 16 and higher (since it returns a short) */
-
 #ifdef __KERNEL__
 #include <linux/fs.h>
 #include <linux/major.h>
diff --git a/include/linux/vt.h b/include/linux/vt.h
index 9f95b0b..8ab334a 100644
--- a/include/linux/vt.h
+++ b/include/linux/vt.h
@@ -1,6 +1,16 @@
 #ifndef _LINUX_VT_H
 #define _LINUX_VT_H

+/*
+ * These constants are also useful for user-level apps (e.g., VC
+ * resizing).
+ */
+#define MIN_NR_CONSOLES 1       /* must be at least 1 */
+#define MAX_NR_CONSOLES	63	/* serial lines start at 64 */
+#define MAX_NR_USER_CONSOLES 63	/* must be root to allocate above this */
+		/* Note: the ioctl VT_GETSTATE does not work for
+		   consoles 16 and higher (since it returns a short) */
+
 /* 0x56 is 'V', to avoid collision with termios and kd */

 #define VT_OPENQRY	0x5600	/* find available vt */
