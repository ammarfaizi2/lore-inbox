Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266182AbUGLPnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUGLPnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUGLPnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:43:17 -0400
Received: from witte.sonytel.be ([80.88.33.193]:40892 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266182AbUGLPnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:43:04 -0400
Date: Mon, 12 Jul 2004 17:40:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Colin LEROY <colin@colino.net>
cc: michael@mihu.de, Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC on APUS development 
	<linux-apus-devel@lists.sourceforge.net>
Subject: Re: [PATCH] fix saa7146 compilation on 2.6.8-rc1
In-Reply-To: <0cee01c46825$4d9f2310$3cc8a8c0@epro.dom>
Message-ID: <Pine.GSO.4.58.0407121737400.17199@waterleaf.sonytel.be>
References: <20040712082545.GA416@jack.colino.net>
 <Pine.GSO.4.58.0407121718270.17199@waterleaf.sonytel.be>
 <0cee01c46825$4d9f2310$3cc8a8c0@epro.dom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Colin LEROY wrote:
> > On Mon, 12 Jul 2004 colin@colino.net wrote:
> > > this patch fixes a compilation error on 2.6.8-rc1. Here's the error:
> > > drivers/media/common/saa7146_video.c:3: conflicting types for `memory'
> > > include/asm-m68k/setup.h:365: previous declaration of `memory'
> > > make[3]: *** [drivers/media/common/saa7146_video.o] Error 1
> >
> > But there's nothing named plain `memory' in include/asm-m68k/setup.h?!?!?
> > Actually there never has been...
>
> Right, but (i should have specified, sorry), I compiled on ppc32, and there's
>
> #define m68k_num_memory num_memory
> #define m68k_memory memory
> #include <asm-m68k/setup.h
>
> in include/asm-ppc/setup.h.

Ah, didn't think of that (I should have known ;-)

Looks like the APUS code can need some clean up. E.g. arch/ppc/amiga/bootinfo.c
operates on both memory and m68k_memory, while they are identical due to
<asm/setup.h>...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
