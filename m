Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284636AbRLZR4O>; Wed, 26 Dec 2001 12:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284669AbRLZR4E>; Wed, 26 Dec 2001 12:56:04 -0500
Received: from ep09.kernel.pl ([212.160.181.1]:29459 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S284636AbRLZRzy>;
	Wed, 26 Dec 2001 12:55:54 -0500
Date: Wed, 26 Dec 2001 18:55:49 +0100 (CET)
From: Krzysztof Taraszka <dzimi@ep09.kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Little bug in 2.2.20/drivers/video
Message-ID: <Pine.LNX.4.43.0112261849310.29495-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I found little bug in 2.2.20 kernel source 
tree.
When I use CONFIG_FB_ATY=m it doesn't build atyfb.o, so this is my patch:

>>> -- cut here -- <<<
diff -urN linux.orig/drivers/video/Makefile
linux/drivers/video/Makefile
--- linux.orig/drivers/video/Makefile     Sun Mar 25 18:37:37 2001
+++ linux/drivers/video/Makefile   Wed Dec 26 15:58:08 2001
@@ -102,6 +102,10 @@

 ifeq ($(CONFIG_FB_ATY),y)
 L_OBJS += atyfb.o
+else
+  ifeq ($(CONFIG_FB_ATY),m)
+  M_OBJS += atyfb.o
+  endif
 endif

 ifeq ($(CONFIG_FB_ATY128),y)
>>> -- end here -- <<<

Krzysztof Taraszka      (dzimi@pld.org.pl)


