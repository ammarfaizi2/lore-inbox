Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266165AbUFUJCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUFUJCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 05:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUFUJCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 05:02:05 -0400
Received: from witte.sonytel.be ([80.88.33.193]:57512 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266165AbUFUJCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 05:02:00 -0400
Date: Mon, 21 Jun 2004 11:01:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
In-Reply-To: <20040620212353.GD10189@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.58.0406211059030.6543@waterleaf.sonytel.be>
References: <20040620211905.GA10189@mars.ravnborg.org>
 <20040620212353.GD10189@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Sam Ravnborg wrote:
> #   1) When using a separate output directory create a small
> #      Makefile that is a simple wrapper, calling the Makefile
> #      in the kernel tree.
> #      - This allows the user to shift to the output directory
> #        and execute make.
> #      - The Makefile is also useful to document the location
> #        source used for the kernel

> diff -Nru a/scripts/mkmakefile b/scripts/mkmakefile
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/scripts/mkmakefile	2004-06-20 23:06:03 +02:00
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# Generates a small Makefile used in the root of the output
> +# directory, to allow make to be started from there.
> +# The Makefile also allow for more convinient build of external modules
> +
> +# Usage
> +# $1 - Kernel src directory
> +# $2 - Output directory
> +
> +
> +cat << EOF
> +
> +KERNELSRC    := $1
> +KERNELOUTPUT := $2
> +
> +MAKEFLAGS += --no-print-directory
> +
> +all:
> +	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
> +
> +%:
> +	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
> +
> +EOF

The generated Makefile looks sufficiently similar to the one I'm using, so I'm
wondering: Does it work if I say e.g. `make drivers/char/mem.o'? For me that
part never worked, but `make drivers/char/' does work.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
