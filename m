Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278085AbRKNWYp>; Wed, 14 Nov 2001 17:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278275AbRKNWYh>; Wed, 14 Nov 2001 17:24:37 -0500
Received: from smtp02.web.de ([217.72.192.151]:30737 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S278085AbRKNWYV>;
	Wed, 14 Nov 2001 17:24:21 -0500
Date: Wed, 14 Nov 2001 23:26:13 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] compiler warnings in framebuffer drivers
Message-Id: <20011114232613.625ed599.l.s.r@web.de>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch removes all those compiler warnings that were introduced with
the anti-strtok patch some time ago. It's against kernel 2.4.15-pre4. I
sent you similar ones but it seems they got lost. Which makes me
suspicious: is there something wrong with this patch that prevents it
from being applied?

OK, additionally to adding some parentheses this patch corrects a minor
issue by inserting code like this at appropriate places:

+		if (!*this_opt)
+			continue;

This lets the parameter parsing code skip over empty tokens, just like
strtok did implicitely. It's purely cosmetic - I'd send you a patch
without this 'feature', if you like.

Patch is untested, but at least it compiles. Please, apply.

René



diff -Nur linux-2.4.15-pre4/drivers/video/acornfb.c linux-2.4.15-pre4-rs/drivers/video/acornfb.c
--- linux-2.4.15-pre4/drivers/video/acornfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/acornfb.c	Wed Nov 14 23:36:10 2001
@@ -1528,7 +1528,7 @@
 
 	acornfb_init_fbinfo();
 
-	while (opt = strsep(&options, ",")) {
+	while ((opt = strsep(&options, ",")) != NULL) {
 		if (!*opt)
 			continue;
 
diff -Nur linux-2.4.15-pre4/drivers/video/amifb.c linux-2.4.15-pre4-rs/drivers/video/amifb.c
--- linux-2.4.15-pre4/drivers/video/amifb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/amifb.c	Wed Nov 14 23:36:10 2001
@@ -1192,7 +1192,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			amifb_inverse = 1;
 			fb_invert_cmaps();
diff -Nur linux-2.4.15-pre4/drivers/video/controlfb.c linux-2.4.15-pre4-rs/drivers/video/controlfb.c
--- linux-2.4.15-pre4/drivers/video/controlfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/controlfb.c	Wed Nov 14 23:36:11 2001
@@ -1423,7 +1423,7 @@
 	if (!options || !*options)
 		return;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -Nur linux-2.4.15-pre4/drivers/video/cyberfb.c linux-2.4.15-pre4-rs/drivers/video/cyberfb.c
--- linux-2.4.15-pre4/drivers/video/cyberfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/cyberfb.c	Wed Nov 14 23:36:11 2001
@@ -1022,7 +1022,9 @@
 		return 0;
 	}
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
diff -Nur linux-2.4.15-pre4/drivers/video/fm2fb.c linux-2.4.15-pre4-rs/drivers/video/fm2fb.c
--- linux-2.4.15-pre4/drivers/video/fm2fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/fm2fb.c	Wed Nov 14 23:36:11 2001
@@ -430,7 +430,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!strncmp(this_opt, "pal", 3))
 	    fm2fb_mode = FM2FB_MODE_PAL;
 	else if (!strncmp(this_opt, "ntsc", 4))
diff -Nur linux-2.4.15-pre4/drivers/video/igafb.c linux-2.4.15-pre4-rs/drivers/video/igafb.c
--- linux-2.4.15-pre4/drivers/video/igafb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/igafb.c	Wed Nov 14 23:36:11 2001
@@ -773,7 +773,7 @@
     if (!options || !*options)
         return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
         if (!strncmp(this_opt, "font:", 5)) {
                 char *p;
                 int i;
diff -Nur linux-2.4.15-pre4/drivers/video/imsttfb.c linux-2.4.15-pre4-rs/drivers/video/imsttfb.c
--- linux-2.4.15-pre4/drivers/video/imsttfb.c	Wed Nov 14 23:34:11 2001
+++ linux-2.4.15-pre4-rs/drivers/video/imsttfb.c	Wed Nov 14 23:36:11 2001
@@ -1977,7 +1977,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -Nur linux-2.4.15-pre4/drivers/video/macfb.c linux-2.4.15-pre4-rs/drivers/video/macfb.c
--- linux-2.4.15-pre4/drivers/video/macfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/macfb.c	Wed Nov 14 23:36:11 2001
@@ -848,7 +848,7 @@
 	if (!options || !*options)
 		return;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -Nur linux-2.4.15-pre4/drivers/video/matrox/matroxfb_base.c linux-2.4.15-pre4-rs/drivers/video/matrox/matroxfb_base.c
--- linux-2.4.15-pre4/drivers/video/matrox/matroxfb_base.c	Wed Nov 14 23:34:11 2001
+++ linux-2.4.15-pre4-rs/drivers/video/matrox/matroxfb_base.c	Wed Nov 14 23:36:11 2001
@@ -2372,7 +2372,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		dprintk("matroxfb_setup: option %s\n", this_opt);
diff -Nur linux-2.4.15-pre4/drivers/video/platinumfb.c linux-2.4.15-pre4-rs/drivers/video/platinumfb.c
--- linux-2.4.15-pre4/drivers/video/platinumfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/platinumfb.c	Wed Nov 14 23:36:11 2001
@@ -841,7 +841,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -Nur linux-2.4.15-pre4/drivers/video/radeonfb.c linux-2.4.15-pre4-rs/drivers/video/radeonfb.c
--- linux-2.4.15-pre4/drivers/video/radeonfb.c	Wed Nov 14 23:34:11 2001
+++ linux-2.4.15-pre4-rs/drivers/video/radeonfb.c	Wed Nov 14 23:36:11 2001
@@ -642,7 +642,9 @@
         if (!options || !*options)
                 return 0;
  
-	while (this_opt = strsep (&options, ",")) {
+	while ((this_opt = strsep (&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
                 if (!strncmp (this_opt, "font:", 5)) {
                         char *p;
                         int i;
diff -Nur linux-2.4.15-pre4/drivers/video/retz3fb.c linux-2.4.15-pre4-rs/drivers/video/retz3fb.c
--- linux-2.4.15-pre4/drivers/video/retz3fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/retz3fb.c	Wed Nov 14 23:36:11 2001
@@ -1348,7 +1348,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			z3fb_inverse = 1;
 			fb_invert_cmaps();
diff -Nur linux-2.4.15-pre4/drivers/video/riva/fbdev.c linux-2.4.15-pre4-rs/drivers/video/riva/fbdev.c
--- linux-2.4.15-pre4/drivers/video/riva/fbdev.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/riva/fbdev.c	Wed Nov 14 23:36:11 2001
@@ -2045,7 +2045,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -Nur linux-2.4.15-pre4/drivers/video/sa1100fb.c linux-2.4.15-pre4-rs/drivers/video/sa1100fb.c
--- linux-2.4.15-pre4/drivers/video/sa1100fb.c	Thu Nov  8 22:51:16 2001
+++ linux-2.4.15-pre4-rs/drivers/video/sa1100fb.c	Wed Nov 14 23:36:11 2001
@@ -2369,7 +2369,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 
 		if (!strncmp(this_opt, "bpp:", 4))
 			current_par.max_bpp =
diff -Nur linux-2.4.15-pre4/drivers/video/sgivwfb.c linux-2.4.15-pre4-rs/drivers/video/sgivwfb.c
--- linux-2.4.15-pre4/drivers/video/sgivwfb.c	Wed Nov 14 23:34:11 2001
+++ linux-2.4.15-pre4-rs/drivers/video/sgivwfb.c	Wed Nov 14 23:36:11 2001
@@ -863,7 +863,7 @@
   if (!options || !*options)
     return 0;
 
-  while (this_opt = strsep(&options, ",")) {
+  while ((this_opt = strsep(&options, ",")) != NULL) {
     if (!strncmp(this_opt, "font:", 5))
       strcpy(fb_info.fontname, this_opt+5);
   }
diff -Nur linux-2.4.15-pre4/drivers/video/sstfb.c linux-2.4.15-pre4-rs/drivers/video/sstfb.c
--- linux-2.4.15-pre4/drivers/video/sstfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/sstfb.c	Wed Nov 14 23:36:11 2001
@@ -1697,7 +1697,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		f_ddprintk("option %s\n", this_opt);
diff -Nur linux-2.4.15-pre4/drivers/video/tdfxfb.c linux-2.4.15-pre4-rs/drivers/video/tdfxfb.c
--- linux-2.4.15-pre4/drivers/video/tdfxfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/tdfxfb.c	Wed Nov 14 23:36:11 2001
@@ -2086,7 +2086,9 @@
   if(!options || !*options)
     return;
 
-  while(this_opt = strsep(&options, ",")) {
+  while((this_opt = strsep(&options, ",")) != NULL) {
+    if(!*this_opt)
+      continue;
     if(!strcmp(this_opt, "inverse")) {
       inverse = 1;
       fb_invert_cmaps();
diff -Nur linux-2.4.15-pre4/drivers/video/tgafb.c linux-2.4.15-pre4-rs/drivers/video/tgafb.c
--- linux-2.4.15-pre4/drivers/video/tgafb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/tgafb.c	Wed Nov 14 23:36:11 2001
@@ -889,7 +889,7 @@
     int i;
     
     if (options && *options) {
-    	while (this_opt = strsep(&options, ",")) {
+    	while ((this_opt = strsep(&options, ",")) != NULL) {
        	    if (!*this_opt) { continue; }
         
 	    if (!strncmp(this_opt, "font:", 5)) {
diff -Nur linux-2.4.15-pre4/drivers/video/valkyriefb.c linux-2.4.15-pre4-rs/drivers/video/valkyriefb.c
--- linux-2.4.15-pre4/drivers/video/valkyriefb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/valkyriefb.c	Wed Nov 14 23:36:11 2001
@@ -801,7 +801,7 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "font:", 5)) {
 			char *p;
 			int i;
diff -Nur linux-2.4.15-pre4/drivers/video/vesafb.c linux-2.4.15-pre4-rs/drivers/video/vesafb.c
--- linux-2.4.15-pre4/drivers/video/vesafb.c	Wed Nov 14 23:34:12 2001
+++ linux-2.4.15-pre4-rs/drivers/video/vesafb.c	Wed Nov 14 23:36:11 2001
@@ -457,7 +457,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 		
 		if (! strcmp(this_opt, "inverse"))
diff -Nur linux-2.4.15-pre4/drivers/video/vfb.c linux-2.4.15-pre4-rs/drivers/video/vfb.c
--- linux-2.4.15-pre4/drivers/video/vfb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/vfb.c	Wed Nov 14 23:36:11 2001
@@ -382,7 +382,7 @@
     if (!options || !*options)
 	return 0;
 
-    while (this_opt = strsep(&options, ",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!strncmp(this_opt, "font:", 5))
 	    strcpy(fb_info.fontname, this_opt+5);
     }
diff -Nur linux-2.4.15-pre4/drivers/video/vga16fb.c linux-2.4.15-pre4-rs/drivers/video/vga16fb.c
--- linux-2.4.15-pre4/drivers/video/vga16fb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/vga16fb.c	Wed Nov 14 23:36:11 2001
@@ -692,7 +692,7 @@
 	if (!options || !*options)
 		return 0;
 	
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 		
 		if (!strncmp(this_opt, "font:", 5))
diff -Nur linux-2.4.15-pre4/drivers/video/virgefb.c linux-2.4.15-pre4-rs/drivers/video/virgefb.c
--- linux-2.4.15-pre4/drivers/video/virgefb.c	Fri Oct 26 23:07:21 2001
+++ linux-2.4.15-pre4-rs/drivers/video/virgefb.c	Wed Nov 14 23:36:11 2001
@@ -1085,7 +1085,9 @@
 	if (!options || !*options)
 		return 0;
 
-	while (this_opt = strsep(&options, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
 		if (!strcmp(this_opt, "inverse")) {
 			Cyberfb_inverse = 1;
 			fb_invert_cmaps();
