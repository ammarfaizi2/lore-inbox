Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTI2Ixd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbTI2Ixd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:53:33 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:30884 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262963AbTI2Ixb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:53:31 -0400
Date: Mon, 29 Sep 2003 10:52:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <20030928202850.E1428@flint.arm.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0309291052040.7432-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003, Russell King wrote:
> On Sun, Sep 28, 2003 at 10:37:36AM -0700, Linus Torvalds wrote:
> > On Sun, 28 Sep 2003, Geert Uytterhoeven wrote:
> > > On Sat, 27 Sep 2003, Linus Torvalds wrote:
> > > > Bernardo Innocenti:
> > > >   o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h
> > > 
> > > This change breaks 2.95 for some source files, because <linux/init.h> doesn't
> > > include <linux/compiler.h>. Do you want to have the missing include added to
> > > <linux/init.h>, or to the individual source files that need it?
> > 
> > Interesting. I'm pretty sure I did a "make allyesconfig" just before the
> > test6 release, so apparently x86 includes it indirectly through some path, 
> > and so it only shows up on m68k and arm?
> > 
> > This, btw, is a pretty common thing. I wonder what we could do to make 
> > sure that different architectures wouldn't have so different include file 
> > structures. It's happened _way_ too often.
> > 
> > Any ideas?
> 
> The two files that it showed up in on ARM are fairly simple in nature and
> don't include may headers.  Making the ARM include structure identical to
> x86 wouldn't have removed the problem from ARM.

Same for m68k. The offender was a m68k-specific file (arch/m68k/sun3/sbus.c),
which just included <linux/types.h> and <linux/init.h>, and uses
subsys_initcall().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

