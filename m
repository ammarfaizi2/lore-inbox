Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262297AbSITLir>; Fri, 20 Sep 2002 07:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSITLir>; Fri, 20 Sep 2002 07:38:47 -0400
Received: from angband.namesys.com ([212.16.7.85]:8353 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262297AbSITLiq>; Fri, 20 Sep 2002 07:38:46 -0400
Date: Fri, 20 Sep 2002 15:43:47 +0400
From: Oleg Drokin <green@namesys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Message-ID: <20020920154347.A12399@namesys.com>
References: <20020920122716.A2297@namesys.com> <Pine.LNX.4.44.0209201139290.1261-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209201139290.1261-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Sep 20, 2002 at 11:40:16AM +0200, Ingo Molnar wrote:
> > > +			if (cmpxchg(&map->page, NULL, page))
> > > +				free_page(page);
> > Note that this piece breaks compilation for every arch that does not
> > have cmpxchg implementation.
> > This is the case with x86 (with CONFIG_X86_CMPXCHG undefined, e.g. i386),
> > ARM, CRIS, m68k, MIPS, MIPS64, PARISC, s390, SH, sparc32, UML (for x86).
> we need a cmpxchg() function in the generic library, using a spinlock.  

But this is not safe for arches that provides SMP but does not provide
cmpxchg in hadware, right?
I mean it is only safe to use such spinlock-based function if
all other places read and write this value via special functions that are
also taking this spinlock.
Do you think we can count on this?

Bye,
    Oleg
