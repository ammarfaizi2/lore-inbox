Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310604AbSCPUgl>; Sat, 16 Mar 2002 15:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310602AbSCPUgc>; Sat, 16 Mar 2002 15:36:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14345 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310601AbSCPUgR> convert rfc822-to-8bit; Sat, 16 Mar 2002 15:36:17 -0500
Date: Sat, 16 Mar 2002 12:34:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316131219.C20436@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161223290.31971-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g2GKZxN25763
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> 
> To me, once you have a G of memory, wasting a few meg on unused process 
> memory seems no big deal.

It's not the process memory, and it is a whole lot than a "few meg" if 
your page size is 2M.

Look at "free" output one day, and notice that "cached" line? On my 2G 
machine, I usually have about a gig cached or so. Guess what the most 
common thing in that case is? Yeah, the kernel. 

And my kernel tree (with bk overhead etc) is right not about 25.000 files. 
That's without object files etc. At 2M a pop in the page cache, that's a 
whole lot more memory for caching than I have in my machine.

Ok, so assume you compress that, and you only actually use the full 2M 
when mapping into user space, you now added a lot of complexity, but at 
least you make the ridiculous memory use go down. 

But even in the process space, I've got about 150 processes quite 
normally, and while most of them are idle, if we had 2M pages most of them 
would waste at least 2M of memory (probably more - the stack doesn't even 
need half a page, and the data section would probably waste half a page on 
average).

That's 300M just wasted.

Tell me that's peanuts even if you've got a few gigs of ram on your 
machine. 

Admit it, you're just wrong. 2M page sizes are _not_ useful for the common
case, and won't be for years to come.

In short, youäre 

> They say:
> 	Hammer microarchitecture features a flush filter allowing multiple
> 	processes to share TLB without SW intervention.
> 
> Not a lot of technical detail in that.

I suspect it's some special case for windows with a special MSR that 
enables something illegal that just works well for whatever patterns 
windows does.

		Linus

