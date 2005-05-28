Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVE1VjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVE1VjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVE1VjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 17:39:15 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.25]:26384 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261161AbVE1VjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 17:39:11 -0400
Date: Sat, 28 May 2005 23:39:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, David Airlie <airlied@linux.ie>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: [PATCH] DRM depends on ???
Message-ID: <Pine.LNX.4.62.0505282333210.5800@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


DRM depending on `AGP=n' is driving me crazy! How to make CONFIG_DRM not
eligible for selection on platforms that do not have AGP?

Since many of the core DRM files depend on PCI, add a dependency on PCI,
to minimize the damage.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.12-rc5/drivers/char/drm/Kconfig	2005-05-25 19:37:53.000000000 +0200
+++ linux-m68k-2.6.12-rc5/drivers/char/drm/Kconfig	2005-04-05 10:12:41.000000000 +0200
@@ -6,7 +6,7 @@
 #
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
-	depends on AGP || AGP=n
+	depends on (AGP || AGP=n) && PCI
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
