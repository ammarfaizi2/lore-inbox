Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRJYVyT>; Thu, 25 Oct 2001 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJYVyL>; Thu, 25 Oct 2001 17:54:11 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:5084 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S276448AbRJYVyE>; Thu, 25 Oct 2001 17:54:04 -0400
Message-Id: <m15wsSM-007qjJC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers
Date: Thu, 25 Oct 2001 23:58:44 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200110250658.f9P6wsa25178@penguin.transmeta.com>
In-Reply-To: <200110250658.f9P6wsa25178@penguin.transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 25. Oktober 2001 08:58 schrieben Sie:
> In article <m15vJFv-007qbrC@smtp.web.de> you write:
> >-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ",")) {
> >+	while (opt = strsep(&options, ",")) {
>
> Btw, this causes gcc to warn all over the place about "assignment used
> as truth value".
>
> It's valid C, but it's also a very common (and often valid) warning..
>
> 		Linus

Yes. I assumed my compiler (gcc 2.96) was misbehaving by reporting all
that warnings about code which is actually just some normal C code. But
after some consideration I see that it can help greatly in case of
typos and so on.

And because of that I'm actually paying for a round of pairs of
parentheses to make all those warnings go away. Following patch
compiles here, but is untested. It requires my previous 3 patches
on that subject (one of which went into kernel 2.4.13-pre6).

René



diff -ruN linux-2.4.13-rs/drivers/video/acornfb.c 
linux-2.4.13-rs2/drivers/video/acornfb.c
--- linux-2.4.13-rs/drivers/video/acornfb.c	Wed Oct 24 19:19:03 2001
+++ linux-2.4.13-rs2/drivers/video/acornfb.c	Thu Oct 25 22:39:26 2001
@@ -1528,7 +1528,7 @@
 
 	acornfb_init_fbinfo();
 
-	while (opt = strsep(&options, ",")) {
+	while ((opt = strsep(&options, ","))) {
 		if (!*opt)
 			continue;
 
diff -ruN linux-2.4.13-rs/drivers/video/amifb.c 
linux-2.4.13-rs2/drivers/video/amifb.c
--- linux-2.4.13-rs/drivers/video/amifb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/amifb.c	Thu Oct 25 22:41:47 2001
@@ -1192,7 +1192,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
 		if (!strcmp(this_opt, "inverse")) {
diff -ruN linux-2.4.13-rs/drivers/video/atafb.c 
linux-2.4.13-rs2/drivers/video/atafb.c
--- linux-2.4.13-rs/drivers/video/atafb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/atafb.c	Thu Oct 25 22:42:05 2001
@@ -2899,7 +2899,7 @@
     if (!options || !*options)
 		return 0;
      
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ","))) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
diff -ruN linux-2.4.13-rs/drivers/video/aty/atyfb_base.c 
linux-2.4.13-rs2/drivers/video/aty/atyfb_base.c
--- linux-2.4.13-rs/drivers/video/aty/atyfb_base.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/aty/atyfb_base.c	Thu Oct 25 22:37:56 2001
@@ -2521,7 +2521,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ","))) {
 	if (!*this_opt)
 		continue;
 	if (!strncmp(this_opt, "font:", 5)) {
diff -ruN linux-2.4.13-rs/drivers/video/aty128fb.c 
linux-2.4.13-rs2/drivers/video/aty128fb.c
--- linux-2.4.13-rs/drivers/video/aty128fb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/aty128fb.c	Thu Oct 25 22:38:29 2001
@@ -1613,7 +1613,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ","))) {
 	if (!*this_opt)
 	    continue;
 	if (!strncmp(this_opt, "font:", 5)) {
diff -ruN linux-2.4.13-rs/drivers/video/clgenfb.c 
linux-2.4.13-rs2/drivers/video/clgenfb.c
--- linux-2.4.13-rs/drivers/video/clgenfb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/clgenfb.c	Thu Oct 25 22:40:36 2001
@@ -2817,7 +2817,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep (&options, ",")) {
+	while ((this_opt = strsep (&options, ","))) {
 		if (!*this_opt) continue;
 
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
diff -ruN linux-2.4.13-rs/drivers/video/controlfb.c 
linux-2.4.13-rs2/drivers/video/controlfb.c
--- linux-2.4.13-rs/drivers/video/controlfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/controlfb.c	Thu Oct 25 22:41:03 2001
@@ -1423,7 +1423,7 @@
 	if (!options || !*options)
 		return;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.13-rs/drivers/video/cyberfb.c 
linux-2.4.13-rs2/drivers/video/cyberfb.c
--- linux-2.4.13-rs/drivers/video/cyberfb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/cyberfb.c	Thu Oct 25 22:41:12 2001
@@ -1022,7 +1022,7 @@
 		return 0;
 	}
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
 		if (!strcmp(this_opt, "inverse")) {
diff -ruN linux-2.4.13-rs/drivers/video/fm2fb.c 
linux-2.4.13-rs2/drivers/video/fm2fb.c
--- linux-2.4.13-rs/drivers/video/fm2fb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/fm2fb.c	Thu Oct 25 22:40:19 2001
@@ -430,7 +430,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ","))) {
 	if (!strncmp(this_opt, "pal", 3))
 	    fm2fb_mode = FM2FB_MODE_PAL;
 	else if (!strncmp(this_opt, "ntsc", 4))
diff -ruN linux-2.4.13-rs/drivers/video/hgafb.c 
linux-2.4.13-rs2/drivers/video/hgafb.c
--- linux-2.4.13-rs/drivers/video/hgafb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/hgafb.c	Thu Oct 25 22:41:31 2001
@@ -795,7 +795,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}
diff -ruN linux-2.4.13-rs/drivers/video/igafb.c 
linux-2.4.13-rs2/drivers/video/igafb.c
--- linux-2.4.13-rs/drivers/video/igafb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/igafb.c	Thu Oct 25 22:41:57 2001
@@ -773,7 +773,7 @@
     if (!options || !*options)
         return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ","))) {
         if (!strncmp(this_opt, "font:", 5)) {
                 char *p;
                 int i;
diff -ruN linux-2.4.13-rs/drivers/video/imsttfb.c 
linux-2.4.13-rs2/drivers/video/imsttfb.c
--- linux-2.4.13-rs/drivers/video/imsttfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/imsttfb.c	Thu Oct 25 22:40:09 2001
@@ -1977,7 +1977,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.13-rs/drivers/video/macfb.c 
linux-2.4.13-rs2/drivers/video/macfb.c
--- linux-2.4.13-rs/drivers/video/macfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/macfb.c	Thu Oct 25 22:39:51 2001
@@ -848,7 +848,7 @@
 	if (!options || !*options)
 		return;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ruN linux-2.4.13-rs/drivers/video/matrox/matroxfb_base.c 
linux-2.4.13-rs2/drivers/video/matrox/matroxfb_base.c
--- linux-2.4.13-rs/drivers/video/matrox/matroxfb_base.c	Wed Oct 24 19:19:04 
2001
+++ linux-2.4.13-rs2/drivers/video/matrox/matroxfb_base.c	Thu Oct 25 22:41:21 
2001
@@ -2355,7 +2355,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt) continue;
 
 		dprintk("matroxfb_setup: option %s\n", this_opt);
diff -ruN linux-2.4.13-rs/drivers/video/platinumfb.c 
linux-2.4.13-rs2/drivers/video/platinumfb.c
--- linux-2.4.13-rs/drivers/video/platinumfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/platinumfb.c	Thu Oct 25 22:42:14 2001
@@ -841,7 +841,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.13-rs/drivers/video/radeonfb.c 
linux-2.4.13-rs2/drivers/video/radeonfb.c
--- linux-2.4.13-rs/drivers/video/radeonfb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/radeonfb.c	Thu Oct 25 22:39:34 2001
@@ -537,7 +537,7 @@
         if (!options || !*options)
                 return 0;
  
-	while (this_opt = strsep (&options, ",")) {
+	while ((this_opt = strsep (&options, ","))) {
 		if (!*this_opt)
 			continue;
                 if (!strncmp (this_opt, "font:", 5)) {
diff -ruN linux-2.4.13-rs/drivers/video/retz3fb.c 
linux-2.4.13-rs2/drivers/video/retz3fb.c
--- linux-2.4.13-rs/drivers/video/retz3fb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/retz3fb.c	Thu Oct 25 22:42:23 2001
@@ -1348,7 +1348,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
 		if (!strcmp(this_opt, "inverse")) {
diff -ruN linux-2.4.13-rs/drivers/video/riva/fbdev.c 
linux-2.4.13-rs2/drivers/video/riva/fbdev.c
--- linux-2.4.13-rs/drivers/video/riva/fbdev.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/riva/fbdev.c	Thu Oct 25 22:38:13 2001
@@ -2045,7 +2045,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
diff -ruN linux-2.4.13-rs/drivers/video/sa1100fb.c 
linux-2.4.13-rs2/drivers/video/sa1100fb.c
--- linux-2.4.13-rs/drivers/video/sa1100fb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/sa1100fb.c	Thu Oct 25 22:39:42 2001
@@ -2299,7 +2299,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 
 		if (!strncmp(this_opt, "bpp:", 4))
 			current_par.max_bpp =
diff -ruN linux-2.4.13-rs/drivers/video/sgivwfb.c 
linux-2.4.13-rs2/drivers/video/sgivwfb.c
--- linux-2.4.13-rs/drivers/video/sgivwfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/sgivwfb.c	Thu Oct 25 22:38:54 2001
@@ -862,7 +862,7 @@
   if (!options || !*options)
     return 0;
 
-  while (this_opt = strsep(&options, ",")) {
+  while ((this_opt = strsep(&options, ","))) {
     if (!strncmp(this_opt, "font:", 5))
       strcpy(fb_info.fontname, this_opt+5);
   }
diff -ruN linux-2.4.13-rs/drivers/video/sis/sis_main.c 
linux-2.4.13-rs2/drivers/video/sis/sis_main.c
--- linux-2.4.13-rs/drivers/video/sis/sis_main.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/sis/sis_main.c	Thu Oct 25 22:38:04 2001
@@ -1726,7 +1726,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
 
diff -ruN linux-2.4.13-rs/drivers/video/sstfb.c 
linux-2.4.13-rs2/drivers/video/sstfb.c
--- linux-2.4.13-rs/drivers/video/sstfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/sstfb.c	Thu Oct 25 22:40:45 2001
@@ -1697,7 +1697,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt) continue;
 
 		f_ddprintk("option %s\n", this_opt);
diff -ruN linux-2.4.13-rs/drivers/video/tdfxfb.c 
linux-2.4.13-rs2/drivers/video/tdfxfb.c
--- linux-2.4.13-rs/drivers/video/tdfxfb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/tdfxfb.c	Thu Oct 25 22:38:38 2001
@@ -2086,7 +2086,7 @@
   if(!options || !*options)
     return;
 
-  while(this_opt = strsep(&options, ",")) {
+  while((this_opt = strsep(&options, ","))) {
     if(!*this_opt)
       continue;
     if(!strcmp(this_opt, "inverse")) {
diff -ruN linux-2.4.13-rs/drivers/video/tgafb.c 
linux-2.4.13-rs2/drivers/video/tgafb.c
--- linux-2.4.13-rs/drivers/video/tgafb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/tgafb.c	Thu Oct 25 22:40:28 2001
@@ -889,7 +889,7 @@
     int i;
     
     if (options && *options) {
-    	while (this_opt = strsep(&options, ",")) {
+    	while ((this_opt = strsep(&options, ","))) {
        	    if (!*this_opt) { continue; }
         
 	    if (!strncmp(this_opt, "font:", 5)) {
diff -ruN linux-2.4.13-rs/drivers/video/valkyriefb.c 
linux-2.4.13-rs2/drivers/video/valkyriefb.c
--- linux-2.4.13-rs/drivers/video/valkyriefb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/valkyriefb.c	Thu Oct 25 22:38:21 2001
@@ -801,7 +801,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ruN linux-2.4.13-rs/drivers/video/vesafb.c 
linux-2.4.13-rs2/drivers/video/vesafb.c
--- linux-2.4.13-rs/drivers/video/vesafb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/vesafb.c	Thu Oct 25 22:40:55 2001
@@ -457,7 +457,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ruN linux-2.4.13-rs/drivers/video/vfb.c 
linux-2.4.13-rs2/drivers/video/vfb.c
--- linux-2.4.13-rs/drivers/video/vfb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/vfb.c	Thu Oct 25 22:39:04 2001
@@ -382,7 +382,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ","))) {
 	if (!strncmp(this_opt, "font:", 5))
 	    strcpy(fb_info.fontname, this_opt+5);
     }
diff -ruN linux-2.4.13-rs/drivers/video/vga16fb.c 
linux-2.4.13-rs2/drivers/video/vga16fb.c
--- linux-2.4.13-rs/drivers/video/vga16fb.c	Wed Oct 24 19:19:04 2001
+++ linux-2.4.13-rs2/drivers/video/vga16fb.c	Thu Oct 25 22:41:39 2001
@@ -692,7 +692,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt) continue;
 		
 		if (!strncmp(this_opt, "font:", 5))
diff -ruN linux-2.4.13-rs/drivers/video/virgefb.c 
linux-2.4.13-rs2/drivers/video/virgefb.c
--- linux-2.4.13-rs/drivers/video/virgefb.c	Thu Oct 25 00:44:56 2001
+++ linux-2.4.13-rs2/drivers/video/virgefb.c	Thu Oct 25 22:38:46 2001
@@ -1085,7 +1085,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ","))) {
 		if (!*this_opt)
 			continue;
 		if (!strcmp(this_opt, "inverse")) {
diff -ruN linux-2.4.13-rs/fs/adfs/super.c linux-2.4.13-rs2/fs/adfs/super.c
--- linux-2.4.13-rs/fs/adfs/super.c	Thu Oct 25 22:20:28 2001
+++ linux-2.4.13-rs2/fs/adfs/super.c	Thu Oct 25 22:34:16 2001
@@ -171,7 +171,7 @@
 	if (!options)
 		return 0;
 
-	while (opt = strsep(&options, ",")) {
+	while ((opt = strsep(&options, ","))) {
 		if (!*opt)
 			continue;
 		value = strchr(opt, '=');
diff -ruN linux-2.4.13-rs/fs/affs/super.c linux-2.4.13-rs2/fs/affs/super.c
--- linux-2.4.13-rs/fs/affs/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/affs/super.c	Thu Oct 25 22:34:26 2001
@@ -109,7 +109,7 @@
 	*mount_opts = 0;
 	if (!options)
 		return 1;
-	while (this_char = strsep(&options, ",")) {
+	while ((this_char = strsep(&options, ","))) {
 		if (!*this_char)
 			continue;
 		f = 0;
diff -ruN linux-2.4.13-rs/fs/autofs/inode.c linux-2.4.13-rs2/fs/autofs/inode.c
--- linux-2.4.13-rs/fs/autofs/inode.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/autofs/inode.c	Thu Oct 25 22:36:06 2001
@@ -60,7 +60,7 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	while (this_char = strsep(&options,",")) {
+	while ((this_char = strsep(&options,","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/autofs4/inode.c 
linux-2.4.13-rs2/fs/autofs4/inode.c
--- linux-2.4.13-rs/fs/autofs4/inode.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/autofs4/inode.c	Thu Oct 25 22:36:41 2001
@@ -112,7 +112,7 @@
 	*pipefd = -1;
 
 	if ( !options ) return 1;
-	while (this_char = strsep(&options,",")) {
+	while ((this_char = strsep(&options,","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/devpts/inode.c linux-2.4.13-rs2/fs/devpts/inode.c
--- linux-2.4.13-rs/fs/devpts/inode.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/devpts/inode.c	Thu Oct 25 22:36:32 2001
@@ -68,7 +68,7 @@
 
 	if (!options)
 		goto default_settings;
-	while ( this_char = strsep(&options,",") ) {
+	while ( (this_char = strsep(&options,",")) ) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/ext2/super.c linux-2.4.13-rs2/fs/ext2/super.c
--- linux-2.4.13-rs/fs/ext2/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/ext2/super.c	Thu Oct 25 22:34:35 2001
@@ -166,7 +166,7 @@
 
 	if (!options)
 		return 1;
-	while (this_char = strsep (&options, ",")) {
+	while ((this_char = strsep (&options, ","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/fat/inode.c linux-2.4.13-rs2/fs/fat/inode.c
--- linux-2.4.13-rs/fs/fat/inode.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/fat/inode.c	Thu Oct 25 22:33:25 2001
@@ -230,7 +230,7 @@
 		goto out;
 	save = 0;
 	savep = NULL;
-	while (this_char = strsep(&options_p, ",")) {
+	while ((this_char = strsep(&options_p, ","))) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ruN linux-2.4.13-rs/fs/hfs/super.c linux-2.4.13-rs2/fs/hfs/super.c
--- linux-2.4.13-rs/fs/hfs/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/hfs/super.c	Thu Oct 25 22:33:34 2001
@@ -181,7 +181,7 @@
 	if (!options) {
 		goto done;
 	}
-	while (this_char = strsep(&options, ",")) {
+	while ((this_char = strsep(&options, ","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
diff -ruN linux-2.4.13-rs/fs/hpfs/super.c linux-2.4.13-rs2/fs/hpfs/super.c
--- linux-2.4.13-rs/fs/hpfs/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/hpfs/super.c	Thu Oct 25 22:34:45 2001
@@ -176,7 +176,7 @@
 
 	/*printk("Parsing opts: '%s'\n",opts);*/
 
-	while (p = strsep(&opts, ",")) {
+	while ((p = strsep(&opts, ","))) {
 		if (!*p)
 			continue;
 		if ((rhs = strchr(p, '=')) != 0)
diff -ruN linux-2.4.13-rs/fs/isofs/inode.c linux-2.4.13-rs2/fs/isofs/inode.c
--- linux-2.4.13-rs/fs/isofs/inode.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/isofs/inode.c	Thu Oct 25 22:35:25 2001
@@ -290,7 +290,7 @@
 	popt->session=-1;
 	popt->sbsector=-1;
 	if (!options) return 1;
-	while (this_char = strsep(&options,",")) {
+	while ((this_char = strsep(&options,","))) {
 		if (!*this_char)
 			continue;
 	        if (strncmp(this_char,"norock",6) == 0) {
diff -ruN linux-2.4.13-rs/fs/nfs/nfsroot.c linux-2.4.13-rs2/fs/nfs/nfsroot.c
--- linux-2.4.13-rs/fs/nfs/nfsroot.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/nfs/nfsroot.c	Thu Oct 25 22:33:48 2001
@@ -202,7 +202,7 @@
 
 	if ((options = strchr(name, ','))) {
 		*options++ = 0;
-		while (cp = strsep(&options, ",")) {
+		while ((cp = strsep(&options, ","))) {
 			if (!*cp)
 				continue;
 			if ((val = strchr(cp, '='))) {
diff -ruN linux-2.4.13-rs/fs/ntfs/fs.c linux-2.4.13-rs2/fs/ntfs/fs.c
--- linux-2.4.13-rs/fs/ntfs/fs.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/ntfs/fs.c	Thu Oct 25 22:34:52 2001
@@ -369,7 +369,7 @@
 
 	if (!opt)
 		goto done;
-	while (opt = strsep(&options, ",")) {
+	while ((opt = strsep(&options, ","))) {
 		if (!*opt)
 			continue;
 		if ((value = strchr(opt, '=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/proc/inode.c linux-2.4.13-rs2/fs/proc/inode.c
--- linux-2.4.13-rs/fs/proc/inode.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/proc/inode.c	Thu Oct 25 22:35:01 2001
@@ -106,7 +106,7 @@
 	*uid = current->uid;
 	*gid = current->gid;
 	if (!options) return 1;
-	while (this_char = strsep(&options,",")) {
+	while ((this_char = strsep(&options,","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/reiserfs/super.c 
linux-2.4.13-rs2/fs/reiserfs/super.c
--- linux-2.4.13-rs/fs/reiserfs/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/reiserfs/super.c	Thu Oct 25 22:35:17 2001
@@ -144,7 +144,7 @@
 	/* use default configuration: create tails, journaling on, no
            conversion to newest format */
 	return 1;
-    while (this_char = strsep (&options, ",")) {
+    while ((this_char = strsep (&options, ","))) {
 	if (!*this_char)
 	    continue;
 	if ((value = strchr (this_char, '=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/udf/super.c linux-2.4.13-rs2/fs/udf/super.c
--- linux-2.4.13-rs/fs/udf/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/udf/super.c	Thu Oct 25 22:33:59 2001
@@ -218,7 +218,7 @@
 	if (!options)
 		return 1;
 
-	while (opt = strsep(&options, ","))
+	while ((opt = strsep(&options, ",")))
 	{
 		if (!*opt)
 			continue;
diff -ruN linux-2.4.13-rs/fs/ufs/super.c linux-2.4.13-rs2/fs/ufs/super.c
--- linux-2.4.13-rs/fs/ufs/super.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/ufs/super.c	Thu Oct 25 22:34:08 2001
@@ -257,7 +257,7 @@
 	if (!options)
 		return 1;
 		
-	while (this_char = strsep (&options, ",")) {
+	while ((this_char = strsep (&options, ","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
diff -ruN linux-2.4.13-rs/fs/vfat/namei.c linux-2.4.13-rs2/fs/vfat/namei.c
--- linux-2.4.13-rs/fs/vfat/namei.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/fs/vfat/namei.c	Thu Oct 25 22:35:09 2001
@@ -121,7 +121,7 @@
 	save = 0;
 	savep = NULL;
 	ret = 1;
-	while (this_char = strsep(&options_p, ",")) {
+	while ((this_char = strsep(&options_p, ","))) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ruN linux-2.4.13-rs/mm/shmem.c linux-2.4.13-rs2/mm/shmem.c
--- linux-2.4.13-rs/mm/shmem.c	Thu Oct 25 00:44:59 2001
+++ linux-2.4.13-rs2/mm/shmem.c	Thu Oct 25 22:36:53 2001
@@ -1239,7 +1239,7 @@
 
 	if (!options)
 		return 0;
-	while (this_char = strsep(&options,",")) {
+	while ((this_char = strsep(&options,","))) {
 		if (!*this_char)
 			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {

