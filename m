Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUCOSGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUCOSEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:04:48 -0500
Received: from witte.sonytel.be ([80.88.33.193]:28385 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262662AbUCOSEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:04:08 -0500
Date: Mon, 15 Mar 2004 19:04:05 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Kai Germaschewski <kai@germaschewski.name>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] out-of-tree builds
In-Reply-To: <20040315175850.GA8456@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.58.0403151902190.14245@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0403141353470.1231@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0403151337120.14245@waterleaf.sonytel.be>
 <20040315175850.GA8456@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Sam Ravnborg wrote:
> On Mon, Mar 15, 2004 at 01:41:02PM +0100, Geert Uytterhoeven wrote:
> > Unfortunately not everything works.
> >
> > E.g. I need to build usr/ with a different (newer) binutils, so when the build
> > fails on assembling usr/initramfs_data.o, I used to do the following, which no
> > longer works:
> >
> > | tux$ PATH=/usr/bin/:$PATH make usr/
> > | make: `usr/' is up to date.
> > | tux$
> >
> > I guess I need a catch-all .PHONY rule, but don't know how to implement it...
>
> Try:
> .PHONY: $(MAKECMDGOALS)

Thanks! But it doesn't work:

| tux$ rm usr/*
| tux$ make usr/
| make: Nothing to be done for `usr/'.
| tux$

> or eventually
> ifneq ($(MAKECMDGOALS),)
> .PHONY: $(MAKECMDGOALS)
> endif
>
> The latter if an empty .PHONY is not allowed.

It's allowed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
