Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSHBDPj>; Thu, 1 Aug 2002 23:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSHBDPj>; Thu, 1 Aug 2002 23:15:39 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:25533 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317947AbSHBDPi>; Thu, 1 Aug 2002 23:15:38 -0400
Date: Thu, 1 Aug 2002 22:19:04 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] automatic module_init ordering
In-Reply-To: <E17aPjw-0007zG-00@scrub.xs4all.nl>
Message-ID: <Pine.LNX.4.44.0208012156460.24984-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Roman Zippel wrote:

> This is latest version of the automatic module_init ordering patch.
> IMO the patch is almost ready. A bit annoying problem is that
> -DKBUILD_MODNAME=unix becomes -DKBUILD_MODNAME=1. An undef helps
> of course, but I'm not sure whether we should put it on the command
> line or in the source.
> This patch depends on Kai's KBUILD_MODNAME patch.
> Kai, do you see any possible kbuild problem left? I hope I found
> everything. :)

> +	for o in $(sort $(local-objs-y)); do \
> +	  if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then \
> +	    echo $$o; \
> +	  fi \
> +	done > $@; \
> +	for s in $(sort $(subdir-y)); do \
> +	  sed "s,^,$$s/," < $$s/.builtin_mods; \
> +	done >> $@

I had to replace this with

	for o in `echo $(sort $(local-objs-y))`; do \

and the like, since otherwise my shell (bash) would complain about an
empty "for o in ; do". Maybe there's a less hacky way to handle that? 

BTW, it'd be also nice if scripts/build-initcalls would add some \n's to
init/generated-initcalls.c ;)

The "unix" thing is stupid. The obvious way around that is 
-DKBUILD_MODNAME="unix", but unfortunately, I don't know of any 
"unstringify" preprocessing function, so that doesn't work easily, either.

Well, I cannot think of a nicer solution there (and I tried ;), other than
these small issues things look very nice, though.

--Kai


