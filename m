Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbVLMTwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbVLMTwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVLMTwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:52:38 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:60332 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932597AbVLMTwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:52:36 -0500
Message-ID: <439EF4CB.8030007@t-online.de>
Date: Tue, 13 Dec 2005 17:20:27 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and updated CyblaFB
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: VyJqSBZXoePfssuuhJ2KWHApKuf4ka5N0COPdmLcRXRXNgqGcF7dEi@t-dialin.net
X-TOI-MSGID: 2cae38be-1b15-43dd-9960-8f0a119ab86e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.6.15-rc5-git3 all patches needed by this new version
of cyblafb reached the main line kernel. So here it is.

Main advantages:
============
   - vxres > xres support
   - ywrap support
   - much faster for almost all modes (e.g. 1280x1024-16bpp
      draws more than 41 full screens of text instead of about 25
      full screens of text per second on authors Epia 5000)
   - module init/exit code fixed
   - bugs triggered by console rotation fixed
   - lots of minor improvements
   - startup modes suitable for high performance scrolling
      in all directions

As only one single graphics core is affected, there should be no
reason not to include it in 2.6.15. No side effects are possible.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/Documentation/fb/cyblafb/fb.modes linux/Documentation/fb/cyblafb/fb.modes
--- linuxorig/Documentation/fb/cyblafb/fb.modes	2005-10-28 02:02:08.000000000 +0200
+++ linux/Documentation/fb/cyblafb/fb.modes	2005-12-13 14:34:06.000000000 +0100
@@ -14,142 +14,142 @@
 #
 
 mode "640x480-50"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 47619 4294967256 24 17 0 216 3
 endmode
 
 mode "640x480-60"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 39682 4294967256 24 17 0 216 3
 endmode
 
 mode "640x480-70"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 34013 4294967256 24 17 0 216 3
 endmode
 
 mode "640x480-72"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 33068 4294967256 24 17 0 216 3
 endmode
 
 mode "640x480-75"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 31746 4294967256 24 17 0 216 3
 endmode
 
 mode "640x480-80"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 29761 4294967256 24 17 0 216 3
 endmode
 
 mode "640x480-85"
-    geometry 640 480 640 3756 8
+    geometry 640 480 2048 4096 8
     timings 28011 4294967256 24 17 0 216 3
 endmode
 
 mode "800x600-50"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 30303 96 24 14 0 136 11
 endmode
 
 mode "800x600-60"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 25252 96 24 14 0 136 11
 endmode
 
 mode "800x600-70"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 21645 96 24 14 0 136 11
 endmode
 
 mode "800x600-72"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 21043 96 24 14 0 136 11
 endmode
 
 mode "800x600-75"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 20202 96 24 14 0 136 11
 endmode
 
 mode "800x600-80"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 18939 96 24 14 0 136 11
 endmode
 
 mode "800x600-85"
-    geometry 800 600 800 3221 8
+    geometry 800 600 2048 4096 8
     timings 17825 96 24 14 0 136 11
 endmode
 
 mode "1024x768-50"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 19054 144 24 29 0 120 3
 endmode
 
 mode "1024x768-60"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 15880 144 24 29 0 120 3
 endmode
 
 mode "1024x768-70"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 13610 144 24 29 0 120 3
 endmode
 
 mode "1024x768-72"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 13232 144 24 29 0 120 3
 endmode
 
 mode "1024x768-75"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 12703 144 24 29 0 120 3
 endmode
 
 mode "1024x768-80"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 11910 144 24 29 0 120 3
 endmode
 
 mode "1024x768-85"
-    geometry 1024 768 1024 2815 8
+    geometry 1024 768 2048 4096 8
     timings 11209 144 24 29 0 120 3
 endmode
 
 mode "1280x1024-50"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 11114 232 16 39 0 160 3
 endmode
 
 mode "1280x1024-60"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 9262 232 16 39 0 160 3
 endmode
 
 mode "1280x1024-70"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 7939 232 16 39 0 160 3
 endmode
 
 mode "1280x1024-72"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 7719 232 16 39 0 160 3
 endmode
 
 mode "1280x1024-75"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 7410 232 16 39 0 160 3
 endmode
 
 mode "1280x1024-80"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 6946 232 16 39 0 160 3
 endmode
 
 mode "1280x1024-85"
-    geometry 1280 1024 1280 2662 8
+    geometry 1280 1024 2048 4096 8
     timings 6538 232 16 39 0 160 3
 endmode
 
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/Documentation/fb/cyblafb/todo linux/Documentation/fb/cyblafb/todo
--- linuxorig/Documentation/fb/cyblafb/todo	2005-10-28 02:02:08.000000000 +0200
+++ linux/Documentation/fb/cyblafb/todo	2005-12-13 13:15:21.000000000 +0100
@@ -22,11 +22,10 @@ accelerated color blitting	Who needs it?
 				everything else is done using color expanding
 				blitting of 1bpp character bitmaps.
 
-xpanning			Who needs it?
-
 ioctls				Who needs it?
 
-TV-out				Will be done later
+TV-out				Will be done later. Use "vga= " at boot time
+				to set a suitable video mode.
 
 ???				Feel free to contact me if you have any
 				feature requests
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/Documentation/fb/cyblafb/usage linux/Documentation/fb/cyblafb/usage
--- linuxorig/Documentation/fb/cyblafb/usage	2005-10-28 02:02:08.000000000 +0200
+++ linux/Documentation/fb/cyblafb/usage	2005-12-13 14:38:33.000000000 +0100
@@ -40,6 +40,16 @@ Selecting Modes
 	None of the modes possible to select as startup modes are affected by
 	the problems described at the end of the next subsection.
 
+	For all startup modes cyblafb chooses a virtual x resolution of 2048,
+	the only exception is mode 1280x1024 in combination with 32 bpp. This
+	allows ywrap scrolling for all those modes if rotation is 0 or 2, and
+	also fast scrolling if rotation is 1 or 3. The default virtual y reso-
+	lution is 4096 for bpp == 8, 2048 for bpp==16 and 1024 for bpp == 32,
+	again with the only exception of 1280x1024 at 32 bpp.
+
+	Please do set your video memory size to 8 Mb in the Bios setup. Other
+	values will work, but performace is decreased for a lot of modes.
+
 	Mode changes using fbset
 	========================
 
@@ -54,20 +64,22 @@ Selecting Modes
 		- if a flat panel is found, cyblafb does not allow you
 		  to program a resolution higher than the physical
 		  resolution of the flat panel monitor
-		- cyblafb does not allow xres to differ from xres_virtual
 		- cyblafb does not allow vclk to exceed 230 MHz. As 32 bpp
 		  and (currently) 24 bit modes use a doubled vclk internally,
 		  the dotclock limit as seen by fbset is 115 MHz for those
 		  modes and 230 MHz for 8 and 16 bpp modes.
 
-	Any request that violates the rules given above will be ignored and
-	fbset will return an error.
+	Any request that violates the rules given above will be either changed
+	to something the hardware supports or an error value will be returned.
 
 	If you program a virtual y resolution higher than the hardware limit,
 	cyblafb will silently decrease that value to the highest possible
-	value.
+	value. The same is true for a virtual x resolution that is not
+	supported by the hardware. Cyblafb tries to adapt vyres first because
+	vxres decides if ywrap scrolling is possible or not. 
 
-	Attempts to disable acceleration are ignored.
+	Attempts to disable acceleration are ignored, I believe that this is
+	safe.
 
 	Some video modes that should work do not work as expected. If you use
 	the standard fb.modes, fbset 640x480-60 will program that mode, but
@@ -129,9 +141,13 @@ mode		640x480 or 800x600 or 1024x768 or 
 verbosity	0 is the default, increase to at least 2 for every
 		bug report!
 
-vesafb		allows cyblafb to be loaded after vesafb has been
-		loaded. See sections "Module unloading ...".
-
+scalign		alignment of the pixel lines in the image bitmaps,
+		possible values are 1, 2 and 4, the default is 4.
+		The values 1 and 2 are slightly slower than the
+		default, but this option is usefull as it allows
+		to test changes in the bitmap construction code for
+		all alignment requirements used by other framebuffer
+		drivers.
 
 Development hints
 =================
@@ -195,7 +211,7 @@ a graphics mode.
 After booting, load cyblafb without any mode and bpp parameter and assign
 cyblafb to individual ttys using con2fb, e.g.:
 
-	modprobe cyblafb vesafb=1
+	modprobe cyblafb
 	con2fb /dev/fb1 /dev/tty1
 
 Unloading cyblafb works without problems after you assign vesafb to all
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/Documentation/fb/cyblafb/whatsnew linux/Documentation/fb/cyblafb/whatsnew
--- linuxorig/Documentation/fb/cyblafb/whatsnew	1970-01-01 01:00:00.000000000 +0100
+++ linux/Documentation/fb/cyblafb/whatsnew	2005-12-13 14:46:30.000000000 +0100
@@ -0,0 +1,26 @@
+0.60
+====
+
+      - the vesafb parameter has been removed as I decided to allow the
+      	feature without any special parameter.
+
+      - Cyblafb does not use the vga style of panning any longer, now the
+      	"right view" register in the graphics engine IO space is used. Without
+	that change it was impossible to use all available memory, and without
+	access to all available memory it is impossible to ywrap.
+
+      - The imageblit function now uses hardware acceleration for all font
+        widths.
+
+      - modes with vxres != xres are supported now.
+
+      - ywrap scrolling is supported now and the default. This is a big
+        performance gain.
+
+      - default video modes use vyres > yres and vxres > xres to allow
+        almost optimal scrolling speed for normal and rotated screens
+      
+      - some features mainly usefull for debugging the upper layers of the
+        framebuffer system have been added, have a look at the code
+
+      - fixed: Oops after unloading cyblafb when reading /proc/io*
\ No newline at end of file
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/cyblafb.c linux/drivers/video/cyblafb.c
--- linuxorig/drivers/video/cyblafb.c	2005-12-13 06:57:46.000000000 +0100
+++ linux/drivers/video/cyblafb.c	2005-12-13 16:00:57.000000000 +0100
@@ -12,6 +12,7 @@
  */
 
 #define CYBLAFB_DEBUG 0
+#define CYBLAFB_PIXMAPSIZE 8192
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -22,7 +23,7 @@
 #include <asm/types.h>
 #include <video/cyblafb.h>
 
-#define VERSION "0.54"
+#define VERSION "0.60"
 
 struct cyblafb_par {
 	u32 pseudo_pal[16];
@@ -32,7 +33,9 @@ struct cyblafb_par {
 static struct fb_fix_screeninfo cyblafb_fix __devinitdata = {
 	.id = "CyBla",
 	.type = FB_TYPE_PACKED_PIXELS,
+	.xpanstep = 1,
 	.ypanstep = 1,
+	.ywrapstep = 1,
 	.visual = FB_VISUAL_PSEUDOCOLOR,
 	.accel = FB_ACCEL_NONE,
 };
@@ -43,8 +46,10 @@ static int ref __devinitdata = 75;
 static int fp __devinitdata;
 static int crt __devinitdata;
 static int memsize __devinitdata;
-static int vesafb __devinitdata;
+static int scalign __devinitdata = 4;
 
+static int basestride = 0;
+static int vesafb;
 static int nativex;
 static int center;
 static int stretch;
@@ -71,7 +76,7 @@ module_param(pciwr,int,0);
 module_param(pcirr,int,0);
 module_param(memsize,int,0);
 module_param(verbosity,int,0);
-module_param(vesafb,int,0);
+module_param(scalign,int,0);
 
 //=========================================
 //
@@ -188,7 +193,7 @@ static void set_vclk(struct cyblafb_par 
 	}
 	write3C4(SR19,hi);
 	write3C4(SR18,lo);
-	if(verbosity > 1)
+	if(verbosity > 0)
 		output("pixclock = %d.%02d MHz, k/m/n %x %x %x\n",
 		freq/100,freq%100,(hi&0xc0)>>6,hi&0x3f,lo);
 }
@@ -211,6 +216,8 @@ static void cyblafb_setup_GE(int pitch,i
 		case 32: base |= (2<<29); break;
 	}
 
+	basestride = base;
+
 	write3X4(CR36,0x90);	// reset GE
 	write3X4(CR36,0x80);	// enable GE
 
@@ -240,8 +247,8 @@ static void cyblafb_setup_GE(int pitch,i
 
 static int cyblafb_sync(struct fb_info *info)
 {
-	int status, i=100000;
-	while( ((status=in32(GE20)) & 0xFA800000) && i != 0)
+	int status,i=100000;
+	while( ((status=in32(GE20)) & 0xFe800000) && i != 0)
 		i--;
 
 	if (i == 0) {
@@ -253,7 +260,6 @@ static int cyblafb_sync(struct fb_info *
 		//     of kdm/X
 		// So we make sure that mmio is enabled first ...
 		enable_mmio();
-//		show_trace(NULL,&status);
 		i=1000000;
 		while( ((status=in32(GE20)) & 0xFA800000) && i != 0)
 			i--;
@@ -310,13 +316,13 @@ static void cyblafb_fillrect(struct fb_i
 			 break;
 	}
 
-	cyblafb_sync(info);
-
+	out32(GEB8,basestride |
+		   (((fr->dy >> 3) * info->var.xres_virtual * bpp) >> 3));
 	out32(GE60,col);
 	out32(GE48,fr->rop ? 0x66:ROP_S);
 	out32(GE44,0x20000000|1<<19|1<<4|2<<2);
-	out32(GE08,point(fr->dx,fr->dy));
-	out32(GE0C,point(fr->dx+fr->width-1,fr->dy+fr->height-1));
+	out32(GE08,point(fr->dx,0));
+	out32(GE0C,point(fr->dx+fr->width-1,(fr->dy % 8) + fr->height-1));
 
 }
 
@@ -327,27 +333,30 @@ static void cyblafb_fillrect(struct fb_i
 //==============================
 
 static void cyblafb_copyarea(struct fb_info *info,
-			     const struct fb_copyarea *ca)
+                             const struct fb_copyarea *ca)
 {
-	__u32 s1,s2,d1,d2;
-	int direction;
-
-	s1 = point(ca->sx,ca->sy);
-	s2 = point(ca->sx+ca->width-1,ca->sy+ca->height-1);
-	d1 = point(ca->dx,ca->dy);
-	d2 = point(ca->dx+ca->width-1,ca->dy+ca->height-1);
-	if ((ca->sy > ca->dy) || ((ca->sy == ca->dy) && (ca->sx > ca->dx)))
-		direction = 0;
-	else
-		direction = 2;
-
-	cyblafb_sync(info);
+        __u32 s1,s2,d1,d2;
+        int direction;
 
-	out32(GE44,0xa0000000|1<<19|1<<2|direction);
-	out32(GE00,direction?s2:s1);
-	out32(GE04,direction?s1:s2);
-	out32(GE08,direction?d2:d1);
-	out32(GE0C,direction?d1:d2);
+        s1 = point(ca->sx,0);
+        s2 = point(ca->sx+ca->width-1,ca->height-1);
+        d1 = point(ca->dx,0);
+        d2 = point(ca->dx+ca->width-1,ca->height-1);
+
+        if ((ca->sy > ca->dy) || ((ca->sy == ca->dy) && (ca->sx > ca->dx)))
+                direction = 0;
+        else
+                direction = 2;
+
+	out32(GEB8,basestride | ((ca->dy * info->var.xres_virtual *
+				info->var.bits_per_pixel) >> 6));
+	out32(GEC8,basestride | ((ca->sy * info->var.xres_virtual *
+				info->var.bits_per_pixel) >> 6 ));
+        out32(GE44,0xa0000000|1<<19|1<<2|direction);
+        out32(GE00,direction?s2:s1);
+        out32(GE04,direction?s1:s2);
+        out32(GE08,direction?d2:d1);
+        out32(GE0C,direction?d1:d2);
 
 }
 
@@ -355,26 +364,37 @@ static void cyblafb_copyarea(struct fb_i
 //
 // Cyberblade specific imageblit
 //
-// Accelerated for the most usual case, blitting 1-bit deep character
-// character images. Everything else is passed to the generic imageblit.
+// Accelerated for the most usual case, blitting 1-bit deep
+// character images. Everything else is passed to the generic imageblit
+// unless it is so insane that it is better to printk an alert.
 //
 //=======================================================================
 
 static void cyblafb_imageblit(struct fb_info *info,
 			      const struct fb_image *image)
 {
+	u32 fgcol, bgcol, *pd = (u32 *) image->data;
 
-	u32 fgcol, bgcol;
-
-	int i;
 	int bpp = info->var.bits_per_pixel;
-	int index = 0;
-	int index_end=image->height * image->width / 8;
-	int width_dds=image->width / 32;
-	int width_dbs=image->width % 32;
 
-	if (image->depth != 1 || bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
-	    image->width % 8 != 0 || image->width == 0 || image->height == 0) {
+	// Used only for drawing the penguine (image->depth > 1)
+	if (image->depth != 1) {
+		if (verbosity > 1)
+			output("imageblit depth = %d, dimen = %d x %d\n",
+			image->depth, image->width, image->height);
+		cfb_imageblit(info,image);
+		return;
+	}
+
+	// That should never happen, but it would be fatal
+	if (image->width == 0 || image->height == 0) {
+		output("imageblit: width/height 0 detected\n");
+		return;
+	}
+
+	if (bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
+				   info->pixmap.scan_align > 4 ) {
+		output("imageblit: invalid bpp or pixmap alignement\n");
 		cfb_imageblit(info,image);
 		return;
 	}
@@ -401,32 +421,32 @@ static void cyblafb_imageblit(struct fb_
 			 break;
 	}
 
-	cyblafb_sync(info);
-
+	out32(GEB8,basestride |
+		   ((image->dy * info->var.xres_virtual * bpp) >> 6));
 	out32(GE60,fgcol);
 	out32(GE64,bgcol);
 	out32(GE44,0xa0000000 | 1<<20 | 1<<19);
-	out32(GE08,point(image->dx,image->dy));
-	out32(GE0C,point(image->dx+image->width-1,image->dy+image->height-1));
+	out32(GE08,point(image->dx,0));
+	out32(GE0C,point(image->dx+image->width-1,image->height-1));
 
-	while(index < index_end) {
-		const char *p = image->data + index;
-		for(i=0;i<width_dds;i++) {
-			out32(GE9C,*(u32*)p);
-			p+=4;
-			index+=4;
-		}
-		switch(width_dbs) {
-		case 0: break;
-		case 8:	out32(GE9C,*(u8*)p);
-			index+=1;
-			break;
-		case 16: out32(GE9C,*(u16*)p);
-			index+=2;
-			break;
-		case 24: out32(GE9C,*(u16*)p | *(u8*)(p+2)<<16);
-			index+=3;
-			break;
+	if (likely(info->pixmap.scan_align == 4)) {
+		int dds = ((image->width + 31) >> 5) * image->height;
+		while (dds--)
+			out32(GE9C,*pd++);
+	} else {
+		int i, j, dds = image->width / 32, bits = image->width % 32;
+		for (i=0; i<image->height; i++) {
+			for (j=0; j<dds; j++)
+				out32(GE9C, *pd++);
+			if(bits != 0) {
+				out32(GE9C, *pd);
+				if (info->pixmap.scan_align == 2)
+					pd = (u32*)((u32) pd +
+						(((bits + 15) >> 4) << 1) );
+				else
+					pd = (u32*)((u32) pd +
+						((bits + 7) >> 3));
+			}
 		}
 	}
 }
@@ -442,8 +462,8 @@ static void cyblafb_imageblit(struct fb_
 static int cyblafb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
+
 	int bpp = var->bits_per_pixel;
-	int s,t,maxvyres;
 
 	//
 	// we try to support 8, 16, 24 and 32 bpp modes,
@@ -472,33 +492,38 @@ static int cyblafb_check_var(struct fb_v
 		return -EINVAL;
 
 	//
-	// xres != xres_virtual is broken, fail if such an
-	// unusual mode is requested
-	//
-	if (var->xres != var->xres_virtual)
-		return -EINVAL;
-
-	//
-	// we do not allow vclk to exceed 230 MHz
+	// we do not allow vclk to exceed 230 MHz. If the requested
+	// vclk is too high, we default to 200 MHz
 	//
 	if ((bpp==32 ? 200000000 : 100000000) / var->pixclock > 23000)
-		return -EINVAL;
+		var->pixclock = (bpp==32 ? 200000000 : 100000000) / 20000;
 
 	//
-	// calc max yres_virtual that would fit in memory
-	// and max yres_virtual that could be used for scrolling
-	// and use minimum of the results as maxvyres
-	//
-	// adjust vyres_virtual to maxvyres if necessary
-	// fail if requested yres is bigger than maxvyres
-	//
-	s = (0x1fffff / (var->xres * bpp/8)) + var->yres;
-	t = info->fix.smem_len / (var->xres * bpp/8);
-	maxvyres = t < s ? t : s;
-	if (maxvyres < var->yres_virtual)
-		var->yres_virtual=maxvyres;
-	if (maxvyres < var->yres)
+	// try to be smart about (x|y)res(_virtual) problems.
+	//
+	if (var->xres % 8 != 0)
 		return -EINVAL;
+	if (var->xres > var->xres_virtual)
+		var->xres_virtual = var->xres;
+	if (var->yres > var->yres_virtual)
+		var->yres_virtual = var->yres;
+	if (bpp == 8 || bpp == 16) {
+		if (var->xres_virtual > 4088)
+			var->xres_virtual = 4088;
+	} else {
+		if (var->xres_virtual > 2040)
+			var->xres_virtual = 2040;
+	}
+	if (var->xres_virtual % 8 != 0)
+		var->xres_virtual &= ~7;
+	while(var->xres_virtual*var->yres_virtual*bpp/8 > info->fix.smem_len) {
+		if (var->yres_virtual > var->yres)
+			var->yres_virtual --;
+		else if (var->xres_virtual > var->xres)
+			var->xres_virtual -= 8;
+		else
+			return -EINVAL;
+	}
 
 	switch (bpp) {
 		case 8:
@@ -543,23 +568,23 @@ static int cyblafb_check_var(struct fb_v
 // it, so it is also safe to be used here. BTW: datasheet CR0E on page
 // 90 really is CR1E, the real CRE is documented on page 72.
 //
+// BUT:
+//
+// As of internal version 0.60 we do not use vga panning any longer.
+// Vga panning did not allow us the use of all available video memory
+// and thus prevented ywrap scrolling. We do use the "right view"
+// register now.
+//
+//
 //=====================================================================
 
 static int cyblafb_pan_display(struct fb_var_screeninfo *var,
 			       struct fb_info *info)
 {
-	unsigned int offset;
-
-	offset=(var->xoffset+(var->yoffset*var->xres))*var->bits_per_pixel/32;
 	info->var.xoffset = var->xoffset;
 	info->var.yoffset = var->yoffset;
-
-	write3X4(CR0D,offset & 0xFF);
-	write3X4(CR0C,(offset & 0xFF00) >> 8);
-	write3X4(CR1E,(read3X4(CR1E) & 0xDF) | ((offset & 0x10000) >> 11));
-	write3X4(CR27,(read3X4(CR27) & 0xF8) | ((offset & 0xE0000) >> 17));
-	write3X4(CR2B,(read3X4(CR2B) & 0xDF) | ((offset & 0x100000) >> 15));
-
+	out32(GE10,0x80000000 | ((var->xoffset + (var->yoffset *
+				var->xres_virtual)) * var->bits_per_pixel/32));
 	return 0;
 }
 
@@ -631,6 +656,42 @@ static void regdump(struct cyblafb_par *
 	return;
 }
 
+//=======================================================================
+//
+// Save State
+//
+// This function is called while a switch to KD_TEXT is in progress,
+// before any of the other functions are called.
+//
+//=======================================================================
+
+static void cyblafb_save_state(struct fb_info *info)
+{
+	struct cyblafb_par *par = info->par;
+	if (verbosity > 0)
+		output("Switching to KD_TEXT\n");
+	regdump(par);
+	return;
+}
+
+//=======================================================================
+//
+// Restore State
+//
+// This function is called while a switch to KD_GRAPHICS is in progress,
+// We have to turn on vga style panning registers again because the
+// trident driver of X does not know about GE10.
+//
+//=======================================================================
+
+static void cyblafb_restore_state(struct fb_info *info)
+{
+	if (verbosity > 0)
+		output("Switching to KD_GRAPHICS\n");
+	out32(GE10,0); // reenable vga style panning registers
+	return;
+}
+
 //======================================
 //
 // Set hardware to requested video mode
@@ -640,9 +701,9 @@ static void regdump(struct cyblafb_par *
 static int cyblafb_set_par(struct fb_info *info)
 {
 	struct cyblafb_par *par = info->par;
-	u32
-	htotal,hdispend,hsyncstart,hsyncend,hblankstart,hblankend,preendfetch,
-		vtotal,vdispend,vsyncstart,vsyncend,vblankstart,vblankend;
+	u32 htotal,hdispend,hsyncstart,hsyncend,hblankstart,
+	    hblankend,preendfetch, vtotal,vdispend,vsyncstart,
+	    vsyncend,vblankstart,vblankend;
 	struct fb_var_screeninfo *var = &info->var;
 	int bpp = var->bits_per_pixel;
 	int i;
@@ -732,11 +793,11 @@ static int cyblafb_set_par(struct fb_inf
 	write3X4(CR10,vsyncstart & 0xFF);
 	write3X4(CR11,(vsyncend & 0x0F));
 	write3X4(CR12,vdispend & 0xFF);
-	write3X4(CR13,((info->var.xres * bpp)/(4*16)) & 0xFF);
+	write3X4(CR13,((info->var.xres_virtual * bpp)/(4*16)) & 0xFF);
 	write3X4(CR14,0x40);  // double word mode
 	write3X4(CR15,vblankstart & 0xFF);
 	write3X4(CR16,vblankend & 0xFF);
-	write3X4(CR17,0xC3);
+	write3X4(CR17,0xE3);
 	write3X4(CR18,0xFF);
 	//	 CR19: needed for interlaced modes ... ignore it for now
 	write3X4(CR1A,0x07); // Arbitration Control Counter 1
@@ -758,8 +819,8 @@ static int cyblafb_set_par(struct fb_inf
 		      (vtotal & 0x400) >> 3 |
 		      0x8);
 	//	 CR28: ???
-	write3X4(CR29,(read3X4(CR29) & 0xCF) |
-		      ((((info->var.xres * bpp) / (4*16)) & 0x300) >>4));
+	write3X4(CR29,(read3X4(CR29) & 0xCF) | ((((info->var.xres_virtual *
+		      bpp) / (4*16)) & 0x300) >>4));
 	write3X4(CR2A,read3X4(CR2A) | 0x40);
 	write3X4(CR2B,(htotal & 0x100) >> 8 |
 		      (hdispend & 0x100) >> 7 |
@@ -860,13 +921,30 @@ static int cyblafb_set_par(struct fb_inf
 
 	info->fix.visual = (bpp == 8) ? FB_VISUAL_PSEUDOCOLOR
 				      : FB_VISUAL_TRUECOLOR;
-	info->fix.line_length = info->var.xres * (bpp >> 3);
+	info->fix.line_length = info->var.xres_virtual * (bpp >> 3);
 	info->cmap.len = (bpp == 8) ? 256: 16;
 
 	//
 	// init acceleration engine
 	//
-	cyblafb_setup_GE(info->var.xres,info->var.bits_per_pixel);
+	cyblafb_setup_GE(info->var.xres_virtual,info->var.bits_per_pixel);
+
+	//
+	// Set/clear flags to allow proper scroll mode selection.
+	//
+	if (var->xres == var->xres_virtual)
+		info->flags &= ~FBINFO_HWACCEL_XPAN;
+	else
+		info->flags |= FBINFO_HWACCEL_XPAN;
+	if (var->yres == var->yres_virtual)
+		info->flags &= ~FBINFO_HWACCEL_YPAN;
+	else
+		info->flags |= FBINFO_HWACCEL_YPAN;
+	if (info->fix.smem_len !=
+			 var->xres_virtual * var->yres_virtual * bpp / 8)
+		info->flags &= ~FBINFO_HWACCEL_YWRAP;
+	else
+		info->flags |= FBINFO_HWACCEL_YWRAP;
 
 	regdump(par);
 
@@ -968,6 +1046,9 @@ static struct fb_ops cyblafb_ops __devin
 	.fb_fillrect = cyblafb_fillrect,
 	.fb_copyarea= cyblafb_copyarea,
 	.fb_imageblit = cyblafb_imageblit,
+	.fb_sync = cyblafb_sync,
+	.fb_restore_state = cyblafb_restore_state,
+	.fb_save_state = cyblafb_save_state,
 };
 
 //==========================================================================
@@ -996,15 +1077,15 @@ static int __devinit getstartupmode(stru
 		fi,pxclkdiv,vclkdiv,tmp,i;
 
 	struct modus {
-		int xres; int yres; int vyres; int bpp; int pxclk;
+		int xres; int vxres; int yres; int vyres; int bpp; int pxclk;
 		int left_margin; int right_margin; int upper_margin;
 		int lower_margin; int hsync_len; int vsync_len;
 	}  modedb[5] = {
-		{   0,	  0, 8000, 0, 0,   0,  0,  0, 0,   0,  0},
-		{ 640,	480, 3756, 0, 0, -40, 24, 17, 0, 216,  3},
-		{ 800,	600, 3221, 0, 0,  96, 24, 14, 0, 136, 11},
-		{1024,	768, 2815, 0, 0, 144, 24, 29, 0, 120,  3},
-		{1280, 1024, 2662, 0, 0, 232, 16, 39, 0, 160,  3}
+		{   0, 2048,    0, 4096, 0, 0,   0,  0,  0, 0,   0,  0},
+		{ 640, 2048,  480, 4096, 0, 0, -40, 24, 17, 0, 216,  3},
+		{ 800, 2048,  600, 4096, 0, 0,  96, 24, 14, 0, 136, 11},
+		{1024, 2048,  768, 4096, 0, 0, 144, 24, 29, 0, 120,  3},
+		{1280, 2048, 1024, 4096, 0, 0, 232, 16, 39, 0, 160,  3}
 	};
 
 	outb(0x00,0x3d4); cr00=inb(0x3d5); outb(0x01,0x3d4); cr01=inb(0x3d5);
@@ -1102,7 +1183,10 @@ static int __devinit getstartupmode(stru
 	info->var.left_margin = modedb[i].left_margin;
 	info->var.right_margin = modedb[i].right_margin;
 	info->var.xres = modedb[i].xres;
-	info->var.xres_virtual = modedb[i].xres;
+	if (!(modedb[i].yres == 1280 && modedb[i].bpp == 32))
+		info->var.xres_virtual = modedb[i].vxres;
+	else
+		info->var.xres_virtual = modedb[i].xres;
 	info->var.xoffset = 0;
 	info->var.hsync_len = modedb[i].hsync_len;
 	info->var.upper_margin = modedb[i].upper_margin;
@@ -1160,12 +1244,12 @@ static unsigned int __devinit get_memsiz
 	else {
 		tmp = read3X4(CR1F) & 0x0F;
 		switch (tmp) {
-			case 0x03: k = 1 * Mb; break;
-			case 0x07: k = 2 * Mb; break;
-			case 0x0F: k = 4 * Mb; break;
-			case 0x04: k = 8 * Mb; break;
+			case 0x03: k = 1 * 1024*1024; break;
+			case 0x07: k = 2 * 1024*1024; break;
+			case 0x0F: k = 4 * 1024*1024; break;
+			case 0x04: k = 8 * 1024*1024; break;
 			default:
-				k = 1 * Mb;
+				k = 1 * 1024*1024;
 				output("Unknown memory size code %x in CR1F."
 				       " We default to 1 Mb for now, please"
 				       " do provide a memsize parameter!\n",
@@ -1231,9 +1315,25 @@ static int __devinit cybla_pci_probe(str
 	struct cyblafb_par *par;
 
 	info = framebuffer_alloc(sizeof(struct cyblafb_par),&dev->dev);
-
 	if (!info)
-		goto errout_alloc;
+		goto errout_alloc_info;
+
+	info->pixmap.addr = kmalloc(CYBLAFB_PIXMAPSIZE, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		output("allocation of pixmap buffer failed!\n");
+		goto errout_alloc_pixmap;
+	}
+	memset(info->pixmap.addr, 0, CYBLAFB_PIXMAPSIZE);
+	info->pixmap.size = CYBLAFB_PIXMAPSIZE - 4;
+	info->pixmap.buf_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+	if (scalign != 1 && scalign != 2 && scalign != 4)
+		scalign=4;
+	info->pixmap.scan_align = scalign;
+	if(verbosity > 0)
+		output("Pixmap size = %d, alignement = %d\n",
+			info->pixmap.size, scalign);
 
 	par = info->par;
 	par->ops = cyblafb_ops;
@@ -1249,12 +1349,18 @@ static int __devinit cybla_pci_probe(str
 
 	// might already be requested by vga console or vesafb,
 	// so we do care about success
-	request_region(0x3c0,32,"cyblafb");
+	if (!request_region(0x3c0,0x20,"cyblafb")) {
+		output("region 0x3c0/0x20 already reserved\n");
+		vesafb |= 1;
 
+	}
 	//
 	// Graphics Engine Registers
 	//
-	request_region(GEBase,0x100,"cyblafb");
+	if (!request_region(GEBase,0x100,"cyblafb")) {
+		output("region %#x/0x100 already reserved\n",GEBase);
+		vesafb |= 2;
+	}
 
 	regdump(par);
 
@@ -1279,15 +1385,15 @@ static int __devinit cybla_pci_probe(str
 
 	// setup framebuffer memory ... might already be requested
 	// by vesafb. Not to fail in case of an unsuccessful request
-	// is useful for the development cycle
+	// is useful if both are loaded.
 	info->fix.smem_start = pci_resource_start(dev,0);
 	info->fix.smem_len = get_memsize();
 
 	if (!request_mem_region(info->fix.smem_start,
 				info->fix.smem_len,"cyblafb")) {
-		output("request_mem_region failed for smem region!\n");
-		if (!vesafb)
-			goto errout_smem_req;
+		output("region %#lx/%#x already reserved\n",
+				info->fix.smem_start,info->fix.smem_len);
+		vesafb |= 4;
 	}
 
 	info->screen_base = ioremap_nocache(info->fix.smem_start,
@@ -1303,14 +1409,14 @@ static int __devinit cybla_pci_probe(str
 	if(displaytype == DISPLAY_FP)
 		nativex = get_nativex();
 
-	//
-	// FBINFO_HWACCEL_YWRAP    .... does not work (could be made to work?)
-	// FBINFO_PARTIAL_PAN_OK   .... is not ok
-	// FBINFO_READS_FAST	   .... is necessary for optimal scrolling
-	//
-	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN
-		      | FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT
-		      | FBINFO_HWACCEL_IMAGEBLIT | FBINFO_READS_FAST;
+	info->flags = FBINFO_DEFAULT
+		      | FBINFO_HWACCEL_COPYAREA
+		      | FBINFO_HWACCEL_FILLRECT
+		      | FBINFO_HWACCEL_IMAGEBLIT
+		      | FBINFO_READS_FAST
+//		      | FBINFO_PARTIAL_PAN_OK
+		      | FBINFO_MISC_ALWAYS_SETPAR
+		      ;
 
 	info->pseudo_palette = par->pseudo_pal;
 
@@ -1336,18 +1442,21 @@ static int __devinit cybla_pci_probe(str
  errout_findmode:
 	iounmap(info->screen_base);
  errout_smem_remap:
-	release_mem_region(info->fix.smem_start,
-			   info->fix.smem_len);
- errout_smem_req:
+	if (!(vesafb & 4))
+		release_mem_region(info->fix.smem_start,
+				   info->fix.smem_len);
 	iounmap(io_virt);
  errout_mmio_remap:
 	release_mem_region(info->fix.mmio_start,
 			   info->fix.mmio_len);
  errout_mmio_reqmem:
-//	release_region(0x3c0,32);
+	if (!(vesafb & 1))
+		release_region(0x3c0,32);
  errout_enable:
+	kfree(info->pixmap.addr);
+ errout_alloc_pixmap:
 	framebuffer_release(info);
- errout_alloc:
+ errout_alloc_info:
 	output("CyblaFB version %s aborting init.\n",VERSION);
 	return -ENODEV;
 }
@@ -1359,9 +1468,15 @@ static void __devexit cybla_pci_remove(s
 	unregister_framebuffer(info);
 	iounmap(io_virt);
 	iounmap(info->screen_base);
-	release_mem_region(info->fix.smem_start,info->fix.smem_len);
+	if (!(vesafb & 4))
+		release_mem_region(info->fix.smem_start,info->fix.smem_len);
 	release_mem_region(info->fix.mmio_start,info->fix.mmio_len);
 	fb_dealloc_cmap(&info->cmap);
+	if (!(vesafb & 2))
+		release_region(GEBase,0x100);
+	if (!(vesafb & 1))
+		release_region(0x3c0,32);
+	kfree(info->pixmap.addr);
 	framebuffer_release(info);
 	output("CyblaFB version %s normal exit.\n",VERSION);
 }
@@ -1433,8 +1548,8 @@ static int __devinit cyblafb_init(void)
 				memsize = simple_strtoul(opt+8,NULL,0);
 			else if (!strncmp(opt,"verbosity=",10))
 				verbosity = simple_strtoul(opt+10,NULL,0);
-			else if (!strncmp(opt,"vesafb",6))
-				vesafb = 1;
+			else if (!strncmp(opt,"scalign=",8))
+				verbosity = simple_strtoul(opt+10,NULL,0);
 			else
 				mode = opt;
 		}
diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/include/video/cyblafb.h linux/include/video/cyblafb.h
--- linuxorig/include/video/cyblafb.h	2005-10-28 02:02:08.000000000 +0200
+++ linux/include/video/cyblafb.h	2005-12-13 13:15:21.000000000 +0100
@@ -153,6 +153,10 @@
 #define GE04	(GEBase+0x04)	// source 2, p 111
 #define GE08	(GEBase+0x08)	// destination 1, p 111
 #define GE0C	(GEBase+0x0C)	// destination 2, p 112
+#define GE10	(GEBase+0x10)	// right view base & enable, p 112
+#define GE13	(GEBase+0x13)	// left view base & enable, p 112
+#define GE18	(GEBase+0x18)	// block write start address, p 112
+#define GE1C	(GEBase+0x1C)	// block write end address, p 112
 #define GE20	(GEBase+0x20)	// engine status, p 113
 #define GE24	(GEBase+0x24)	// reset all GE pointers
 #define GE44	(GEBase+0x44)	// command register, p 126


