Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268720AbUJEAh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268720AbUJEAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268722AbUJEAh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:37:27 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:43671 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268720AbUJEAhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:37:17 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Albert Cahalan <albert@users.sf.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
In-Reply-To: <200410041420.01266.jbarnes@engr.sgi.com>
References: <1096922369.2666.177.camel@cube>
	 <200410041420.01266.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1096936344.2674.198.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Oct 2004 20:32:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-04 at 17:20, Jesse Barnes wrote:
> On Monday, October 4, 2004 1:39 pm, Albert Cahalan wrote:
> > > diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
> > > --- a/include/asm-ppc/io.h 2004-09-27 10:48:41 -07:00
> > > +++ b/include/asm-ppc/io.h 2004-09-27 10:48:41 -07:00
> > > @@ -197,6 +197,8 @@
> > >  #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
> > >  #define memcpy_toio(a,b,c) memcpy((void *)(a),(b),(c))
> > >
> > > +#define mmiowb() asm volatile ("eieio" ::: "memory")
> > > +
> > >  /*
> > >   * Map in an area of physical address space, for accessing
> > >   * I/O devices etc.
> >
> > I don't think this is right. For ppc, eieio is
> > already included as part of the assembly for the
> > IO operations. If you could delete that, great,
> > but I suspect that nearly all drivers would break.
> 
> Ok, if it's covered than mmiowb() can just be empty for ppc.

Ideally, it would be eieio, and the eieio in each
of the IO operations would be removed. Finding and
fixing all the drivers that break looks impossible
though; most driver developers will be on x86 boxes.

> > BTW, the "eieio" name is better. The "wb" part
> > of "mmiowb" looks like "write back" to me, as if
> > it were some sort of cache push operation. It is
> > also lacking an appropriate song. :-)
> 
> It's supposed to be 'write barrier' just like wmb is a write memory barrier, 
> so is mmiowb a memory-mapped I/O write barrier.  Make sense?

In that case: wmmiob

(or something longer, like mmio_write_fence maybe)

As a name, "wmb" sucks almost as much as "cli" and "sti" do.
It dates back to the Alpha port, where it's an opcode.


