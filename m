Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265848AbRFYCYQ>; Sun, 24 Jun 2001 22:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265849AbRFYCX5>; Sun, 24 Jun 2001 22:23:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32426 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265848AbRFYCXk>;
	Sun, 24 Jun 2001 22:23:40 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15158.41128.884623.204096@pizda.ninka.net>
Date: Sun, 24 Jun 2001 19:23:36 -0700 (PDT)
To: Larry McVoy <lm@bitmover.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Stephen Satchell <satch@fluent-access.com>,
        Martin Devera <devik@cdi.cz>, bert hubert <ahu@ds9a.nl>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Threads are processes that share more
In-Reply-To: <20010624164729.G8832@work.bitmover.com>
In-Reply-To: <20010620175937.A8159@home.ds9a.nl>
	<Pine.LNX.4.10.10106202036470.10363-100000@luxik.cdi.cz>
	<4.3.2.7.2.20010620150729.00b60710@mail.fluent-access.com>
	<20010621011031.B19922@werewolf.able.es>
	<20010624164729.G8832@work.bitmover.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry McVoy writes:
 > In other words, it's designed to be shared.  The IRIX stuff is disgusting,
 > you really don't want anything to do with sproc().    It _sounds_ like they
 > are the same but they aren't - for example, with sproc you get your very
 > own TLB miss handler.  Doesn't that sound special?

In case anyone is scratching their heads when they read this, the
reason is that IRIX allows partial sharing of the address space.

So for normal processes and threads that fully share the address
space, they have a "fast path" tlb miss handler which doesn't have
to deal with any of the complexities of having a mixture of shared
and non-shared vm areas within the same address space.

The address space mixing is (as usual for something SGI does) mainly
for graphics performance...  You can be a mostly shared thread yet
have a private mmap() of the 3d accelerator so you can swap the
graphics context using page faults per-thread.  There was a thread
perhaps half a year ago about this where graphics afficiandos were
trying to show why Linux needed to do things this way and Linus
telling them "no it doesn't" :-)

Later,
David S. Miller
davem@redhat.com
