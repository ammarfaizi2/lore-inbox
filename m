Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSHIQYa>; Fri, 9 Aug 2002 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSHIQYa>; Fri, 9 Aug 2002 12:24:30 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:42502 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314078AbSHIQY3>; Fri, 9 Aug 2002 12:24:29 -0400
Date: Fri, 9 Aug 2002 13:27:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Phillips <phillips@arcor.de>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.4.44.0208090854001.1547-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208091317220.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002, Linus Torvalds wrote:
> On Fri, 9 Aug 2002, Daniel Phillips wrote:
> >
> > This reference describes roughly what I had in mind for active
> > defragmentation, which depends on reverse mapping.
>
> Note that even active defrag won't be able to handle the case where you
> want have lots of big pages, consituting a large percentage of available
> memory.
>
> Not unless you think I am crazy enough to do garbage collection on kernel
> data structures (repeat after me: "garbage collection is stupid, slow, bad
> for caches, and only for people who cannot count").

It's also necessary if you want to prevent death by physical
memory exhaustion since it's pretty easy to construct workloads
where the page table memory requirement is larger than physical
memory.

OTOH, I also think that it's (probably, almost certainly) not
worth doing active defragmenting for really huge superpages.
This category of garbage collection just gets into the 'rediculous'
class ;)

> Also, I think the jury (ie Andrew) is still out on whether rmap is worth
> it.

One problem we're running into here is that there are absolutely
no tools to measure some of the things rmap is supposed to fix,
like page replacement.

Sure, Craig Kulesa's tests all went faster on rmap than on the
virtual scanning VM, but that's just one application. There doesn't
seem to exist any kind of tool to quantify things like "quality
of page replacement" or even "efficiency of page replacement" ...

I suspect this is true for many pieces of the kernel, no tools
available to measure the benefits of the code, but only tools
to microbenchmark the _overhead_ of the code...

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

