Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265693AbUFUBmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUFUBmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFUBmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:42:45 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:14473 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265693AbUFUBlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:41:50 -0400
Date: Mon, 21 Jun 2004 03:41:33 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: sam@ravnborg.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
Message-ID: <20040621014133.GA29747@vana.vc.cvut.cz>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620212353.GD10189@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620212353.GD10189@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:23:53PM +0200, Sam Ravnborg wrote:
>  # If System.map exists, run depmod.  This deliberately does not have a
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
> +

In addition to what Arjan said - If you insist on doing it this way,
it would be nice if that generated Makefile could contain also

VERSION = 2
PATCHLEVEL = 6

so I can detect (by grepping that Makefile - or by some other method which
works on 2.0 - 2.6 kernels) which kbuild system I should use - whether 2.6.x, 
or 2.4.x, or standalone makefile for 2.2.x and 2.0.x. I see 
no way how to find what Makefile I should prepare for this thing.

Other possible solution is that you'll guarantee that this is last version
which will be ever invented. But you probably cannot guarantee this,
so some version number is needed.
						Thanks,
							Petr Vandrovec

