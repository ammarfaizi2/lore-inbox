Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267219AbUG1PTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267219AbUG1PTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUG1PTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:19:43 -0400
Received: from witte.sonytel.be ([80.88.33.193]:27107 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267219AbUG1PTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:19:37 -0400
Date: Wed, 28 Jul 2004 17:18:47 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] fix zlib debug in ppc boot header
In-Reply-To: <20040728112222.GA7670@suse.de>
Message-ID: <Pine.GSO.4.58.0407281717120.20097@waterleaf.sonytel.be>
References: <20040728112222.GA7670@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, Olaf Hering wrote:
> @@ -85,16 +89,16 @@ extern char *z_errmsg[]; /* indexed by 1
>
>  /* Diagnostic functions */
>  #ifdef DEBUG_ZLIB
> -#  include <stdio.h>
> +#  include <nonstdio.h>
>  #  ifndef verbose
>  #    define verbose 0
>  #  endif
> -#  define Assert(cond,msg) {if(!(cond)) z_error(msg);}
> -#  define Trace(x) fprintf x
> -#  define Tracev(x) {if (verbose) fprintf x ;}
> -#  define Tracevv(x) {if (verbose>1) fprintf x ;}
> -#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
> -#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
> +#  define Assert(cond,msg) {if(!(cond)) printf(msg);}
> +#  define Trace(x) printf x
> +#  define Tracev(x) {if (verbose) printf x ;}
> +#  define Tracevv(x) {if (verbose>1) printf x ;}
> +#  define Tracec(c,x) {if (verbose && (c)) printf x ;}
> +#  define Tracecv(c,x) {if (verbose>1 && (c)) printf x ;}
>  #else
>  #  define Assert(cond,msg)
>  #  define Trace(x)
> @@ -311,7 +315,7 @@ int inflateReset(
>    z->msg = Z_NULL;
>    z->state->mode = z->state->nowrap ? BLOCKS : METHOD;
>    inflate_blocks_reset(z->state->blocks, z, &c);
> -  Trace((stderr, "inflate: reset\n"));
> +  Trace(("inflate: reset\n"));
>    return Z_OK;
>  }
>

Why don't you just define a fprintf() that throws away its first argument and
calls printf(), so you don't need to modify every caller of Trace*()?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
