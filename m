Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVHLS0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVHLS0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVHLS0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:26:45 -0400
Received: from mail.suse.de ([195.135.220.2]:30138 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750880AbVHLS0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:26:43 -0400
Date: Fri, 12 Aug 2005 20:26:28 +0200
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050812182628.GG22901@wotan.suse.de>
References: <1123796188.17269.127.camel@localhost.localdomain.suse.lists.linux.kernel> <1123809302.17269.139.camel@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org.suse.lists.linux.kernel> <p73br432izq.fsf@verdi.suse.de> <1123869386.3218.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123869386.3218.37.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 07:56:26PM +0200, Arjan van de Ven wrote:
> On Fri, 2005-08-12 at 18:54 +0200, Andi Kleen wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > > 
> > > I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
> > > anybody has ever really used it except for some rootkits. 
> > 
> > I don't think that's true.
> 
> got any examples ?

I wrote some hacks over the years, not sure it would be useful
to post them because they all were very special purpose. 

I know users are doing the same because they complain on x86-64
when it doesn't work.


> > > So I'd be perfectly happy to fix this, but I'd be even happier if we made 
> > > the whole kmem thing a config variable (maybe even default it to "off").
> > 
> > Acessing vmalloc in /dev/mem would be pretty awkward. Yes it doesn't
> > also work in mmap of /dev/kmem, but at least in read/write.
> > There are quite a lot of scripts that use it for kernel debugging
> > like dumping variables. And for that you really want to access modules
> > and vmalloc. And it's much easier to parse than /proc/kcore
> 
> but you can stick gdb on /proc/kcore...

That's much more complicated. Instead of a simple read you would
need to parse complex ASCII output. Also gdb normally doesn't
work with a single System.map or /proc/kallsyms. I know it could
be gotten to use that stuff, but that would be all very complicated.
Much more complicated than read/write on /dev/kmem.

-Andi
