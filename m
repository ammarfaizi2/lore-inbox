Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318405AbSGaRD3>; Wed, 31 Jul 2002 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318407AbSGaRD3>; Wed, 31 Jul 2002 13:03:29 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:34742 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S318405AbSGaRD2>; Wed, 31 Jul 2002 13:03:28 -0400
Date: Wed, 31 Jul 2002 12:06:52 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] automatic module_init ordering 
In-Reply-To: <20020731044324.2B39A451D@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207311201000.19799-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002, Rusty Russell wrote:

> My PARAM code actually maps - to _ in parameter parsing, for exactly
> this reason.  And only a complete idiot would put , in a module name,
> so I don't care 8)

Tell that to the author of 53c7,8xx.o ;)

> > - It's possible that objects are linked into more than one module - I 
> >   suppose this shouldn't be a problem, since these objects hopefully
> >   don't have a module_init() nor do they export symbols. Not sure if your
> >   patch did handle this.
> 
> There's one piece of code I know which is linked in three places, and
> has a module parameter (net/ipv4/netfilter/ip_conntrack_core.c, linked
> into ipfwadm.o ipchains.o and ip_conntrack.o.
> 
> As it happens, the configuration doesn't allow more than one to be
> built in (they can all be modules though), so it's not actually a
> problem even after parameter unification.

Hmmh, I think that'll need some testing. It will be fine if only one of 
the three is "y", the others being "n/undef". However, it looks like it's 
possible to have sth like "m/m/y", which would go wrong with the current 
approach.

--Kai


