Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262520AbSI0QJc>; Fri, 27 Sep 2002 12:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbSI0QJc>; Fri, 27 Sep 2002 12:09:32 -0400
Received: from ns.suse.de ([213.95.15.193]:14091 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262520AbSI0QJb>;
	Fri, 27 Sep 2002 12:09:31 -0400
Date: Fri, 27 Sep 2002 18:14:45 +0200
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put modules into linear mapping
Message-ID: <20020927181445.A9595@wotan.suse.de>
References: <p73d6qzsav0.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0209271745230.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209271745230.8911-100000@serv>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 05:55:13PM +0200, Roman Zippel wrote:
> Hi,
> 
> On 27 Sep 2002, Andi Kleen wrote:
> 
> > > Why is i386 only? This is generic code and other archs will benefit from
> > > it as well (or at least it won't hurt).
> >
> > Because some arcitectures have a different module_map() (e.g. x86-64 or
> > sparc64)
> 
> As I already said in the last mail, these functions look like vmalloc
> reimplementations.

No, they aren't. x86-64 uses it because modules need to be in 32bit
range from the main kernel and vmalloc is in a different area. I suspect
it is the same on sparc64.

> > and > order 0 is the only case that is interesting for alloc_exact.
> > GFP_DMA is not needed here, and GFP_HIGHUSER neither supports > order 0
> > properly (because of kmap)
> 
> If it's supposed to be a generic function, it makes sense, otherwise we
> could just put it into module.c.

Ok, I will change it.


-Andi
