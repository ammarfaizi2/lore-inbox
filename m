Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVAPJXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVAPJXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 04:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVAPJXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 04:23:24 -0500
Received: from witte.sonytel.be ([80.88.33.193]:54193 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262464AbVAPJWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 04:22:55 -0500
Date: Sun, 16 Jan 2005 10:22:43 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Cross-compilation broken (was: Re: Linux 2.6.11-rc1)
In-Reply-To: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.61.0501161016240.25137@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2005, Linus Torvalds wrote:
> Sam Ravnborg:
>   o kbuild: Use -isystem `gcc --print-file-name=include`

This change broke cross-compilation for me.

It causes /usr/lib/gcc-lib/i486-linux/3.3.5/include/stdarg.h to be picked up
instead of /usr/local/lib/gcc-lib/m68k-linux/2.95.2/include/stdarg.h.

Changing

| NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)

to

| NOSTDINC_FLAGS = -nostdinc -isystem $(shell $(CC) -print-file-name=include)

fixed it. I guess it picked up the definition for $(CC) before it became
$(CROSS_COMPILE)gcc.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
