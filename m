Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTIXK0b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 06:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTIXK0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 06:26:31 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:47036 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261156AbTIXK0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 06:26:30 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] shut up gcc 3.3 for scripts/pnmtologo.c
Date: Wed, 24 Sep 2003 12:29:06 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309241229.06708@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch makes some ints to unsigned ints. They are only used as loop
counters and compared to unsigned ints. GCC 3.3 doesn't like this. They will
never be negative anyway, so we could easily shut him up.

Eike

--- linux-2.6.0-test5-bk6/scripts/pnmtologo.c	2003-09-11 10:18:23.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/scripts/pnmtologo.c	2003-09-21 09:32:38.000000000 +0200
@@ -119,7 +119,8 @@
 static void read_image(void)
 {
     FILE *fp;
-    int i, j, magic;
+    unsigned int i, j;
+    int magic;
     unsigned int maxval;
 
     /* open image file */
@@ -274,7 +275,7 @@
 
 static void write_logo_mono(void)
 {
-    int i, j;
+    unsigned int i, j;
     unsigned char val, bit;
 
     /* validate image */
@@ -302,7 +303,7 @@
 
 static void write_logo_vga16(void)
 {
-    int i, j, k;
+    unsigned int i, j, k;
     unsigned char val;
 
     /* validate image */
@@ -342,7 +343,7 @@
 
 static void write_logo_clut224(void)
 {
-    int i, j, k;
+    unsigned int i, j, k;
 
     /* validate image */
     for (i = 0; i < logo_height; i++)
@@ -388,7 +389,7 @@
 
 static void write_logo_gray256(void)
 {
-    int i, j;
+    unsigned int i, j;
 
     /* validate image */
     for (i = 0; i < logo_height; i++)
