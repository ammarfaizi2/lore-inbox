Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTH2O6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTH2O5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:57:45 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:36696 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261324AbTH2OwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:52:08 -0400
Date: Fri, 29 Aug 2003 16:51:15 +0200
Message-Id: <200308291451.h7TEpFPG005944@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound core fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmasound core fixes from Christoph Hellwig in 2.6.0:
  - Some exported symbols are declared __init - in the modular case this is
    freed before the other modules can call it..

--- linux-2.4.23-pre1/drivers/sound/dmasound/dmasound_core.c	Tue Aug 26 12:22:41 2003
+++ linux-m68k-2.4.23-pre1/drivers/sound/dmasound/dmasound_core.c	Wed Aug 27 18:46:28 2003
@@ -374,7 +374,7 @@
 	release:	mixer_release,
 };
 
-static void __init mixer_init(void)
+static void mixer_init(void)
 {
 #ifndef MODULE
 	int mixer_unit;
@@ -1339,7 +1339,7 @@
 #endif
 };
 
-static int __init sq_init(void)
+static int sq_init(void)
 {
 #ifndef MODULE
 	int sq_unit;
@@ -1556,7 +1556,7 @@
 	release:	state_release,
 };
 
-static int __init state_init(void)
+static int state_init(void)
 {
 #ifndef MODULE
 	int state_unit;
@@ -1575,7 +1575,7 @@
      *  This function is called by _one_ chipset-specific driver
      */
 
-int __init dmasound_init(void)
+int dmasound_init(void)
 {
 	int res ;
 #ifdef MODULE
@@ -1646,7 +1646,7 @@
 
 #else /* !MODULE */
 
-static int __init dmasound_setup(char *str)
+static int dmasound_setup(char *str)
 {
 	int ints[6], size;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
