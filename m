Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbTAaJgD>; Fri, 31 Jan 2003 04:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbTAaJgD>; Fri, 31 Jan 2003 04:36:03 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:32390 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267739AbTAaJgC>; Fri, 31 Jan 2003 04:36:02 -0500
Message-Id: <200301310941.h0V9fa89002888@eeyore.valparaiso.cl>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: Your message of "Fri, 31 Jan 2003 00:23:56 CST."
             <Pine.LNX.4.44.0301302351550.15587-100000@chaos.physics.uiowa.edu> 
Date: Fri, 31 Jan 2003 10:41:36 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> said:
> On Fri, 31 Jan 2003, Rusty Russell wrote:
> 
> > This patch adds MODULE_ALIAS("foo") capability, and uses it to
> > automatically generate sensible aliases from device tables.  The
> > post-processing is a little rough, but works.

I fail to see why a module would have to declare aliases for itself.
Aliases are an userspace/after boot problem (i.e., which one is eth0?,
etc), so this means having _two_ (three?) ways of getting the same kind of
info (in-module/in-kernel, /etc/module.somethingortheother). Not nice.

> > Name: Module alias and device table support
> > Author: Rusty Russell
> > Status: Tested on 2.5.59
> > 
> > D: Introduces "MODULE_ALIAS" which modules can use to embed their own
> > D: aliases for modprobe to use.  Also adds a "finishing" step to modules to
> > D: supplement their aliases based on MODULE_TABLE declarations, eg.
> > D: 'usb:v0506p4601dl*dh*dc*dsc*dp*ic*isc*ip*' for drivers/usb/net/pegasus.o
> 
> Some comments:
> o First of all, we're basically moving depmod functionality into the 
>   kernel tree, which I regard as a good thing, since we have to deal
>   with actual kernel structures here. (The obvious disadvantage is that
>   this makes it much easier to change these kernel structures, which
>   breaks compatibility with other (user space) tools who expect a certain
>   format)

It doesn't "move", it "replicates into". Not nice at all.

[...]

> o I think it'd be a good time to consider naming these sections e.g.
>   "__discard.modalias", the license one "__discard.license" and have
>   the kernel module loader discard "__discard*", so that it doesn't
>   need to be aware of all that special crap, nor waste space for it. 
>   (Well, it needs to know about the license, anyway, so that's not such
>   a good example).

Good idea.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
