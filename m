Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUBBVLD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUBBVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:11:03 -0500
Received: from witte.sonytel.be ([80.88.33.193]:47281 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265835AbUBBVJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:09:35 -0500
Date: Mon, 2 Feb 2004 22:08:48 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kronos <kronos@kronoz.cjb.net>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
In-Reply-To: <20040202200344.GK6785@dreamland.darkstar.lan>
Message-ID: <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be>
References: <20040130204956.GA21643@dreamland.darkstar.lan>
 <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
 <20040202200344.GK6785@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Feb 2004, Kronos wrote:
> siimage.c:65: warning: control reaches end of non-void function
>
> The last statement before the end is BUG(), but I added a return to
> silence the warning.
>
> diff -Nru -X dontdiff linux-2.4-vanilla/drivers/ide/pci/siimage.c linux-2.4/drivers/ide/pci/siimage.c
> --- linux-2.4-vanilla/drivers/ide/pci/siimage.c	Tue Nov 11 17:51:38 2003
> +++ linux-2.4/drivers/ide/pci/siimage.c	Sat Jan 31 19:07:56 2004
> @@ -62,6 +62,9 @@
>  			return 0;
>  	}
>  	BUG();
> +
> +	/* gcc will complain */
> +	return 0;
>  }

What about adding `attribute ((noreturn))' to the declaration of BUG() instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
