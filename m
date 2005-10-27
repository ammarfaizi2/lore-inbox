Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVJ0Unh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVJ0Unh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVJ0Unh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:43:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27278 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932222AbVJ0Ung (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:43:36 -0400
Date: Thu, 27 Oct 2005 22:43:24 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Yuri Vasilevski <yvasilev@duke.math.cinvestav.mx>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Daniel Drake <dsd@gentoo.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Patch that allows >=2.6.12 kernel to build on nls free systems
In-Reply-To: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
Message-ID: <Pine.LNX.4.61.0510272235160.1387@scrub.home>
References: <20051026115014.2dbb0bfc@dune.math.cinvestav.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 26 Oct 2005, Yuri Vasilevski wrote:

> I have also made a bug report at kernel's bugzilla:
> http://bugzilla.kernel.org/show_bug.cgi?id=5501
> And there is a discussion about this problem in Gentoo's bugzilla:
> http://bugs.gentoo.org/show_bug.cgi?id=99810
> 
> diff -Naur linux-2.6.14_rc2.orig/scripts/kconfig/Makefile linux-2.6.14_rc2/scripts/kconfig/Makefile
> --- linux-2.6.14_rc2.orig/scripts/kconfig/Makefile	2005-11-06 04:13:01 +0000
> +++ linux-2.6.14_rc2/scripts/kconfig/Makefile	2005-11-18 03:52:03 +0000
> @@ -116,6 +116,15 @@
>  clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
>  		   .tmp_gtkcheck zconf.tab.c zconf.tab.h lex.zconf.c
>  
> +# Needed for systems without gettext
> +KBUILD_HAVE_NLS := $(shell \
> +     if echo "\#include <libint.h>" | $(HOSTCC) $(HOSTCFLAGS) -E - > /dev/null 2>&1 ; \
> +     then echo yes ; \
> +     else echo no ; fi)
> +ifeq ($(KBUILD_HAVE_NLS),no)
> +HOSTCFLAGS	+= -DKBUILD_NO_NLS
> +endif
> +
>  # generated files seem to need this to find local include files
>  HOSTCFLAGS_lex.zconf.o	:= -I$(src)
>  HOSTCFLAGS_zconf.tab.o	:= -I$(src)

Sam, I was wondering about this kind runtime configuration stuff, if we 
could cache the information and don't run the tests every time. 

bye, Roman
