Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVG2ROP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVG2ROP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVG2RMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:12:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19728 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262669AbVG2RL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:11:27 -0400
Date: Fri, 29 Jul 2005 18:11:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix sound/arm/Makefile for locality of reference
Message-ID: <20050729181122.F18249@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that sound/arm/Makefile is sanely organised so that additions
to it don't break all other patches out there.  This means I only
have to adjust the line numbers in my patch queue rather than having
to re-generate by hand those which touch this file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/sound/arm/Makefile linux/sound/arm/Makefile
--- orig/sound/arm/Makefile	Fri Jul 29 17:14:53 2005
+++ linux/sound/arm/Makefile	Fri Jul 29 18:08:41 2005
@@ -2,12 +2,14 @@
 # Makefile for ALSA
 #
 
-snd-sa11xx-uda1341-objs := sa11xx-uda1341.o
-snd-aaci-objs			:= aaci.o devdma.o
-snd-pxa2xx-pcm-objs := pxa2xx-pcm.o
-snd-pxa2xx-ac97-objs := pxa2xx-ac97.o
-
 obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-sa11xx-uda1341.o 
+snd-sa11xx-uda1341-objs		:= sa11xx-uda1341.o
+
 obj-$(CONFIG_SND_ARMAACI)	+= snd-aaci.o
-obj-$(CONFIG_SND_PXA2XX_PCM) += snd-pxa2xx-pcm.o
-obj-$(CONFIG_SND_PXA2XX_AC97) += snd-pxa2xx-ac97.o
+snd-aaci-objs			:= aaci.o devdma.o
+
+obj-$(CONFIG_SND_PXA2XX_PCM)	+= snd-pxa2xx-pcm.o
+snd-pxa2xx-pcm-objs		:= pxa2xx-pcm.o
+
+obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
+snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
