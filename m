Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUFSANq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUFSANq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUFRUxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:53:17 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62922 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262085AbUFRUtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:49:46 -0400
Date: Fri, 18 Jun 2004 22:49:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cross-sparse
In-Reply-To: <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0406182245540.23356@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Linus Torvalds wrote:
> On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:
> > I wanted to give sparse a try on m68k, and noticed the current infrastructure
> > doesn't handle cross-compilation (no sane m68k people compile kernels natively
> > anymore, unless they run a Debian autobuilder ;-).
> >
> > After hacking the include paths in the sparse sources, installing the resulting
> > binary as m68k-linux-sparse, and applying the following patch, it seems to work
> > fine!
>
> Hmm.. It does make sense, but at the same time, sparse isn't even really
> supposed to _care_ about the architecture. Especially not for a kernel
> build.
>
> Which part breaks when not just using the native sparse? As far as I know,
> a kernel build should use all-kernel header files, with the exception of
> "stdarg.h" which I thought was also architecture-independent (but hey,
> maybe I'm just a retard, and am wrong).

IIRC, actually the first error I got when using the native sparse was that it
couldn't find stdarg.h.

And even the non-native sparse doesn't know about architecture-specific defines
like __mc68000__, causing some code paths being wrong. Guess I have to replace
them by e.g. CONFIG_M68K.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
