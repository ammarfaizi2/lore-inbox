Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUDMIiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDMIiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:38:11 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:1313 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S263177AbUDMIiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:38:05 -0400
Date: Tue, 13 Apr 2004 10:37:57 +0200
Message-Id: <200404130837.i3D8bvjH018417@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       kai@germaschewski.name, sam@ravnborg.org
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 424] Zorro devlist.h kbuild
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro: Quieten building of devlist.h (cfr. PCI)

--- linux-2.6.5-rc2/drivers/zorro/Makefile	2004-02-17 13:54:50.000000000 +0100
+++ linux-m68k-2.6.5-rc2/drivers/zorro/Makefile	2004-03-21 12:00:27.000000000 +0100
@@ -12,10 +12,11 @@
 clean-files := devlist.h
 
 # Dependencies on generated files need to be listed explicitly
-
 $(obj)/names.o: $(obj)/devlist.h
 
 # And that's how to generate them
-
+quiet_cmd_devlist = DEVLIST $@
+      cmd_devlist = ( cd $(obj); ./gen-devlist ) < $<
 $(obj)/devlist.h: $(src)/zorro.ids $(obj)/gen-devlist
-	( cd $(obj); ./gen-devlist ) < $<
+	$(call cmd,devlist)
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
