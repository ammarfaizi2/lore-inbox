Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSGaEif>; Wed, 31 Jul 2002 00:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317748AbSGaEif>; Wed, 31 Jul 2002 00:38:35 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52928 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317743AbSGaEie>;
	Wed, 31 Jul 2002 00:38:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering 
In-reply-to: Your message of "Tue, 30 Jul 2002 21:33:32 EST."
             <Pine.LNX.4.44.0207302110570.19799-100000@chaos.physics.uiowa.edu> 
Date: Wed, 31 Jul 2002 13:26:09 +1000
Message-Id: <20020731044324.2B39A451D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0207302110570.19799-100000@chaos.physics.uiowa.edu> y
ou write:
> - It looks like with your current approach you can't have a ',' or '-' in
>   KBUILD_MODNAME - however, that means that KBUILD_MODNAME is not quite
>   right for passing module parameters for built-in modules on the command
>   line, it would be confusing to pass parameters for ide-cd as 
>   ide_cd.foo=whatever. So that part could use a little more thought.

My PARAM code actually maps - to _ in parameter parsing, for exactly
this reason.  And only a complete idiot would put , in a module name,
so I don't care 8)

> - It's possible that objects are linked into more than one module - I 
>   suppose this shouldn't be a problem, since these objects hopefully
>   don't have a module_init() nor do they export symbols. Not sure if your
>   patch did handle this.

There's one piece of code I know which is linked in three places, and
has a module parameter (net/ipv4/netfilter/ip_conntrack_core.c, linked
into ipfwadm.o ipchains.o and ip_conntrack.o.

As it happens, the configuration doesn't allow more than one to be
built in (they can all be modules though), so it's not actually a
problem even after parameter unification.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
