Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSAFWbA>; Sun, 6 Jan 2002 17:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSAFWap>; Sun, 6 Jan 2002 17:30:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49668 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288834AbSAFWa2>;
	Sun, 6 Jan 2002 17:30:28 -0500
Message-ID: <3C38CFFA.18D230B9@mandrakesoft.com>
Date: Sun, 06 Jan 2002 17:30:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev-devel@lists.sourceforge.net,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: PATCH 2.5.2.9: fbdev kdev_t build fixes
In-Reply-To: <Pine.LNX.4.05.10107021127040.23703-100000@callisto.of.borg>
Content-Type: multipart/mixed;
 boundary="------------C899353128B399CA0488BD7B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C899353128B399CA0488BD7B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch fixes the build for the rest of fbdev in 2.5.2-pre9...
-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
--------------C899353128B399CA0488BD7B
Content-Type: text/plain; charset=us-ascii;
 name="fbdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fbdev.patch"

diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/include/linux/fb.h linux_2_5/include/linux/fb.h
--- /spare/tmp/linux-2.5.2-pre9/include/linux/fb.h	Mon Dec 11 21:16:53 2000
+++ linux_2_5/include/linux/fb.h	Sun Jan  6 22:20:52 2002
@@ -246,7 +246,7 @@
 #if 1 /* to go away in 2.5.0 */
 extern int GET_FB_IDX(kdev_t rdev);
 #else
-#define GET_FB_IDX(node)	(MINOR(node))
+#define GET_FB_IDX(node)	(minor(node))
 #endif
 
 #include <linux/fs.h>
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/S3triofb.c linux_2_5/drivers/video/S3triofb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/S3triofb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/S3triofb.c	Sun Jan  6 22:17:48 2002
@@ -554,7 +554,7 @@
 
     strcpy(fb_info.modename, "Trio64 ");
     strncat(fb_info.modename, dp->full_name, sizeof(fb_info.modename));
-    fb_info.node = -1;
+    fb_info.node = NODEV;
     fb_info.fbops = &s3trio_ops;
 #if 0
     fb_info.fbvar_num = 1;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/acornfb.c linux_2_5/drivers/video/acornfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/acornfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/acornfb.c	Sun Jan  6 22:12:47 2002
@@ -1318,7 +1318,7 @@
 	strcpy(fb_info.modename, "Acorn");
 	strcpy(fb_info.fontname, "Acorn8x8");
 
-	fb_info.node		   = -1;
+	fb_info.node		   = NODEV;
 	fb_info.fbops		   = &acornfb_ops;
 	fb_info.disp		   = &global_disp;
 	fb_info.changevar	   = NULL;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/amifb.c linux_2_5/drivers/video/amifb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/amifb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/amifb.c	Sun Jan  6 22:13:01 2002
@@ -1730,7 +1730,7 @@
 
 	strcpy(fb_info.modename, amifb_name);
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &amifb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &amifbcon_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/atafb.c linux_2_5/drivers/video/atafb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/atafb.c	Thu Oct 25 07:02:26 2001
+++ linux_2_5/drivers/video/atafb.c	Sun Jan  6 22:13:13 2002
@@ -2828,7 +2828,7 @@
 
 	strcpy(fb_info.modename, "Atari Builtin ");
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &atafb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &atafb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/aty/atyfb_base.c linux_2_5/drivers/video/aty/atyfb_base.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/aty/atyfb_base.c	Thu Jan  3 22:20:05 2002
+++ linux_2_5/drivers/video/aty/atyfb_base.c	Sun Jan  6 22:24:02 2002
@@ -1986,7 +1986,7 @@
     disp = &info->disp;
 
     strcpy(info->fb_info.modename, atyfb_name);
-    info->fb_info.node = -1;
+    info->fb_info.node = NODEV;
     info->fb_info.fbops = &atyfb_ops;
     info->fb_info.disp = disp;
     strcpy(info->fb_info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/aty128fb.c linux_2_5/drivers/video/aty128fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/aty128fb.c	Sun Nov 11 18:09:37 2001
+++ linux_2_5/drivers/video/aty128fb.c	Sun Jan  6 22:13:24 2002
@@ -1704,7 +1704,7 @@
 
     /* fill in info */
     strcpy(info->fb_info.modename, aty128fb_name);
-    info->fb_info.node  = -1;
+    info->fb_info.node  = NODEV;
     info->fb_info.fbops = &aty128fb_ops;
     info->fb_info.disp  = &info->disp;
     strcpy(info->fb_info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/chipsfb.c linux_2_5/drivers/video/chipsfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/chipsfb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/chipsfb.c	Sun Jan  6 22:13:47 2002
@@ -578,7 +578,7 @@
 	p->disp.scrollmode = SCROLL_YREDRAW;
 
 	strcpy(p->info.modename, p->fix.id);
-	p->info.node = -1;
+	p->info.node = NODEV;
 	p->info.fbops = &chipsfb_ops;
 	p->info.disp = &p->disp;
 	p->info.fontname[0] = 0;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/clgenfb.c linux_2_5/drivers/video/clgenfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/clgenfb.c	Mon Nov 19 23:19:42 2001
+++ linux_2_5/drivers/video/clgenfb.c	Sun Jan  6 22:13:53 2002
@@ -2758,7 +2778,7 @@
 		 sizeof (fb_info->gen.info.modename));
 	fb_info->gen.info.modename [sizeof (fb_info->gen.info.modename) - 1] = 0;
 
-	fb_info->gen.info.node = -1;
+	fb_info->gen.info.node = NODEV;
 	fb_info->gen.info.fbops = &clgenfb_ops;
 	fb_info->gen.info.disp = &disp;
 	fb_info->gen.info.changevar = NULL;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/controlfb.c linux_2_5/drivers/video/controlfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/controlfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/controlfb.c	Sun Jan  6 22:14:14 2002
@@ -1376,7 +1376,7 @@
 static void __init control_init_info(struct fb_info *info, struct fb_info_control *p)
 {
 	strcpy(info->modename, "control");
-	info->node = -1;	/* ??? danj */
+	info->node = NODEV;
 	info->fbops = &controlfb_ops;
 	info->disp = &p->display;
 	strcpy(info->fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/cyberfb.c linux_2_5/drivers/video/cyberfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/cyberfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/cyberfb.c	Sun Jan  6 22:14:28 2002
@@ -1085,7 +1085,7 @@
 
 	    strcpy(fb_info.modename, cyberfb_name);
 	    fb_info.changevar = NULL;
-	    fb_info.node = -1;
+	    fb_info.node = NODEV;
 	    fb_info.fbops = &cyberfb_ops;
 	    fb_info.disp = &disp;
 	    fb_info.switch_con = &Cyberfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/dn_cfb4.c linux_2_5/drivers/video/dn_cfb4.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/dn_cfb4.c	Thu Jan  3 22:20:05 2002
+++ linux_2_5/drivers/video/dn_cfb4.c	Sun Jan  6 22:14:33 2002
@@ -305,7 +305,7 @@
 	fb_info.switch_con=&dnfbcon_switch;
 	fb_info.updatevar=&dnfbcon_updatevar;
 	fb_info.blank=&dnfbcon_blank;	
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &dn_fb_ops;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;	
 
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/dn_cfb8.c linux_2_5/drivers/video/dn_cfb8.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/dn_cfb8.c	Thu Jan  3 22:20:05 2002
+++ linux_2_5/drivers/video/dn_cfb8.c	Sun Jan  6 22:14:37 2002
@@ -292,7 +292,7 @@
 	fb_info.switch_con=&dnfbcon_switch;
 	fb_info.updatevar=&dnfbcon_updatevar;
 	fb_info.blank=&dnfbcon_blank;	
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &dn_fb_ops;
 	
 printk("dn_fb_init: register\n");
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/dnfb.c linux_2_5/drivers/video/dnfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/dnfb.c	Thu Jan  3 22:20:05 2002
+++ linux_2_5/drivers/video/dnfb.c	Sun Jan  6 22:14:41 2002
@@ -307,7 +307,7 @@
 	fb_info.switch_con=&dnfbcon_switch;
 	fb_info.updatevar=&dnfbcon_updatevar;
 	fb_info.blank=&dnfbcon_blank;	
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &dn_fb_ops;
 	
         dn_fb_get_var(&disp[0].var,0, &fb_info);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/epson1355fb.c linux_2_5/drivers/video/epson1355fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/epson1355fb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/epson1355fb.c	Sun Jan  6 22:14:53 2002
@@ -500,7 +500,7 @@
 	fb_info.gen.fbhw->detect();
 	strcpy(fb_info.gen.info.modename, "SED1355");
 	fb_info.gen.info.changevar = NULL;
-	fb_info.gen.info.node = -1;
+	fb_info.gen.info.node = NODEV;
 	fb_info.gen.info.fbops = &e1355fb_ops;
 	fb_info.gen.info.disp = &disp;
 	fb_info.gen.parsize = sizeof(struct e1355_par);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/fm2fb.c linux_2_5/drivers/video/fm2fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/fm2fb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/fm2fb.c	Sun Jan  6 22:15:59 2002
@@ -401,7 +401,7 @@
 	disp.scrollmode = SCROLL_YREDRAW;
 
 	strcpy(fb_info.modename, fb_fix.id);
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &fm2fb_ops;
 	fb_info.disp = &disp;
 	fb_info.fontname[0] = '\0';
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/hgafb.c linux_2_5/drivers/video/hgafb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/hgafb.c	Mon Nov 12 17:46:25 2001
+++ linux_2_5/drivers/video/hgafb.c	Sun Jan  6 22:16:16 2002
@@ -742,7 +742,7 @@
 	disp.scrollmode = SCROLL_YREDRAW;
 	
 	strcpy (fb_info.modename, hga_fix.id);
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
 /*	fb_info.open = ??? */
 	fb_info.var = hga_default_var;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/hitfb.c linux_2_5/drivers/video/hitfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/hitfb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/hitfb.c	Sun Jan  6 22:16:22 2002
@@ -344,7 +344,7 @@
 int __init hitfb_init(void)
 {
     strcpy(fb_info.gen.info.modename, "Hitachi HD64461");
-    fb_info.gen.info.node = -1;
+    fb_info.gen.info.node = NODEV;
     fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
     fb_info.gen.info.fbops = &hitfb_ops;
     fb_info.gen.info.disp = &fb_info.disp;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/hpfb.c linux_2_5/drivers/video/hpfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/hpfb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/hpfb.c	Sun Jan  6 22:16:27 2002
@@ -328,7 +328,7 @@
 	 */
 	strcpy(fb_info.modename, "Topcat");
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &hpfb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &hpfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/igafb.c linux_2_5/drivers/video/igafb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/igafb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/igafb.c	Sun Jan  6 22:16:35 2002
@@ -568,7 +568,7 @@
 	}
 
 	strcpy(info->fb_info.modename, igafb_name);
-	info->fb_info.node = -1;
+	info->fb_info.node = NODEV;
 	info->fb_info.fbops = &igafb_ops;
 	info->fb_info.disp = &info->disp;
 	strcpy(info->fb_info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/imsttfb.c linux_2_5/drivers/video/imsttfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/imsttfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/imsttfb.c	Sun Jan  6 22:16:40 2002
@@ -1866,7 +1866,7 @@
 
 	strcpy(p->info.modename, p->fix.id);
 	strcpy(p->info.fontname, fontname);
-	p->info.node = -1;
+	p->info.node = NODEV;
 	p->info.fbops = &imsttfb_ops;
 	p->info.disp = &p->disp;
 	p->info.changevar = 0;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/macfb.c linux_2_5/drivers/video/macfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/macfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/macfb.c	Sun Jan  6 22:16:44 2002
@@ -1221,7 +1221,7 @@
 		}
 	
 	fb_info.changevar  = NULL;
-	fb_info.node       = -1;
+	fb_info.node       = NODEV;
 	fb_info.fbops      = &macfb_ops;
 	fb_info.disp       = &disp;
 	fb_info.switch_con = &macfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/matrox/matroxfb_base.c linux_2_5/drivers/video/matrox/matroxfb_base.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/matrox/matroxfb_base.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/matrox/matroxfb_base.c	Sun Jan  6 22:19:00 2002
@@ -1789,7 +1789,7 @@
 
 	strcpy(ACCESS_FBINFO(fbcon.modename), "MATROX VGA");
 	ACCESS_FBINFO(fbcon.changevar) = NULL;
-	ACCESS_FBINFO(fbcon.node) = -1;
+	ACCESS_FBINFO(fbcon.node) = NODEV;
 	ACCESS_FBINFO(fbcon.fbops) = &matroxfb_ops;
 	ACCESS_FBINFO(fbcon.disp) = d;
 	ACCESS_FBINFO(fbcon.switch_con) = &matroxfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/maxinefb.c linux_2_5/drivers/video/maxinefb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/maxinefb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/maxinefb.c	Sun Jan  6 22:16:52 2002
@@ -358,7 +358,7 @@
 	strcpy(fb_info.modename, "Maxine onboard graphics 1024x768x8");
 	/* fb_info.modename: maximum of 39 characters + trailing nullbyte, KM */
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &maxinefb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &maxinefb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/offb.c linux_2_5/drivers/video/offb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/offb.c	Tue Oct  2 16:10:31 2001
+++ linux_2_5/drivers/video/offb.c	Sun Jan  6 22:17:08 2002
@@ -566,7 +566,7 @@
 
     strcpy(info->info.modename, "OFfb ");
     strncat(info->info.modename, full_name, sizeof(info->info.modename));
-    info->info.node = -1;
+    info->info.node = NODEV;
     info->info.fbops = &offb_ops;
     info->info.disp = disp;
     info->info.fontname[0] = '\0';
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/platinumfb.c linux_2_5/drivers/video/platinumfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/platinumfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/platinumfb.c	Sun Jan  6 22:17:13 2002
@@ -591,7 +591,7 @@
 	disp = &info->disp;
 
 	strcpy(info->fb_info.modename, "platinum");
-	info->fb_info.node = -1;
+	info->fb_info.node = NODEV;
 	info->fb_info.fbops = &platinumfb_ops;
 	info->fb_info.disp = disp;
 	strcpy(info->fb_info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/pmag-ba-fb.c linux_2_5/drivers/video/pmag-ba-fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/pmag-ba-fb.c	Fri Sep 14 21:04:07 2001
+++ linux_2_5/drivers/video/pmag-ba-fb.c	Sun Jan  6 22:17:25 2002
@@ -386,7 +386,7 @@
 	 */
 	strcpy(ip->info.modename, "PMAG-BA");
 	ip->info.changevar = NULL;
-	ip->info.node = -1;
+	ip->info.node = NODEV;
 	ip->info.fbops = &pmagbafb_ops;
 	ip->info.disp = &disp;
 	ip->info.switch_con = &pmagbafb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/pmagb-b-fb.c linux_2_5/drivers/video/pmagb-b-fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/pmagb-b-fb.c	Fri Sep 14 21:04:07 2001
+++ linux_2_5/drivers/video/pmagb-b-fb.c	Sun Jan  6 22:17:28 2002
@@ -389,7 +389,7 @@
 	 */
 	strcpy(ip->info.modename, "PMAGB-BA");
 	ip->info.changevar = NULL;
-	ip->info.node = -1;
+	ip->info.node = NODEV;
 	ip->info.fbops = &pmagbbfb_ops;
 	ip->info.disp = &disp;
 	ip->info.switch_con = &pmagbbfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/pvr2fb.c linux_2_5/drivers/video/pvr2fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/pvr2fb.c	Mon Oct 15 20:36:48 2001
+++ linux_2_5/drivers/video/pvr2fb.c	Sun Jan  6 22:17:37 2002
@@ -1034,7 +1034,7 @@
 	
 	strcpy(fb_info.modename, pvr2fb_name);
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &pvr2fb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &pvr2fbcon_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/q40fb.c linux_2_5/drivers/video/q40fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/q40fb.c	Thu Jan  3 22:20:05 2002
+++ linux_2_5/drivers/video/q40fb.c	Sun Jan  6 22:17:40 2002
@@ -331,7 +331,7 @@
 	fb_info.switch_con=&q40con_switch;
 	fb_info.updatevar=&q40con_updatevar;
 	fb_info.blank=&q40con_blank;	
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &q40fb_ops;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
 	
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/radeonfb.c linux_2_5/drivers/video/radeonfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/radeonfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/radeonfb.c	Sun Jan  6 22:17:42 2002
@@ -1305,7 +1305,7 @@
 	info = &rinfo->info;
 
 	strcpy (info->modename, rinfo->name);
-        info->node = -1;
+        info->node = NODEV;
         info->flags = FBINFO_FLAG_DEFAULT;
         info->fbops = &radeon_fb_ops;
         info->display_fg = NULL;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/retz3fb.c linux_2_5/drivers/video/retz3fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/retz3fb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/retz3fb.c	Sun Jan  6 22:17:45 2002
@@ -1422,7 +1422,7 @@
 
 		strcpy(fb_info->modename, retz3fb_name);
 		fb_info->changevar = NULL;
-		fb_info->node = -1;
+		fb_info->node = NODEV;
 		fb_info->fbops = &retz3fb_ops;
 		fb_info->disp = &zinfo->disp;
 		fb_info->switch_con = &z3fb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/riva/fbdev.c linux_2_5/drivers/video/riva/fbdev.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/riva/fbdev.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/riva/fbdev.c	Sun Jan  6 22:24:52 2002
@@ -1811,7 +1811,7 @@
 	info = &rinfo->info;
 
 	strcpy(info->modename, rinfo->drvr_name);
-	info->node = -1;
+	info->node = NODEV;
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &riva_fb_ops;
 
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/sa1100fb.c linux_2_5/drivers/video/sa1100fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/sa1100fb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/sa1100fb.c	Sun Jan  6 22:17:51 2002
@@ -2245,7 +2245,7 @@
 	fbi->fb.updatevar	= sa1100fb_updatevar;
 	fbi->fb.blank		= sa1100fb_blank;
 	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
-	fbi->fb.node		= -1;
+	fbi->fb.node		= NODEV;
 	fbi->fb.monspecs	= monspecs;
 	fbi->fb.disp		= (struct display *)(fbi + 1);
 	fbi->fb.pseudo_palette	= (void *)(fbi->fb.disp + 1);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/sbusfb.c linux_2_5/drivers/video/sbusfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/sbusfb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/sbusfb.c	Sun Jan  6 22:17:55 2002
@@ -1019,7 +1019,7 @@
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->visual = FB_VISUAL_PSEUDOCOLOR;
 	
-	fb->info.node = -1;
+	fb->info.node = NODEV;
 	fb->info.fbops = &sbusfb_ops;
 	fb->info.disp = disp;
 	strcpy(fb->info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/sgivwfb.c linux_2_5/drivers/video/sgivwfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/sgivwfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/sgivwfb.c	Sun Jan  6 22:17:57 2002
@@ -890,7 +890,7 @@
 
   strcpy(fb_info.modename, sgivwfb_name);
   fb_info.changevar = NULL;
-  fb_info.node = -1;
+  fb_info.node = NODEV;
   fb_info.fbops = &sgivwfb_ops;
   fb_info.disp = &disp;
   fb_info.switch_con = &sgivwfbcon_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/sis/sis_main.c linux_2_5/drivers/video/sis/sis_main.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/sis/sis_main.c	Fri Nov  9 22:11:14 2001
+++ linux_2_5/drivers/video/sis/sis_main.c	Sun Jan  6 22:25:21 2002
@@ -2766,7 +2766,7 @@
 	sisfb_crtc_to_var (&default_var);
 
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &sisfb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &sisfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/skeletonfb.c linux_2_5/drivers/video/skeletonfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/skeletonfb.c	Thu Sep 13 23:04:43 2001
+++ linux_2_5/drivers/video/skeletonfb.c	Sun Jan  6 22:18:00 2002
@@ -306,7 +306,7 @@
     fb_info.gen.fbhw->detect();
     strcpy(fb_info.gen.info.modename, "XXX");
     fb_info.gen.info.changevar = NULL;
-    fb_info.gen.info.node = -1;
+    fb_info.gen.info.node = NODEV;
     fb_info.gen.info.fbops = &xxxfb_ops;
     fb_info.gen.info.disp = &disp;
     fb_info.gen.info.switch_con = &xxxfb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/sstfb.c linux_2_5/drivers/video/sstfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/sstfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/sstfb.c	Sun Jan  6 22:18:04 2002
@@ -1797,7 +1797,7 @@
 		f_ddprintk("membase_phys: %#lx\n", fb_info.video.base);
 		f_ddprintk("fbbase_virt: %#lx\n", fb_info.video.vbase);
 
-		fb_info.info.node       = -1 ;
+		fb_info.info.node       = NODEV;
 		fb_info.info.flags      = FBINFO_FLAG_DEFAULT;
 		fb_info.info.fbops      = &sstfb_ops;
 		fb_info.info.disp       = &disp;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/stifb.c linux_2_5/drivers/video/stifb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/stifb.c	Fri Feb  9 19:30:23 2001
+++ linux_2_5/drivers/video/stifb.c	Sun Jan  6 22:18:12 2002
@@ -166,7 +166,7 @@
 	if ((fb_info.sti = sti_init_roms()) == NULL)
 		return -ENXIO;
 
-	fb_info.gen.info.node = -1;
+	fb_info.gen.info.node = NODEV;
 	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
 	fb_info.gen.info.fbops = &stifb_ops;
 	fb_info.gen.info.disp = &disp;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/sun3fb.c linux_2_5/drivers/video/sun3fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/sun3fb.c	Sun Sep 30 19:26:08 2001
+++ linux_2_5/drivers/video/sun3fb.c	Sun Jan  6 22:18:15 2002
@@ -573,7 +573,7 @@
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->visual = FB_VISUAL_PSEUDOCOLOR;
 	
-	fb->info.node = -1;
+	fb->info.node = NODEV;
 	fb->info.fbops = &sun3fb_ops;
 	fb->info.disp = disp;
 	strcpy(fb->info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/tdfxfb.c linux_2_5/drivers/video/tdfxfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/tdfxfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/tdfxfb.c	Sun Jan  6 22:18:21 2002
@@ -1975,7 +1975,7 @@
 	strcpy(fb_info.fb_info.modename, "3Dfx "); 
 	strcat(fb_info.fb_info.modename, name);
 	fb_info.fb_info.changevar  = NULL;
-	fb_info.fb_info.node       = -1;
+	fb_info.fb_info.node       = NODEV;
 	fb_info.fb_info.fbops      = &tdfxfb_ops;
 	fb_info.fb_info.disp       = &fb_info.disp;
 	strcpy(fb_info.fb_info.fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/tgafb.c linux_2_5/drivers/video/tgafb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/tgafb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/tgafb.c	Sun Jan  6 22:18:24 2002
@@ -937,7 +937,7 @@
 
     /* setup framebuffer */
 
-    fb_info.gen.info.node = -1;
+    fb_info.gen.info.node = NODEV;
     fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
     fb_info.gen.info.fbops = &tgafb_ops;
     fb_info.gen.info.disp = &disp;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/tx3912fb.c linux_2_5/drivers/video/tx3912fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/tx3912fb.c	Fri Sep  7 16:28:38 2001
+++ linux_2_5/drivers/video/tx3912fb.c	Sun Jan  6 22:18:26 2002
@@ -397,7 +397,7 @@
 
 	strcpy(fb_info.modename, TX3912FB_NAME);
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
+	fb_info.node = NODEV;
 	fb_info.fbops = &tx3912fb_ops;
 	fb_info.disp = &global_disp;
 	fb_info.switch_con = &tx3912fbcon_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/valkyriefb.c linux_2_5/drivers/video/valkyriefb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/valkyriefb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/valkyriefb.c	Sun Jan  6 22:18:29 2002
@@ -779,7 +779,7 @@
 static void __init valkyrie_init_info(struct fb_info *info, struct fb_info_valkyrie *p)
 {
 	strcpy(info->modename, p->fix.id);
-	info->node = -1;	/* ??? danj */
+	info->node = NODEV;
 	info->fbops = &valkyriefb_ops;
 	info->disp = &p->disp;
 	strcpy(info->fontname, fontname);
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/vfb.c linux_2_5/drivers/video/vfb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/vfb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/vfb.c	Sun Jan  6 22:18:34 2002
@@ -404,7 +404,7 @@
 
     strcpy(fb_info.modename, vfb_name);
     fb_info.changevar = NULL;
-    fb_info.node = -1;
+    fb_info.node = NODEV;
     fb_info.fbops = &vfb_ops;
     fb_info.disp = &disp;
     fb_info.switch_con = &vfbcon_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/vga16fb.c linux_2_5/drivers/video/vga16fb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/vga16fb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/vga16fb.c	Sun Jan  6 22:18:36 2002
@@ -926,7 +926,7 @@
 	/* name should not depend on EGA/VGA */
 	strcpy(vga16fb.fb_info.modename, "VGA16 VGA");
 	vga16fb.fb_info.changevar = NULL;
-	vga16fb.fb_info.node = -1;
+	vga16fb.fb_info.node = NODEV;
 	vga16fb.fb_info.fbops = &vga16fb_ops;
 	vga16fb.fb_info.disp=&disp;
 	vga16fb.fb_info.switch_con=&vga16fb_switch;
diff -Naur -X /g/g/lib/dontdiff /spare/tmp/linux-2.5.2-pre9/drivers/video/virgefb.c linux_2_5/drivers/video/virgefb.c
--- /spare/tmp/linux-2.5.2-pre9/drivers/video/virgefb.c	Wed Nov 14 22:52:20 2001
+++ linux_2_5/drivers/video/virgefb.c	Sun Jan  6 22:18:42 2002
@@ -1168,7 +1168,7 @@
 
 	    strcpy(fb_info.modename, virgefb_name);
 	    fb_info.changevar = NULL;
-	    fb_info.node = -1;
+	    fb_info.node = NODEV;
 	    fb_info.fbops = &virgefb_ops;
 	    fb_info.disp = &disp;
 	    fb_info.switch_con = &Cyberfb_switch;

--------------C899353128B399CA0488BD7B--

