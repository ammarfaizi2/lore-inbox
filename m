Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUJOIu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUJOIu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 04:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUJOIu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 04:50:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:40072 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266538AbUJOIux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 04:50:53 -0400
Date: Fri, 15 Oct 2004 10:49:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: blaisorblade_spam@yahoo.it
cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       User-mode Linux Kernel Development 
	<user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [uml-devel] [patch 1/1] uml: readd linux Makefile target
In-Reply-To: <20041014220554.0F20244BE@zion.localdomain>
Message-ID: <Pine.GSO.4.61.0410151047270.10040@waterleaf.sonytel.be>
References: <20041014220554.0F20244BE@zion.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004 blaisorblade_spam@yahoo.it wrote:
> Since people are used to doing "make linux ARCH=um" and to use "linux" as the
> kernel image, make it be an hard link to vmlinux. This should hurt the less
> possible the users (actually nothing) while not slowing down the build.
> 
> Acked-by: Jeff Dike <jdike@addtoit.com>
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  linux-2.6.9-current-paolo/arch/um/Makefile |   12 ++++++++++++
>  1 files changed, 12 insertions(+)
> 
> diff -puN arch/um/Makefile~uml-readd-linux-target arch/um/Makefile
> --- linux-2.6.9-current/arch/um/Makefile~uml-readd-linux-target	2004-10-14 22:52:47.274383552 +0200
> +++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-14 22:52:47.276383248 +0200
> @@ -62,6 +62,18 @@ ifeq ($(CONFIG_MODE_SKAS), y)
>  $(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
>  endif
>  
> +all: linux
> +
> +linux: vmlinux
> +	$(RM) $@
> +	ln $< $@
> +
> +define archhelp
> +  echo '* linux		- Binary kernel image (./linux) - for backward'
> +  echo '		   compatibility only: now you can simply run'
> +  echo '		   the vmlinux binary you find in the kernel root.'
> +endef
> +

What happens if you modify the kernel source and rebuild the kernel?
I guess vmlinux gets deleted and replaced, but linux is still the old kernel,
because there's no .phony rule for linux?

What about using a symbolic link instead? It will always point to the most
recent kernel.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
