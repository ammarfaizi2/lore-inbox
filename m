Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276075AbRJUOHG>; Sun, 21 Oct 2001 10:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276094AbRJUOG6>; Sun, 21 Oct 2001 10:06:58 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:28083 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S276097AbRJUOGp>; Sun, 21 Oct 2001 10:06:45 -0400
Message-Id: <m15vJFv-007qbrC@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] strtok --> strsep in framebuffer drivers
Date: Sun, 21 Oct 2001 16:25:00 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a patch to eliminate all uses of strtok from the framebuffer
drivers. This is another step towards a strtok-free kernel. ;-)

It applies cleanly against kernels 2.4.13-pre5 and, with a few offsets,
2.4.12-ac3.

This patch is a bit lengthy, but hopefully easy to verify. Err, and I
did NOT test this thing. Maybe it doesn't even compile. That said,
please take a look at it and consider applying. It's not as I could've
made many mistakes after all (hi Rusty! :).

René



diff -ur linux-2.4.13-pre5/drivers/video/acornfb.c 
linux-2.4.13-pre5-rs/drivers/video/acornfb.c
--- linux-2.4.13-pre5/drivers/video/acornfb.c	Sun Oct 21 13:06:21 2001
+++ linux-2.4.13-pre5-rs/drivers/video/acornfb.c	Sun Oct 21 12:33:25 2001
@@ -1528,7 +1528,7 @@
 
 	acornfb_init_fbinfo();
 
-	for (opt = strtok(options, ","); opt; opt = strtok(NULL, ",")) {
+	while (opt = strsep(&options, ",")) {
 		if (!*opt)
 			continue;
 
diff -ur linux-2.4.13-pre5/drivers/video/amifb.c 
linux-2.4.13-pre5-rs/drivers/video/amifb.c
--- linux-2.4.13-pre5/drivers/video/amifb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/amifb.c	Sun Oct 21 12:34:28 2001
@@ -1192,7 +1192,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt; this_opt = strtok(NULL, 
",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strcmp(this_opt, "inverse")) {
 			amifb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.13-pre5/drivers/video/aty/atyfb_base.c 
linux-2.4.13-pre5-rs/drivers/video/aty/atyfb_base.c
--- linux-2.4.13-pre5/drivers/video/aty/atyfb_base.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/aty/atyfb_base.c	Sun Oct 21 12:34:56 
2001
@@ -2521,8 +2521,7 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
 	if (!strncmp(this_opt, "font:", 5)) {
 		char *p;
 		int i;
diff -ur linux-2.4.13-pre5/drivers/video/aty128fb.c 
linux-2.4.13-pre5-rs/drivers/video/aty128fb.c
--- linux-2.4.13-pre5/drivers/video/aty128fb.c	Mon Jul  2 23:13:40 2001
+++ linux-2.4.13-pre5-rs/drivers/video/aty128fb.c	Sun Oct 21 12:35:26 2001
@@ -1613,8 +1613,7 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
 	if (!strncmp(this_opt, "font:", 5)) {
 	    char *p;
 	    int i;
diff -ur linux-2.4.13-pre5/drivers/video/controlfb.c 
linux-2.4.13-pre5-rs/drivers/video/controlfb.c
--- linux-2.4.13-pre5/drivers/video/controlfb.c	Tue Oct  2 18:10:31 2001
+++ linux-2.4.13-pre5-rs/drivers/video/controlfb.c	Sun Oct 21 12:37:34 2001
@@ -1423,8 +1423,7 @@
 	if (!options || !*options)
 		return;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.13-pre5/drivers/video/cyberfb.c 
linux-2.4.13-pre5-rs/drivers/video/cyberfb.c
--- linux-2.4.13-pre5/drivers/video/cyberfb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/cyberfb.c	Sun Oct 21 12:38:01 2001
@@ -1022,8 +1022,7 @@
 		return 0;
 	}
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.13-pre5/drivers/video/fm2fb.c 
linux-2.4.13-pre5-rs/drivers/video/fm2fb.c
--- linux-2.4.13-pre5/drivers/video/fm2fb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/fm2fb.c	Sun Oct 21 12:42:02 2001
@@ -430,8 +430,7 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
 	if (!strncmp(this_opt, "pal", 3))
 	    fm2fb_mode = FM2FB_MODE_PAL;
 	else if (!strncmp(this_opt, "ntsc", 4))
diff -ur linux-2.4.13-pre5/drivers/video/hgafb.c 
linux-2.4.13-pre5-rs/drivers/video/hgafb.c
--- linux-2.4.13-pre5/drivers/video/hgafb.c	Sun Oct 21 13:06:21 2001
+++ linux-2.4.13-pre5-rs/drivers/video/hgafb.c	Sun Oct 21 12:42:57 2001
@@ -795,8 +795,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-			this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}
diff -ur linux-2.4.13-pre5/drivers/video/igafb.c 
linux-2.4.13-pre5-rs/drivers/video/igafb.c
--- linux-2.4.13-pre5/drivers/video/igafb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/igafb.c	Sun Oct 21 12:44:04 2001
@@ -773,8 +773,7 @@
     if (!options || !*options)
         return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-         this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
         if (!strncmp(this_opt, "font:", 5)) {
                 char *p;
                 int i;
diff -ur linux-2.4.13-pre5/drivers/video/imsttfb.c 
linux-2.4.13-pre5-rs/drivers/video/imsttfb.c
--- linux-2.4.13-pre5/drivers/video/imsttfb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/imsttfb.c	Sun Oct 21 12:44:36 2001
@@ -1977,8 +1977,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.13-pre5/drivers/video/macfb.c 
linux-2.4.13-pre5-rs/drivers/video/macfb.c
--- linux-2.4.13-pre5/drivers/video/macfb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/macfb.c	Sun Oct 21 12:45:23 2001
@@ -848,7 +848,7 @@
 	if (!options || !*options)
 		return;
 	
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ur linux-2.4.13-pre5/drivers/video/matrox/matroxfb_base.c 
linux-2.4.13-pre5-rs/drivers/video/matrox/matroxfb_base.c
--- linux-2.4.13-pre5/drivers/video/matrox/matroxfb_base.c	Sun Sep 30 
21:26:08 2001
+++ linux-2.4.13-pre5-rs/drivers/video/matrox/matroxfb_base.c	Sun Oct 21 
12:46:21 2001
@@ -2355,7 +2355,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 
 		dprintk("matroxfb_setup: option %s\n", this_opt);
diff -ur linux-2.4.13-pre5/drivers/video/platinumfb.c 
linux-2.4.13-pre5-rs/drivers/video/platinumfb.c
--- linux-2.4.13-pre5/drivers/video/platinumfb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/platinumfb.c	Sun Oct 21 12:52:45 2001
@@ -841,8 +841,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.13-pre5/drivers/video/radeonfb.c 
linux-2.4.13-pre5-rs/drivers/video/radeonfb.c
--- linux-2.4.13-pre5/drivers/video/radeonfb.c	Sun Sep  9 19:52:35 2001
+++ linux-2.4.13-pre5-rs/drivers/video/radeonfb.c	Sun Oct 21 12:53:17 2001
@@ -537,8 +537,7 @@
         if (!options || !*options)
                 return 0;
  
-        for (this_opt = strtok (options, ","); this_opt;
-             this_opt = strtok (NULL, ",")) {
+	while (this_opt = strsep (&options, ",")) {
                 if (!strncmp (this_opt, "font:", 5)) {
                         char *p;
                         int i;
diff -ur linux-2.4.13-pre5/drivers/video/retz3fb.c 
linux-2.4.13-pre5-rs/drivers/video/retz3fb.c
--- linux-2.4.13-pre5/drivers/video/retz3fb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/retz3fb.c	Sun Oct 21 12:53:49 2001
@@ -1348,8 +1348,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")){
+	while (this_opt = strsep(&options, ",")) {
 		if (!strcmp(this_opt, "inverse")) {
 			z3fb_inverse = 1;
 			fb_invert_cmaps();
diff -ur linux-2.4.13-pre5/drivers/video/riva/fbdev.c 
linux-2.4.13-pre5-rs/drivers/video/riva/fbdev.c
--- linux-2.4.13-pre5/drivers/video/riva/fbdev.c	Sun Sep 30 21:26:08 2001
+++ linux-2.4.13-pre5-rs/drivers/video/riva/fbdev.c	Sun Oct 21 12:54:12 2001
@@ -2045,8 +2045,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.13-pre5/drivers/video/sa1100fb.c 
linux-2.4.13-pre5-rs/drivers/video/sa1100fb.c
--- linux-2.4.13-pre5/drivers/video/sa1100fb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/sa1100fb.c	Sun Oct 21 12:54:46 2001
@@ -2299,8 +2299,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 
 		if (!strncmp(this_opt, "bpp:", 4))
 			current_par.max_bpp =
diff -ur linux-2.4.13-pre5/drivers/video/sgivwfb.c 
linux-2.4.13-pre5-rs/drivers/video/sgivwfb.c
--- linux-2.4.13-pre5/drivers/video/sgivwfb.c	Fri Feb  9 20:30:23 2001
+++ linux-2.4.13-pre5-rs/drivers/video/sgivwfb.c	Sun Oct 21 12:57:06 2001
@@ -862,8 +862,7 @@
   if (!options || !*options)
     return 0;
 
-  for (this_opt = strtok(options, ","); this_opt;
-       this_opt = strtok(NULL, ",")) {
+  while (this_opt = strsep(&options, ",")) {
     if (!strncmp(this_opt, "font:", 5))
       strcpy(fb_info.fontname, this_opt+5);
   }
diff -ur linux-2.4.13-pre5/drivers/video/sis/sis_main.c 
linux-2.4.13-pre5-rs/drivers/video/sis/sis_main.c
--- linux-2.4.13-pre5/drivers/video/sis/sis_main.c	Fri Sep 14 23:40:00 2001
+++ linux-2.4.13-pre5-rs/drivers/video/sis/sis_main.c	Sun Oct 21 12:57:29 2001
@@ -1726,8 +1726,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt)
 			continue;
 
diff -ur linux-2.4.13-pre5/drivers/video/sstfb.c 
linux-2.4.13-pre5-rs/drivers/video/sstfb.c
--- linux-2.4.13-pre5/drivers/video/sstfb.c	Fri Sep  7 18:28:38 2001
+++ linux-2.4.13-pre5-rs/drivers/video/sstfb.c	Sun Oct 21 12:57:57 2001
@@ -1697,8 +1697,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for(this_opt = strtok(options, ","); this_opt;
-	    this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 
 		f_ddprintk("option %s\n", this_opt);
diff -ur linux-2.4.13-pre5/drivers/video/tdfxfb.c 
linux-2.4.13-pre5-rs/drivers/video/tdfxfb.c
--- linux-2.4.13-pre5/drivers/video/tdfxfb.c	Sun Oct 21 13:06:22 2001
+++ linux-2.4.13-pre5-rs/drivers/video/tdfxfb.c	Sun Oct 21 12:58:28 2001
@@ -2086,9 +2086,7 @@
   if(!options || !*options)
     return;
 
-  for(this_opt = strtok(options, ","); 
-      this_opt;
-      this_opt = strtok(NULL, ",")) {
+  while(this_opt = strsep(&options, ",")) {
     if(!strcmp(this_opt, "inverse")) {
       inverse = 1;
       fb_invert_cmaps();
diff -ur linux-2.4.13-pre5/drivers/video/tgafb.c 
linux-2.4.13-pre5-rs/drivers/video/tgafb.c
--- linux-2.4.13-pre5/drivers/video/tgafb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/tgafb.c	Sun Oct 21 13:00:04 2001
@@ -889,7 +889,7 @@
     int i;
     
     if (options && *options) {
-    	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    	while (this_opt = strsep(&options, ",")) {
        	    if (!*this_opt) { continue; }
         
 	    if (!strncmp(this_opt, "font:", 5)) {
diff -ur linux-2.4.13-pre5/drivers/video/valkyriefb.c 
linux-2.4.13-pre5-rs/drivers/video/valkyriefb.c
--- linux-2.4.13-pre5/drivers/video/valkyriefb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/valkyriefb.c	Sun Oct 21 13:00:27 2001
@@ -801,8 +801,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt;
-	     this_opt = strtok(NULL, ",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -ur linux-2.4.13-pre5/drivers/video/vesafb.c 
linux-2.4.13-pre5-rs/drivers/video/vesafb.c
--- linux-2.4.13-pre5/drivers/video/vesafb.c	Wed Apr 18 20:49:12 2001
+++ linux-2.4.13-pre5-rs/drivers/video/vesafb.c	Sun Oct 21 13:00:46 2001
@@ -457,7 +457,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -ur linux-2.4.13-pre5/drivers/video/vfb.c 
linux-2.4.13-pre5-rs/drivers/video/vfb.c
--- linux-2.4.13-pre5/drivers/video/vfb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/vfb.c	Sun Oct 21 13:01:03 2001
@@ -382,8 +382,7 @@
     if (!options || !*options)
 	return 0;
 
-    for (this_opt = strtok(options, ","); this_opt;
-	 this_opt = strtok(NULL, ",")) {
+    while (this_opt = strsep(&options, ",")) {
 	if (!strncmp(this_opt, "font:", 5))
 	    strcpy(fb_info.fontname, this_opt+5);
     }
diff -ur linux-2.4.13-pre5/drivers/video/vga16fb.c 
linux-2.4.13-pre5-rs/drivers/video/vga16fb.c
--- linux-2.4.13-pre5/drivers/video/vga16fb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/vga16fb.c	Sun Oct 21 13:01:51 2001
@@ -692,7 +692,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+	while (this_opt = strsep(&options, ",")) {
 		if (!*this_opt) continue;
 		
 		if (!strncmp(this_opt, "font:", 5))
diff -ur linux-2.4.13-pre5/drivers/video/virgefb.c 
linux-2.4.13-pre5-rs/drivers/video/virgefb.c
--- linux-2.4.13-pre5/drivers/video/virgefb.c	Fri Sep 14 01:04:43 2001
+++ linux-2.4.13-pre5-rs/drivers/video/virgefb.c	Sun Oct 21 13:02:11 2001
@@ -1085,7 +1085,7 @@
 	if (!options || !*options)
 		return 0;
 
-	for (this_opt = strtok(options, ","); this_opt; this_opt = strtok(NULL, 
","))
+	while (this_opt = strsep(&options, ",")) {
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
