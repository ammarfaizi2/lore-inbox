Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317786AbSG2UL5>; Mon, 29 Jul 2002 16:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSG2UL5>; Mon, 29 Jul 2002 16:11:57 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:43020 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317786AbSG2UL4>; Mon, 29 Jul 2002 16:11:56 -0400
Date: Mon, 29 Jul 2002 22:14:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Patrick Mochel <mochel@osdl.org>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] automatic initcalls 
In-Reply-To: <Pine.LNX.4.44.0207291142120.22697-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0207292134480.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Jul 2002, Patrick Mochel wrote:

> > > -__initcall(spawn_ksoftirqd);
> > > +fs_initcall(spawn_ksoftirqd);
> >
> > See, this is exacly the kind of thing that makes me doubt that the
> > current "magic 7 initcall levels" are useful in the long term 8(
>
> I agree that that is abusing the interface. WTF does spawn_ksoftirqd have
> to do with filesystems?

Above is just a hack to get it working, I only moved it one level up,
instead of spending too much time on figuring out the complete
dependencies.

> The purpose of the initcall levels in the first place was to start
> removing the ugly conditional calls in init/main.c I looked at what was
> being called, and came up with names to describe what was being done at
> each phase. There happened to be seven of them.

I think we should separate module initialization from this, as these can
be automatically ordered, what the posted patch demonstrates.
The initcall mechanism would then only be needed to initialize core kernel
services, which can't be build as module.
I'm only interrested to get the module initialization right, because
otherwise I get problems with the new module interface. I want to avoid
to include an explicit ordering, but currently some modules make use of
that *_initcall is mapped to module_init if compiled as module (e.g. usb
or pcmcia).

bye, Roman

