Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130669AbRBTUxB>; Tue, 20 Feb 2001 15:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbRBTUwv>; Tue, 20 Feb 2001 15:52:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30478 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130669AbRBTUwj>; Tue, 20 Feb 2001 15:52:39 -0500
Date: Tue, 20 Feb 2001 21:52:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
Message-ID: <20010220215216.C17159@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010220183513.B5102@bug.ucw.cz> <E14VJjL-0000eK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14VJjL-0000eK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 20, 2001 at 08:49:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +		__asm__ __volatile__(
> > > +			"mov %1, %0\n\t"
> > > +			: "=r" (i)
> > > +			: "r" (kaddr+offset)); /* load tlb entry */
> > > +		for(i=0;i<size;i+=64) {
> > > +			__asm__ __volatile__(
> > > +				"prefetchnta (%1, %0)\n\t"
> > > +				"prefetchnta 32(%1, %0)\n\t"
> > > +				: /* no output */
> > > +				: "r" (i), "r" (kaddr+offset));
> > > +		}
> > > +	}
> > >  	left = __copy_to_user(desc->buf, kaddr + offset, size);
> > >  	kunmap(page);
> > 
> > This seems bogus -- you need to handle faults --
> > i.e. __prefetchnta_to_user() ;-).
> 
> It wants wrapping nicely. A generic prefetch and prefetchw does help some other
> cases (scheduler for one).
> 
> Does the prefetch instruction fault on PIII/PIV then - the K7 one appears not
> to be a source of faults

My fault. I was told that prefetch instructions are always
non-faulting.

				Pavel

-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
