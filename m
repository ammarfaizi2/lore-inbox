Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760379AbWLFJfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760379AbWLFJfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 04:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760381AbWLFJfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 04:35:25 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:49545 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760379AbWLFJfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 04:35:24 -0500
Date: Wed, 6 Dec 2006 10:35:21 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jeff Dike <jdike@addtoit.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `make checkstack' and cross-compilation
In-Reply-To: <20061205181017.GA5666@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.62.0612061034340.20037@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0612011455040.19178@pademelon.sonytel.be>
 <20061201153021.GA4332@ccure.user-mode-linux.org>
 <Pine.LNX.4.62.0612011708550.30940@pademelon.sonytel.be>
 <20061205181017.GA5666@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Jeff Dike wrote:
> On Fri, Dec 01, 2006 at 05:09:17PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 1 Dec 2006, Jeff Dike wrote:
> > > And, do you have a cross-compilation environment which tests this?
> > 
> > Yes :-)
> 
> Can you test this patch?  It works for UML and native x86_64 - if it works
> for your cross-build, I'll send it in.

Thanks, works fine for cross-compiling for powerpc.

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

> Index: linux-2.6.18-mm/Makefile
> ===================================================================
> --- linux-2.6.18-mm.orig/Makefile	2006-11-24 14:36:32.000000000 -0500
> +++ linux-2.6.18-mm/Makefile	2006-12-05 13:08:20.000000000 -0500
> @@ -1390,12 +1390,18 @@ endif #ifeq ($(mixed-targets),1)
>  
>  PHONY += checkstack kernelrelease kernelversion
>  
> -# Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
> -# In the UML case, $(SUBARCH) is the name of the underlying
> -# architecture, while for all other arches, it is the same as $(ARCH).
> +# UML needs a little special treatment here.  It wants to use the host
> +# toolchain, so needs $(SUBARCH) passed to checkstack.pl.  Everyone
> +# else wants $(ARCH), including people doing cross-builds, which means
> +# that $(SUBARCH) doesn't work here.
> +ifeq ($(ARCH), um)
> +CHECKSTACK_ARCH := $(SUBARCH)
> +else
> +CHECKSTACK_ARCH := $(ARCH)
> +endif
>  checkstack:
>  	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> -	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
> +	$(PERL) $(src)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
>  
>  kernelrelease:
>  	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
