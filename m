Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281878AbRKSCVN>; Sun, 18 Nov 2001 21:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281883AbRKSCVE>; Sun, 18 Nov 2001 21:21:04 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22145 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281878AbRKSCUy>; Sun, 18 Nov 2001 21:20:54 -0500
Date: Sun, 18 Nov 2001 20:22:52 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        Andrea Arcangeli <andrea@suse.de>, ehrhardt@mathematik.uni-ulm.de,
        linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011118202252.A8708@vger.timpanogas.org>
In-Reply-To: <200111181710.fAIHAlCF011794@sleipnir.valparaiso.cl> <Pine.LNX.4.33.0111181803040.7482-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111181803040.7482-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 18, 2001 at 06:04:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 06:04:16PM -0800, Linus Torvalds wrote:
> 
> On Sun, 18 Nov 2001, Horst von Brand wrote:
> > Linus Torvalds <torvalds@transmeta.com> said:
> > > And nope, not really. It does use plain stores to page->flags, and I agree
> > > that it is ugly, but if the page was locked before calling it, all the
> > > stores will be with the PG_lock bit set - and even plain stores _are_
> > > documented to be atomic on x86 (and on all other reasonable architectures
> > > too).
> >
> > Even unaligned stores?
> 
> Actually, even unaligned stores (which page->flags is NOT) are atomic,
> even if Intel strongly discourages them (for performance reasons if no
> others) and there tends to be documentation that doesn't guarantee it.
> 
> 		Linus
> 

This is true.  They Generate what's called a "split lock" bus transaction
where the bus will hold LOCK# low across the several clock cycles to 
complete the write.  They are **VERY** heavy, BTW, and really cause 
nasty performance hits.

Jeff




> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
