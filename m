Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVEBBmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVEBBmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVEBBmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:42:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:30110 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261612AbVEBBme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:42:34 -0400
Subject: [PATCH] ppc32: Small build fix for alsa powermac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Mon, 02 May 2005 11:40:30 +1000
Message-Id: <1114998030.7112.364.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

My newer iMac mini driver doesn't build with verbose debug enabled. This
fixes it, and removes an erroneous error printk (since it's normal on
some machine to not find some gpios on the "first try").

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/sound/ppc/toonie.c
===================================================================
--- linux-work.orig/sound/ppc/toonie.c	2005-05-02 10:51:00.000000000 +1000
+++ linux-work/sound/ppc/toonie.c	2005-05-02 11:38:22.000000000 +1000
@@ -279,8 +279,7 @@
 	if (! base) {
 		base = (u32 *)get_property(np, "reg", NULL);
 		if (!base) {
-			DBG("(E) cannot find address for device %s !\n", device);
-			snd_printd("cannot find address for device %s\n", device);
+			DBG("(E) cannot find address for device %s !\n", name);
 			return -ENODEV;
 		}
 		addr = *base;


