Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310227AbSCLAXa>; Mon, 11 Mar 2002 19:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310233AbSCLAXZ>; Mon, 11 Mar 2002 19:23:25 -0500
Received: from www.transvirtual.com ([206.14.214.140]:9480 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S310227AbSCLAXJ>; Mon, 11 Mar 2002 19:23:09 -0500
Date: Mon, 11 Mar 2002 16:22:58 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] soft accels.
Message-ID: <Pine.LNX.4.10.10203111620340.32670-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This code provides software accels to replace all the fbcon-cfb* stuff.
Gradually the fbdev drivers can be ported over to it. It is against
2.5.5-dj3. Please apply the patch.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.5.5-dj3/drivers/video/Config.in	Wed Mar  6 10:46:02 2002
+++ linux/drivers/video/Config.in	Mon Mar 11 14:40:53 2002
@@ -259,7 +259,7 @@
       if [ "$CONFIG_FB_ACORN" = "y" -o "$CONFIG_FB_ATARI" = "y" -o \
 	   "$CONFIG_FB_ATY" = "y" -o "$CONFIG_FB_MAC" = "y" -o \
 	   "$CONFIG_FB_OF" = "y" -o "$CONFIG_FB_TGA" = "y" -o \
-	   "$CONFIG_FB_VESA" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
+	   "$CONFIG_FB_PM3" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
 	   "$CONFIG_FB_TCX" = "y" -o "$CONFIG_FB_CGTHREE" = "y" -o \
 	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	   "$CONFIG_FB_CGFOURTEEN" = "y" -o "$CONFIG_FB_G364" = "y" -o \
@@ -267,7 +267,6 @@
 	   "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
            "$CONFIG_FB_IGA" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
 	   "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-           "$CONFIG_FB_PM3" = "y" -o \
 	   "$CONFIG_FB_P9100" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
 	   "$CONFIG_FB_SGIVW" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
@@ -280,7 +279,7 @@
 	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_ATARI" = "m" -o \
 	      "$CONFIG_FB_ATY" = "m" -o "$CONFIG_FB_MAC" = "m" -o \
 	      "$CONFIG_FB_OF" = "m" -o "$CONFIG_FB_TGA" = "m" -o \
-	      "$CONFIG_FB_VESA" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
+	      "$CONFIG_FB_PM3" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
 	      "$CONFIG_FB_TCX" = "m" -o "$CONFIG_FB_CGTHREE" = "m" -o \
 	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	      "$CONFIG_FB_CGFOURTEEN" = "m" -o "$CONFIG_FB_G364" = "m" -o \
@@ -288,7 +287,6 @@
 	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
               "$CONFIG_FB_IGA" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
 	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-              "$CONFIG_FB_PM3" = "m" -o \
 	      "$CONFIG_FB_P9100" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_3DFX" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
@@ -300,7 +298,7 @@
 	 fi
       fi
       if [ "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_ATY" = "y" -o \
-	   "$CONFIG_FB_MAC" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
+	   "$CONFIG_FB_MAC" = "y" -o "$CONFIG_FB_PM3" = "y" -o \
 	   "$CONFIG_FB_VIRTUAL" = "y" -o "$CONFIG_FB_TBOX" = "y" -o \
 	   "$CONFIG_FB_Q40" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
 	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
@@ -308,7 +306,6 @@
 	   "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
 	   "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
 	   "$CONFIG_FB_PM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
-           "$CONFIG_FB_PM3" = "y" -o \
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_3DFX" = "y"  -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_SA1100" = "y" -o \
@@ -317,7 +314,7 @@
 	 define_tristate CONFIG_FBCON_CFB16 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
-	      "$CONFIG_FB_MAC" = "m" -o "$CONFIG_FB_VESA" = "m" -o \
+	      "$CONFIG_FB_MAC" = "m" -o "$CONFIG_FB_PM3" = "m" -o \
 	      "$CONFIG_FB_VIRTUAL" = "m" -o "$CONFIG_FB_TBOX" = "m" -o \
 	      "$CONFIG_FB_Q40" = "m" -o "$CONFIG_FB_3DFX" = "m" -o \
 	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
@@ -325,7 +322,6 @@
 	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
 	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
 	      "$CONFIG_FB_PM2" = "m" -o "$CONFIG_FB_SGIVW" = "m" -o \
-              "$CONFIG_FB_PM3" = "m" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
@@ -352,11 +348,10 @@
 	 fi
       fi
       if [ "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_ATY" = "y" -o \
-	   "$CONFIG_FB_VESA" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
+	   "$CONFIG_FB_PM3" = "y" -o "$CONFIG_FB_VIRTUAL" = "y" -o \
 	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
 	   "$CONFIG_FB_TGA" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
 	   "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-           "$CONFIG_FB_PM3" = "y" -o \
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
@@ -365,11 +360,10 @@
 	 define_tristate CONFIG_FBCON_CFB32 y
       else
 	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_ATY" = "m" -o \
-	      "$CONFIG_FB_VESA" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
+	      "$CONFIG_FB_PM3" = "m" -o "$CONFIG_FB_VIRTUAL" = "m" -o \
 	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
 	      "$CONFIG_FB_TGA" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
 	      "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-              "$CONFIG_FB_PM3" = "m" -o \
 	      "$CONFIG_FB_RIVA" = "m" -o "$CONFIG_FB_ATY128" = "m" -o \
 	      "$CONFIG_FB_3DFX" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_SGIVW" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
@@ -377,10 +371,10 @@
 	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
       fi
-      if [ "$CONFIG_FB_NEOMAGIC" = "y" ]; then
+      if [ "$CONFIG_FB_NEOMAGIC" = "y" -o "$CONFIG_FB_VESA" = "y" ]; then
 	 define_tristate CONFIG_FBCON_ACCEL y
       else
-	 if [ "$CONFIG_FB_NEOMAGIC" = "m" ]; then
+	 if [ "$CONFIG_FB_NEOMAGIC" = "m" -o "$CONFIG_FB_VESA" = "m" ]; then
 	    define_tristate CONFIG_FBCON_ACCEL m
 	 fi
       fi			
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.5-dj3/drivers/video/Makefile	Wed Mar  6 10:46:02 2002
+++ linux/drivers/video/Makefile	Mon Mar 11 14:40:59 2002
@@ -69,7 +69,7 @@
 obj-$(CONFIG_FB_TRIDENT)          += tridentfb.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
 obj-$(CONFIG_FB_TGA)              += tgafb.o
-obj-$(CONFIG_FB_VESA)             += vesafb.o 
+obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_VGA16)            += vga16fb.o fbcon-vga-planes.o
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
 obj-$(CONFIG_FB_G364)             += g364fb.o
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/cfbcopyarea.c linux/drivers/video/cfbcopyarea.c
--- linux-2.5.5-dj3/drivers/video/cfbcopyarea.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/video/cfbcopyarea.c	Mon Mar 11 17:12:37 2002
@@ -0,0 +1,217 @@
+/*
+ *  Generic function for frame buffer with packed pixels of any depth.
+ *
+ *      Copyright (C)  June 1999 James Simmons
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ * NOTES:
+ * 
+ *  This is for cfb packed pixels. Iplan and such are incorporated in the 
+ *  drivers that need them.
+ * 
+ *  FIXME
+ *  The code for 24 bit is horrible. It copies byte by byte size instead of 
+ *  longs like the other sizes. Needs to be optimized. 
+ *
+ *  Also need to add code to deal with cards endians that are different than 
+ *  the native cpu endians. I also need to deal with MSB position in the word.
+ *  
+ */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/slab.h>
+#include <asm/types.h>
+#include <asm/io.h>
+#include <video/fbcon.h>
+
+void cfb_copyarea(struct fb_info *p, struct fb_copyarea *area) 
+{
+	unsigned long start_index, end_index, start_mask, end_mask, last, tmp, height;
+	int x2, y2, n, j, lineincr, shift, shift_right, shift_left, old_dx, old_dy;
+	int linesize = p->fix.line_length, bpl = sizeof(unsigned long);
+	unsigned long *dst = NULL, *src = NULL;
+	char *src1,*dst1;
+ 
+	/* clip the destination */
+	old_dx = area->dx;
+	old_dy = area->dy;
+  
+	/*
+	 * We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly.
+	 */
+	x2 = area->dx + area->width;
+	y2 = area->dy + area->height;
+	area->dx = area->dx > 0 ? area->dx : 0;
+	area->dy = area->dy > 0 ? area->dy : 0;
+	x2 = x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
+	y2 = y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
+	area->width = x2 - area->dx;
+	area->height = y2 - area->dy;
+  
+	/* update sx1,sy1 */
+	area->sx += (area->dx - old_dx);
+	area->sy += (area->dy - old_dy);
+  
+	height = area->height;
+
+	/* the source must be completely inside the virtual screen */
+	if (area->sx < 0 || area->sy < 0 ||
+	   (area->sx + area->width)  > p->var.xres_virtual ||
+	   (area->sy + area->height) > p->var.yres_virtual)
+		return;
+  
+	if (area->dy < area->sy || (area->dy == area->sy && area->dx < area->sx)) {
+		/* start at the top */
+		src1 = p->screen_base + area->sy * linesize + 
+			((area->sx * p->var.bits_per_pixel) >> 3);
+		dst1 = p->screen_base + area->dy * linesize +
+			((area->dx * p->var.bits_per_pixel) >> 3);
+		lineincr = linesize;
+	} else {
+		/* start at the bottom */
+		src1 = p->screen_base + (area->sy + area->height-1)*linesize + 
+			(((area->sx + area->width - 1) * p->var.bits_per_pixel) >> 3); 
+		dst1 = p->screen_base + (area->dy + area->height-1)*linesize + 
+			(((area->dx + area->width - 1) * p->var.bits_per_pixel) >> 3); 
+		lineincr = -linesize;
+	}
+    
+	if ((BITS_PER_LONG % p->var.bits_per_pixel) == 0) {
+		int ppw = BITS_PER_LONG/p->var.bits_per_pixel;
+		int n = ((area->width * p->var.bits_per_pixel) >> 3);   
+
+		start_index = ((unsigned long) src1 & (bpl-1));
+		end_index = ((unsigned long) (src1 + n) & (bpl-1));
+		shift = ((unsigned long)dst1 & (bpl-1)) - ((unsigned long) src1 & (bpl-1));
+		start_mask = end_mask = 0;
+   
+		if (start_index) { 
+			start_mask = -1 >> (start_index << 3);
+			n -= (bpl - start_index);
+		}
+	
+		if (end_index) {
+			end_mask = -1 << ((bpl - end_index) << 3);
+			n -= end_index;
+		}   
+		n = n/bpl;
+
+		if (n <= 0) {
+			if (start_mask) {
+				if (end_mask)
+					end_mask &= start_mask;
+				else
+					end_mask = start_mask;
+				start_mask = 0;
+			}
+			n = 0;
+		}
+
+		if (shift) {
+			if (shift > 0) {
+				/* dest is over to right more */
+				shift_right = shift * p->var.bits_per_pixel;
+				shift_left = (ppw - shift) * p->var.bits_per_pixel;
+			} else {
+				/* source is to the right more */
+				shift_right = (ppw + shift) * p->var.bits_per_pixel;
+				shift_left = -shift * p->var.bits_per_pixel;
+			}
+			/* general case, positive increment */
+			if (lineincr > 0) {
+				if (shift < 0)
+					n++;
+				do {
+					dst = (unsigned long *) dst1;
+					src = (unsigned long *) src1;
+
+					last = (fb_readl(src) & start_mask);
+
+					if (shift > 0)
+						fb_writel(fb_readl(dst) | (last >> shift_right), dst);
+					for (j = 0; j < n; j++) {
+						dst++;
+						tmp = fb_readl(src);
+						src++;
+						fb_writel((last << shift_left) | 
+							 (tmp >> shift_right),dst);
+						last = tmp;
+						src++;
+					}
+					fb_writel(fb_readl(dst) | (last << shift_left), dst);
+					src1 += lineincr;
+					dst1 += lineincr;
+				} while (--height);
+			} else {
+				/* general case, negative increment */
+				if (shift > 0)
+					n++;
+				do {
+					dst = (unsigned long *) dst1;
+					src = (unsigned long *) src1;
+
+					last = (fb_readl(src) & end_mask);
+
+					if (shift < 0)
+						fb_writel(fb_readl(dst) | (last >> shift_right), dst);
+					for (j = 0; j < n; j++) {
+						dst--;
+						tmp = fb_readl(src);
+						src--;
+						fb_writel((tmp << shift_left) | 
+							 (last >> shift_right),dst);
+						last = tmp;
+						src--;
+					}
+					fb_writel(fb_readl(dst) | (last >> shift_right), dst);
+					src1 += lineincr;
+					dst1 += lineincr;
+				} while (--height);
+			}
+		} else {
+			/* no shift needed */
+			if (lineincr > 0) {
+				/* positive increment */	
+				do {
+					dst = (unsigned long *) (dst1 - start_index);
+					src = (unsigned long *) (src1 - start_index);
+   		
+					if (start_mask)	
+						fb_writel(fb_readl(src) | start_mask, dst);
+    			
+					for (j = 0; j < n; j++) { 
+						fb_writel(fb_readl(src), dst); 
+						dst++;
+						src++;
+					}
+    				
+					if (end_mask)
+						fb_writel(fb_readl(src) | end_mask,dst);
+						src1 += lineincr;
+						dst1 += lineincr;
+				} while (--height);
+			} else {
+				/* negative increment */
+				do {
+					dst = (unsigned long *) dst1;
+					src = (unsigned long *) src1;
+
+					if (start_mask)
+						fb_writel(fb_readl(src) | start_mask, dst);
+					for (j = 0; j < n; j++) { 
+						fb_writel(fb_readl(src), dst); 
+						dst--;
+						src--;
+					}
+					src1 += lineincr;
+					dst1 += lineincr;
+				} while (--height);
+			}
+		}
+	}
+}
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/cfbfillrect.c linux/drivers/video/cfbfillrect.c
--- linux-2.5.5-dj3/drivers/video/cfbfillrect.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/video/cfbfillrect.c	Mon Mar 11 15:09:43 2002
@@ -0,0 +1,189 @@
+/*
+ *  Generic fillrect for frame buffers with packed pixels of any depth. 
+ *
+ *      Copyright (C)  2000 James Simmons (jsimmons@linux-fbdev.org) 
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ * NOTES:
+ *
+ *  The code for depths like 24 that don't have integer number of pixels per 
+ *  long is broken and needs to be fixed. For now I turned these types of 
+ *  mode off.
+ *
+ *  Also need to add code to deal with cards endians that are different than
+ *  the native cpu endians. I also need to deal with MSB position in the word.
+ *
+ */
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <asm/types.h>
+#include <video/fbcon.h>
+
+void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect)  
+{
+	unsigned long start_index, end_index, start_mask = 0, end_mask = 0;
+	unsigned long height, ppw, fg, fgcolor;
+	int i, n, x2, y2, linesize = p->fix.line_length;
+	int bpl = sizeof(unsigned long);	
+	unsigned long *dst;
+	char *dst1;	
+
+	if (!rect->width || !rect->height) return;	
+ 
+	/* We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly. */
+	x2 = rect->dx + rect->width;
+	y2 = rect->dy + rect->height;
+	x2 = x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
+	y2 = y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
+	rect->width = x2 - rect->dx;
+	height = y2 - rect->dy;
+
+	/* Size of the scanline in bytes */ 	
+	n = ((rect->width * p->var.bits_per_pixel) >> 3);	
+	ppw = BITS_PER_LONG/p->var.bits_per_pixel;
+
+	dst1 = p->screen_base + rect->dy * linesize + ((rect->dx * p->var.bits_per_pixel) >> 3); 
+	start_index = ((unsigned long) dst1 & (bpl-1));
+	end_index = ((unsigned long)(dst1 + n) & (bpl-1));	
+
+	if (p->fix.visual == FB_VISUAL_TRUECOLOR) 
+		fg = fgcolor = ((u32 *)(p->pseudo_palette))[rect->color];
+	else		
+		fg = fgcolor = rect->color;
+  
+	for (i = 0; i < ppw-1; i++) {
+		fg <<= p->var.bits_per_pixel;
+		fg |= fgcolor;	
+	}
+
+	if (start_index) {
+		start_mask = fg << (start_index << 3);
+		n -= (bpl - start_index);
+	}
+  
+	if (end_index) {
+		end_mask = fg >> ((bpl - end_index) << 3);
+		n -= end_index;
+	}
+
+	n = n/bpl;
+
+	if (n <= 0) {
+		if (start_mask) {
+			if (end_mask) 
+				end_mask &= start_mask;
+			else 
+				end_mask = start_mask;
+			start_mask = 0;
+		}
+		n = 0;	
+	}
+
+	if ((BITS_PER_LONG % p->var.bits_per_pixel) == 0) {
+		switch (rect->rop) {
+		case ROP_COPY:        
+			do {
+				/* Word align to increases performace :-) */
+				dst = (unsigned long *) (dst1 - start_index);
+	
+				if (start_mask) {
+#if BITS_PER_LONG == 32
+					fb_writel(fb_readl(dst) | start_mask, dst);
+#else
+					fb_writeq(fb_readq(dst) | start_mask, dst);
+#endif
+					dst++;
+				}
+  	
+				for ( i=0; i < n; i++) {
+#if BITS_PER_LONG == 32
+					fb_writel(fg, dst);
+#else
+					fb_writeq(fg, dst);
+#endif
+					dst++;			
+				}
+
+				if (end_mask)
+#if BITS_PER_LONG == 32
+					fb_writel(fb_readl(dst) | end_mask, dst);
+#else
+					fb_writeq(fb_readq(dst) | end_mask, dst);
+#endif
+					dst1+=linesize;
+				} while (--height);
+				break;
+		case ROP_XOR:
+			do {
+				dst = (unsigned long *) (dst1 - start_index);
+#if BITS_PER_LONG == 32
+				fb_writel(fb_readl(dst) ^ start_mask, dst);
+#else
+				fb_writeq(fb_readq(dst) ^ start_mask, dst);
+#endif
+				for( i=0; i < n; i++) {
+					dst++;
+#if BITS_PER_LONG == 32
+					fb_writel(fb_readl(dst) ^ fg, dst); 
+#else
+					fb_writeq(fb_readq(dst) ^ fg, dst); 
+#endif
+				}
+	
+				if (end_mask) {
+					dst++;
+#if BITS_PER_LONG == 32
+					fb_writel(fb_readl(dst) ^ end_mask, dst);
+#else
+					fb_writeq(fb_readq(dst) ^ end_mask, dst);
+#endif
+				}
+				dst1+=linesize;
+			} while (--height);
+			break;
+		}
+	} else {
+		/* Odd modes like 24 or 80 bits per pixel */
+		start_mask = fg >> (start_index * p->var.bits_per_pixel);
+		end_mask = fg << (end_index * p->var.bits_per_pixel);
+		/* start_mask =& PFILL24(x1,fg);
+		   end_mask_or = end_mask & PFILL24(x1+width-1,fg); */
+    
+		n = (rect->width - start_index - end_index)/ppw;
+    
+		switch (rect->rop) {
+		case ROP_COPY:        
+			do {
+				dst = (unsigned long *)dst1;
+				if (start_mask) *dst |= start_mask;
+				if ((start_index + rect->width) > ppw) dst++;	
+
+				/* XXX: slow */
+				for (i = 0;i < n; i++) {
+					*dst++ = fg;
+				}
+				if (end_mask) *dst |= end_mask;	
+					dst1+=linesize;
+			} while (--height);
+			break;
+		case ROP_XOR:
+			do {
+				dst = (unsigned long *)dst1;
+				if (start_mask) *dst ^= start_mask;
+				if ((start_mask + rect->width) > ppw) dst++;	
+	
+				for( i = 0; i < n; i++) {
+					*dst++ ^= fg; /* PFILL24(fg,x1+i); */
+				}
+				if (end_mask) *dst ^= end_mask;
+				dst1+=linesize;
+			} while (--height);
+			break;
+		}  
+	}
+	return;	
+}
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.5-dj3/drivers/video/cfbimgblt.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/video/cfbimgblt.c	Mon Mar 11 14:29:37 2002
@@ -0,0 +1,107 @@
+/*
+ *  Generic BitBLT function for frame buffer with packed pixels of any depth.
+ *
+ *      Copyright (C)  June 1999 James Simmons
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ * NOTES:
+ *
+ *    This function copys a image from system memory to video memory. The
+ *  image can be a bitmap where each 0 represents the background color and
+ *  each 1 represents the foreground color. Great for font handling. It can
+ *  also be a color image. This is determined by image_depth. The color image
+ *  must be laid out exactly in the same format as the framebuffer. Yes I know
+ *  their are cards with hardware that coverts images of various depths to the
+ *  framebuffer depth. But not every card has this. All images must be rounded
+ *  up to the nearest byte. For example a bitmap 12 bits wide must be two 
+ *  bytes width. 
+ *
+ *  FIXME
+ *  The code for 24 bit is horrible. It copies byte by byte size instead of
+ *  longs like the other sizes. Needs to be optimized.
+ *
+ *  Also need to add code to deal with cards endians that are different than
+ *  the native cpu endians. I also need to deal with MSB position in the word.
+ *
+ */
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <asm/types.h>
+
+#include <video/fbcon.h>
+
+#define DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt,__FUNCTION__,## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+void cfb_imageblit(struct fb_info *p, struct fb_image *image)
+{
+	int ppw, shift, shift_right, shift_left, x2, y2, n, i, j, k, l = 7;
+	unsigned long tmp = ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
+	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;	
+	unsigned long end_index, end_mask, mask;
+	unsigned long *dst = NULL;
+	u8 *dst1, *src;
+  
+	/* 
+	 * We could use hardware clipping but on many cards you get around hardware
+	 * clipping by writing to framebuffer directly like we are doing here. 
+	 */
+	x2 = image->dx + image->width;
+	y2 = image->dy + image->height;
+	image->dx = image->dx > 0 ? image->dx : 0;
+	image->dy = image->dy > 0 ? image->dy : 0;
+	x2 = x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
+	y2 = y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
+	image->width  = x2 - image->dx;
+	image->height = y2 - image->dy;
+  
+	dst1 = p->screen_base + image->dy * p->fix.line_length + 
+		((image->dx * p->var.bits_per_pixel) >> 3);
+  
+	ppw = BITS_PER_LONG/p->var.bits_per_pixel;
+
+	src = image->data;	
+
+	if (p->fix.visual == FB_VISUAL_TRUECOLOR) {
+		fgx = fgcolor = ((u32 *)(p->pseudo_palette))[image->fg_color];
+		bgx = bgcolor = ((u32 *)(p->pseudo_palette))[image->bg_color];
+	} else {
+		fgx = fgcolor = image->fg_color;
+		bgx = bgcolor = image->bg_color;
+	}	
+ 
+	for (i = 0; i < ppw-1; i++) {
+		fgx <<= p->var.bits_per_pixel;
+		bgx <<= p->var.bits_per_pixel;
+		fgx |= fgcolor;
+		bgx |= bgcolor;
+	}
+	eorx = fgx ^ bgx;
+	l = 7; 
+
+	for (i = 0; i < image->height; i++) {
+		dst = (unsigned long *) dst1;
+		
+		for (j = image->width/ppw; j > 0; j--) {
+			mask = 0;
+		
+			for (k = ppw; k > 0; k--) {	
+				if (test_bit(l, src))
+					mask |= (tmp >> (p->var.bits_per_pixel*(k-1)));
+				l--;
+				if (l < 0) { l = 7; src++; }
+			}
+			fb_writel((mask & eorx)^bgx, dst);
+			dst++;
+		}
+		dst1 += p->fix.line_length;	
+	}	
+}
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux-2.5.5-dj3/drivers/video/fbgen.c	Wed Mar  6 10:46:03 2002
+++ linux/drivers/video/fbgen.c	Mon Mar 11 14:38:54 2002
@@ -444,63 +444,19 @@
 	if (con < 0 || info->var.activate & FB_ACTIVATE_ALL)
 		info->disp->var = info->var;	
 
-	if (!info->var.accel_flags) {
+	if (info->var.bits_per_pixel == 24) {
+#ifdef FBCON_HAS_CFB24
 		display->scrollmode = SCROLL_YREDRAW;		
-#ifdef FBCON_HAS_ACCEL
-	} else {
-		display->scrollmode = SCROLL_YNOMOVE;
-		display->dispsw = &fbcon_accel;
+		display->dispsw = &fbcon_cfb24;
 		return;
 #endif
 	}
 
-	switch (info->var.bits_per_pixel)
-	{
-#ifdef FBCON_HAS_MFB
-		case 1:
-			display->dispsw = &fbcon_mfb;
-			break;
-#endif
-
-#ifdef FBCON_HAS_CFB2
-		case 2:
-			display->dispsw = &fbcon_cfb2;
-			break;
-#endif
-
-#ifdef FBCON_HAS_CFB4
-		case 4:
-			display->dispsw = &fbcon_cfb4;
-			break;
-#endif
-
-#ifdef FBCON_HAS_CFB8
-		case 8:
-			display->dispsw = &fbcon_cfb8;
-			break;
-#endif
-
-#ifdef FBCON_HAS_CFB16
-		case 16:
-			display->dispsw = &fbcon_cfb16;
-			break;
-#endif
-
-#ifdef FBCON_HAS_CFB24
-		case 24:
-			display->dispsw = &fbcon_cfb24;
-			break;
-#endif
-
-#ifdef FBCON_HAS_CFB32
-		case 32:
-			display->dispsw = &fbcon_cfb32;
-			break;
+#ifdef FBCON_HAS_ACCEL
+	display->scrollmode = SCROLL_YNOMOVE;
+	display->dispsw = &fbcon_accel;
 #endif
-		default:
-			display->dispsw = &fbcon_dummy;
-			break;
-	} 
+	return;
 }
 
 /**
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.5-dj3/drivers/video/riva/fbdev.c	Wed Mar  6 10:46:03 2002
+++ linux/drivers/video/riva/fbdev.c	Wed Mar  6 10:46:50 2002
@@ -34,7 +34,6 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/selection.h>
 #include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.5-dj3/drivers/video/vesafb.c	Wed Mar  6 10:46:04 2002
+++ linux/drivers/video/vesafb.c	Mon Mar 11 14:53:23 2002
@@ -36,7 +36,6 @@
 	activate:	FB_ACTIVATE_NOW,
 	height:		-1,
 	width:		-1,
-//	accel_flags:	FB_ACCELF_TEXT,
 	vmode:		FB_VMODE_NONINTERLACED,
 };
 
@@ -136,13 +135,13 @@
 	case 16:
 		if (info->var.red.offset == 10) {
 			/* 1:5:5:5 */
-			((u16*) (info->pseudo_palette))[regno] =	
+			((u32*) (info->pseudo_palette))[regno] =	
 					((red   & 0xf800) >>  1) |
 					((green & 0xf800) >>  6) |
 					((blue  & 0xf800) >> 11);
 		} else {
 			/* 0:5:6:5 */
-			((u16*) (info->pseudo_palette))[regno] =	
+			((u32*) (info->pseudo_palette))[regno] =	
 					((red   & 0xf800)      ) |
 					((green & 0xfc00) >>  5) |
 					((blue  & 0xf800) >> 11);
@@ -179,9 +178,9 @@
 	fb_set_cmap:	gen_set_cmap,
 	fb_setcolreg:	vesafb_setcolreg,
 	fb_pan_display:	vesafb_pan_display,
-//	fb_fillrect:	cfb_fillrect,
-//	fb_copyarea:	cfb_copyarea,
-//	fb_imageblit:	cfb_imageblit,
+	fb_fillrect:	cfb_fillrect,
+	fb_copyarea:	cfb_copyarea,
+	fb_imageblit:	cfb_imageblit,
 };
 
 int __init vesafb_setup(char *options)

