Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270263AbTGNLHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270279AbTGNLHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:07:13 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:11712 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270263AbTGNLHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:07:08 -0400
Date: Mon, 14 Jul 2003 13:20:46 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       William Lee Irwin III <wli@holomorphy.com>
cc: James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: kmap_types.h (was: Re: Linux 2.4.22-pre3)
In-Reply-To: <20030714100319.GG15452@holomorphy.com>
Message-ID: <Pine.GSO.4.21.0307141316360.20906-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, William Lee Irwin III wrote:
> On Sat, 5 Jul 2003, Marcelo Tosatti wrote:
> >>   o [CRYPTO-2.4]: Add dummy kmap_types.h header for sparc64
> 
> On Mon, Jul 14, 2003 at 11:55:40AM +0200, Geert Uytterhoeven wrote:
> > What are the actual purpose and semantics of the KM_* types? I need to add them
> > for m68k to make crypto compile.
> > Gr{oetje,eeting}s,
> > 						Geert
> 
> They're per-cpu virtualspace reservations for predetermined purposes.
> It's for a variant of kmap() usable under spinlocks and in interrupt
> handlers. If you don't have highmem, you just don't care.

OK, in that case the one below (copied from PPC/SPARC64) should work fine.
Marcelo, please apply. Thx!

---snip---

M68k: Add <asm/kmap_types.h>

--- linux-2.4.x/include/asm-m68k/kmap_types.h	Tue Jun 24 14:30:53 2003
+++ linux-m68k-2.4.x/include/asm-m68k/kmap_types.h	Wed Jul  9 17:27:49 2003
@@ -0,0 +1,18 @@
+#ifdef __KERNEL__
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BH_IRQ,
+	KM_SOFTIRQ0,
+	KM_SOFTIRQ1,
+	KM_TYPE_NR
+};
+
+#endif
+#endif /* __KERNEL__ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

