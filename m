Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTDMM7p (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTDMM7l (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:59:41 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:15653 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S263507AbTDMM5d (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:57:33 -0400
Date: Sun, 13 Apr 2003 15:06:33 +0200
Message-Id: <200304131306.h3DD6XQ3001331@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IDE updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k IDE updates: Add m68k-isms to the generic ide_fix_driveid()

--- linux-2.5.x/drivers/ide/ide-iops.c	Mon Sep 16 09:49:17 2002
+++ linux-m68k-2.5.x/drivers/ide/ide-iops.c	Wed Oct  2 23:01:40 2002
@@ -360,6 +360,23 @@
 	int i;
 	u16 *stringcast;
 
+#ifdef __mc68000__
+	if (!MACH_IS_AMIGA && !MACH_IS_MAC && !MACH_IS_Q40 && !MACH_IS_ATARI)
+		return;
+
+#ifdef M68K_IDE_SWAPW
+	if (M68K_IDE_SWAPW) {	/* fix bus byteorder first */
+		u_char *p = (u_char *)id;
+		u_char t;
+		for (i = 0; i < 512; i += 2) {
+			t = p[i];
+			p[i] = p[i+1];
+			p[i+1] = t;
+		}
+	}
+#endif
+#endif /* __mc68000__ */
+
 	id->config         = __le16_to_cpu(id->config);
 	id->cyls           = __le16_to_cpu(id->cyls);
 	id->reserved2      = __le16_to_cpu(id->reserved2);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
