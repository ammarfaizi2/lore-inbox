Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310510AbSCPTS1>; Sat, 16 Mar 2002 14:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310516AbSCPTSH>; Sat, 16 Mar 2002 14:18:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310510AbSCPTRz>; Sat, 16 Mar 2002 14:17:55 -0500
Date: Sat, 16 Mar 2002 11:16:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316115726.B19495@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161102070.31913-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:
> > 
> > Simply because I want to be able to share the software page tables with 
> > the hardware page tables.
> 
> Isn't this only an issue when the hardware wants to search the tables?
> So for a semi-sane architecture, the hardware idea of pte is only important
> in the tlb.

Show me a semi-sane architecture that _matters_ from a commercial angle.

The x86 is actually fairly good: a sane data structure that allows it to
fill multiple pages in one go (the page size may be just 4kB, but the x86
TLB fill rate is pretty impressive - I _think_ Intel actually fills a
whole cacheline worth of tlb entries - 8 pages - per miss).

But the x86 page table structure is fairly rigid, and is in practice 
limited to 4kB entries for normal user pages, and 4kB page table entries.

> is there a 64 bit machine with hardware search of pagetables? Even ibm
> only has a hardware search of hash tables - which we agree are simply
> a means of making your hardware TLB larger and slower.

ia64 does the same mistake, I think. 

But alpha does a "pseudo-hardware" fill of page tables, ie as far as the
OS is concerned you might as well consider it hardware. And that is
actually limited to 8kB pages (with a "fast fill" feature in the form of
page size hints - a cheaper version of what Intel seems to do).

The upcoming hammer stuff from AMD is also 64-bit, and apparently a
four-level page table, each with 512 entries and 4kB pages. So there you
get 9+9+9+9+12=48 bits of VM space, which is plenty. Linux won't be able
to take advantage of more than 39 bits of it until we switch to four
levels, of course (39 bits is plenty good enough too, for the next few
years, and we'll have no pain in expanding to 48 when that day comes).

So yes, there are 64-bit chips with hardware (or architecture-specified) 
page tables. And I personally like how Hammer looks more than the ia64 VM 
horror.

		Linus

