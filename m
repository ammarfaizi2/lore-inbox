Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbSITJ1k>; Fri, 20 Sep 2002 05:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSITJ1k>; Fri, 20 Sep 2002 05:27:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46246 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262103AbSITJ1j>;
	Fri, 20 Sep 2002 05:27:39 -0400
Date: Fri, 20 Sep 2002 11:40:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Drokin <green@namesys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <20020920122716.A2297@namesys.com>
Message-ID: <Pine.LNX.4.44.0209201139290.1261-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Oleg Drokin wrote:

> > +			if (cmpxchg(&map->page, NULL, page))
> > +				free_page(page);
> 
> Note that this piece breaks compilation for every arch that does not
> have cmpxchg implementation.
> This is the case with x86 (with CONFIG_X86_CMPXCHG undefined, e.g. i386),
> ARM, CRIS, m68k, MIPS, MIPS64, PARISC, s390, SH, sparc32, UML (for x86).

we need a cmpxchg() function in the generic library, using a spinlock.  
Then every architecture can enhance the implementation if it wishes to.

	Ingo

