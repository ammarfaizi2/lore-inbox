Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVKHTqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVKHTqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVKHTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:46:50 -0500
Received: from digitalimplant.org ([64.62.235.95]:52374 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932308AbVKHTqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:46:49 -0500
Date: Tue, 8 Nov 2005 11:46:33 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, "" <tony.luck@gmail.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] kill include/linux/platform.h
In-Reply-To: <20051103182358.GF23366@stusta.de>
Message-ID: <Pine.LNX.4.50.0511081144320.7816-100000@monsoon.he.net>
References: <20050902205204.GU3657@stusta.de> <Pine.LNX.4.50.0509291106520.29808-100000@monsoon.he.net>
 <20051001233414.GG4212@stusta.de> <12c511ca0510031201x1f66300bucaff6410e7b675bb@mail.gmail.com>
 <20051003190345.GH3652@stusta.de> <12c511ca0510031407i5266cf4ak5082ec54f60a3d17@mail.gmail.com>
 <20051003215053.GI3652@stusta.de> <20051010112341.7bb116ae.akpm@osdl.org>
 <20051103182358.GF23366@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Nov 2005, Adrian Bunk wrote:

> On Mon, Oct 10, 2005 at 11:23:41AM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > On Mon, Oct 03, 2005 at 02:07:12PM -0700, Tony Luck wrote:
> > >  > > The default_idle() prototype should stay inside some header file.
> > >  >
> > >  > That would be best, yes.
> > >  >
> > >  > > @Patrick:
> > >  > > Any suggestion where it should move to?
> > >  >
> > >  > Of the include files already included directly by arch/ia64/kernel/setup.c,
> > >  > <linux/sched.h> looks the most promising.  There's lots of .*idle.* things
> > >  > already in there.
> > >  >
> > >  > Looking at existing precedent: ppc64 has a definition of default_idle()
> > >  > in <asm/machdep.h>
> > >
> > >  The question whether linux/ or asm/ is the best place for the definition
> > >  boils down to the question whether it is expected that default_idle() is
> > >  present on all architectures or whether it's an architecture-specific
> > >  implementation detail.
> >
> > Yes, default_idle() is arch-specific and so its prototype should be in an
> > arch-specific header.
> >
> > All the implementations happen to have the same signature, so it's tempting
> > to put the prototype into some generic header, but given that there's no
> > non-arch-specific caller, we shouldn't do that.
>
> ppc64 has the prototype in machdep.h.
>
> The only other architectures that seem to require a non-static
> default_idle() are cris, i386 and ia64.
>
> Any hint which header file would suit best?

It seems that include/asm-{$arch}/idle.h would suffice. Any objections to
that?



	Pat


