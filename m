Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbUJ0XfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbUJ0XfC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUJ0XdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:33:07 -0400
Received: from witte.sonytel.be ([80.88.33.193]:42976 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262713AbUJ0UvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:51:00 -0400
Date: Wed, 27 Oct 2004 22:50:50 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Create Makefile in output dir for *config targets
In-Reply-To: <200410271808.i9RI8mQA032003@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0410272248430.25486@waterleaf.sonytel.be>
References: <200410271808.i9RI8mQA032003@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2004, Linux Kernel Mailing List wrote:
> --- a/Makefile	2004-10-27 11:08:59 -07:00
> +++ b/Makefile	2004-10-27 11:08:59 -07:00
> @@ -379,6 +379,18 @@
>  scripts_basic:
>  	$(Q)$(MAKE) $(build)=scripts/basic
>  
> +.PHONY: outputmakefile
> +# outputmakefile generate a Makefile to be placed in output directory, if
> +# using a seperate output directory. This allows convinient use
                                                    ^^^^^^^^^^
						    convenient
> +# of make in output directory
> +outputmakefile:
> +	$(Q)if /usr/bin/env test ! $(srctree) -ef $(objtree); then \
> +	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile              \
> +	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)         \
> +	    > $(objtree)/Makefile;                                 \
> +	    echo '  GEN    $(objtree)/Makefile';                   \
> +	fi
> +

BTW, at least in 2.6.10-rc1 there's still something wrong with dependencies
when doing:

    make dir/file.o

or

    make dir/

in the output directory. The full `make' does seem to care about all
dependencies.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
