Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266097AbRGGLa3>; Sat, 7 Jul 2001 07:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266103AbRGGLaT>; Sat, 7 Jul 2001 07:30:19 -0400
Received: from hood.tvd.be ([195.162.196.21]:45642 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S266097AbRGGLaJ>;
	Sat, 7 Jul 2001 07:30:09 -0400
Date: Sat, 7 Jul 2001 13:26:22 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jes Sorensen <jes@sunsite.dk>,
        dwmw2@redhat.com, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: <3911.994146916@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.05.10107071324080.3943-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, David Howells wrote:
> > The question I think being ignored here is. Why not leave things as is. The
> > multiple bus stuff is a port specific detail hidden behind readb() and
> > friends.
> 
> This isn't so much for the case where the address generation is done by a
> simple addition. That could be optimised away by the compiler with an entirely
> inline function (as per David Woodhouse's suggestion).
> 
> It's far more important for non-x86 platforms which only have a single address
> space and have to fold multiple external address spaces into it.
> 
> For example, one board I've got doesn't allow you to do a straight
> memory-mapped I/O access to your PCI device directly, but have to reposition a
> window in the CPU's memory space over part of the PCI memory space first, and
> then hold a spinlock whilst you do it.

This is a common practice on NEC PCI host bridges: usually you have 2 `windows'
to the PCI bus only, so you can have direct access to only two of PCI memory,
PCI I/O and PCI config spaces at the same time. If you need access to the
third, you have to reconfigure the windows.  Usually you configure the windows
to have direct access to PCI memory and PCI I/O spaces. So PCI config space
takes the hit. If you have only one window, YMMV.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

