Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbTH2Oul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTH2Oul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:50:41 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:24666 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261278AbTH2Ouh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:50:37 -0400
Date: Fri, 29 Aug 2003 16:49:44 +0200
Message-Id: <200308291449.h7TEniOx005821@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, perex@suse.cz
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Isapnp warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isapnp: Kill warning if CONFIG_PCI is not set, like it's done in 2.6.0.

--- linux-2.4.23-pre1/drivers/pnp/isapnp.c	Sat Aug 17 14:10:39 2002
+++ linux-m68k-2.4.23-pre1/drivers/pnp/isapnp.c	Fri Jun  6 12:27:42 2003
@@ -510,7 +510,6 @@
                                                int dependent, int size)
 {
 	unsigned char tmp[3];
-	int i;
 	struct isapnp_irq *irq, *ptr;
 
 	isapnp_peek(tmp, size);
@@ -538,9 +537,13 @@
 	else
 		(*res)->irq = irq;
 #ifdef CONFIG_PCI
-	for (i=0; i<16; i++)
-		if (irq->map & (1<<i))
-			pcibios_penalize_isa_irq(i);
+	{
+		int i;
+
+		for (i=0; i<16; i++)
+			if (irq->map & (1<<i))
+				pcibios_penalize_isa_irq(i);
+	}
 #endif
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
