Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVACQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVACQaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 11:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVACQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 11:30:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36393
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261493AbVACQah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 11:30:37 -0500
Date: Mon, 3 Jan 2005 17:30:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: VM fixes [2/4]
Message-ID: <20050103163046.GY5164@dualathlon.random>
References: <20041224173558.GC13747@dualathlon.random> <41D46F4A.5080505@yahoo.com.au> <20050102163236.GI5164@dualathlon.random> <20050103122518.GF29158@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103122518.GF29158@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 10:25:18AM -0200, Marcelo Tosatti wrote:
> On Sun, Jan 02, 2005 at 05:32:36PM +0100, Andrea Arcangeli wrote:
> > On Fri, Dec 31, 2004 at 08:12:42AM +1100, Nick Piggin wrote:
> > > Andrea Arcangeli wrote:
> > > >This is the forward port to 2.6 of the lowmem_reserved algorithm I
> > > >invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
> > > >like google (especially without swap) on x86 with >1G of ram, but it's
> > > >needed in all sort of workloads with lots of ram on x86, it's also
> > > >needed on x86-64 for dma allocations. This brings 2.6 in sync with
> > > >latest 2.4.2x.
> > > >
> > > 
> > > This looks OK to me. It really simplifies the code there a lot too.
> > > 
> > > The only questions I have are: should it be on by default? I don't think
> > > we ever reached an agreement. I'd say yes, after a run in -mm because it
> > > does potentially fix corner cases where lower zones get filled with un-
> > > freeable memory which could have been satisfied with higher zones.
> > 
> > Great, thanks for the review! I definitely agree it should be on by
> > default, I already had an hang report that was solved by more recent
> > kernels and that probably can only be explained by lowmem_reserve since
> > there aren't other mm changes in 2.6.5 based trees. 
> > 
> > > And second, any chance you could you port it to the mm patches already in
> > > -mm? Won't be a big job, just some clashes in __alloc_pages...
> > 
> > I already had to port to 2.6.5 too, and that's enough for now unless I
> > first get a positive ack that it will be merged (if I hadn't more
> > interesting things to develop, I would be happily porting it).
> 
> I believe it can be accepted easily if you change the variable names
> from protection to lowmem_reserve.
> 
> Is there a need for that or its just your taste? :)

The naming is in sync with 2.4, I called that feature lowmem_reserve
when I wrote it.  Protection doesn't actually mean anything. Memory
protection, mprotect, what?

The object of the feature is to reserve lower memory in function of the
classzone allocation, and in function of the zone we're allocating from.
So lowmem_reserve sounds a much better name. And it wasn't me to change
it, it was the 2.6 kernel calling it differently in the first place.
Note that at first 2.6 was doing stuff very differently from 2.4 too
(and it wasn't working right infact). Now it's in perfect sync with the 2.4
algorightm I wrote originally and so I thought it would be much cleaner
to call it the same way as 2.4, which is more self explanatory too.
