Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbSITRHQ>; Fri, 20 Sep 2002 13:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbSITRHQ>; Fri, 20 Sep 2002 13:07:16 -0400
Received: from packet.digeo.com ([12.110.80.53]:51388 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263062AbSITRHP>;
	Fri, 20 Sep 2002 13:07:15 -0400
Message-ID: <3D8B56DB.576B702D@digeo.com>
Date: Fri, 20 Sep 2002 10:11:55 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Oleg Drokin <green@namesys.com>, Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
References: <20020920122716.A2297@namesys.com> <Pine.LNX.4.44.0209201139290.1261-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Sep 2002 17:11:55.0538 (UTC) FILETIME=[D2285720:01C260C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Fri, 20 Sep 2002, Oleg Drokin wrote:
> 
> > > +                   if (cmpxchg(&map->page, NULL, page))
> > > +                           free_page(page);
> >
> > Note that this piece breaks compilation for every arch that does not
> > have cmpxchg implementation.
> > This is the case with x86 (with CONFIG_X86_CMPXCHG undefined, e.g. i386),
> > ARM, CRIS, m68k, MIPS, MIPS64, PARISC, s390, SH, sparc32, UML (for x86).
> 
> we need a cmpxchg() function in the generic library, using a spinlock.
> Then every architecture can enhance the implementation if it wishes to.
> 

That would be good, but wouldn't we then need a special per-arch
"cmpxchngable" type, like atomic_t?

Seems that just doing compare-and-exchange on a bare page* might force
some architectures to use a global lock.
