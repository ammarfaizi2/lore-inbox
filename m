Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132502AbRDDWZh>; Wed, 4 Apr 2001 18:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDDWZ2>; Wed, 4 Apr 2001 18:25:28 -0400
Received: from wpk-smtp-relay2.cwci.net ([195.44.63.19]:28563 "EHLO
	wpk-smtp-relay.cwci.net") by vger.kernel.org with ESMTP
	id <S132502AbRDDWZK>; Wed, 4 Apr 2001 18:25:10 -0400
Date: Wed, 4 Apr 2001 23:25:12 +0100
Message-Id: <200104042225.f34MPCv00980@Xerxes.buttmunch>
From: Stuart McFadden <stuartymcf@netgames-uk.com>
To: linux-kernel@vger.kernel.org
Subject: Underscore in rivafb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The flashing block in rivafb was annoying me, so here is a diff (against 
vanilla 2.4.3 ) of a quick hack in case anyone else was having the same problem.

Stuarty,

diff -urN linux.pure/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux.pure/drivers/video/riva/fbdev.c	Wed Apr  4 22:34:19 2001
+++ linux/drivers/video/riva/fbdev.c	Wed Apr  4 22:26:43 2001
@@ -534,7 +534,7 @@
 	struct riva_cursor *c = rinfo->cursor;
 	int i, j, idx;
 
-	if (c) {
+  	if (c) {
 		if (width <= 0 || height <= 0) {
 			width = 8;
 			height = 16;
@@ -547,13 +547,16 @@
 		
 		idx = 0;
 
-		for (i = 0; i < height; i++) {
-			for (j = 0; j < width; j++,idx++)
-				c->image[idx] = CURSOR_COLOR;
-			for (j = width; j < MAX_CURS; j++,idx++)
+		for (i = MAX_CURS; i > height + 2; i--) 
+			for (j = 0; j < MAX_CURS; j++,idx++)
 				c->image[idx] = TRANSPARENT_COLOR;
+		for (i = height + 2; i > height; i--) {
+			for (j = 0; j < width; j++,idx++)
+			        c->image[idx] = CURSOR_COLOR;
+			for (j = width; j < MAX_CURS;j++,idx++)
+			        c->image[idx] = TRANSPARENT_COLOR;
 		}
-		for (i = height; i < MAX_CURS; i++)
+		for (i = height; i > 0; i--) 
 			for (j = 0; j < MAX_CURS; j++,idx++)
 				c->image[idx] = TRANSPARENT_COLOR;
 	}



-- 
Start the day with a smile.  After that you can be your nasty old self again.
 - - - - - - - - - - - - - - - - - - - - -  
Stuarty McFadden stuartymcf@netgames-uk.com 
