Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbRBTUsb>; Tue, 20 Feb 2001 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbRBTUsM>; Tue, 20 Feb 2001 15:48:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60421 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129475AbRBTUsI>; Tue, 20 Feb 2001 15:48:08 -0500
Subject: Re: [beta patch] SSE copy_page() / clear_page()
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 20 Feb 2001 20:49:49 +0000 (GMT)
Cc: manfred@colorfullife.com (Manfred Spraul),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010220183513.B5102@bug.ucw.cz> from "Pavel Machek" at Feb 20, 2001 06:35:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VJjL-0000eK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		__asm__ __volatile__(
> > +			"mov %1, %0\n\t"
> > +			: "=r" (i)
> > +			: "r" (kaddr+offset)); /* load tlb entry */
> > +		for(i=0;i<size;i+=64) {
> > +			__asm__ __volatile__(
> > +				"prefetchnta (%1, %0)\n\t"
> > +				"prefetchnta 32(%1, %0)\n\t"
> > +				: /* no output */
> > +				: "r" (i), "r" (kaddr+offset));
> > +		}
> > +	}
> >  	left = __copy_to_user(desc->buf, kaddr + offset, size);
> >  	kunmap(page);
> 
> This seems bogus -- you need to handle faults --
> i.e. __prefetchnta_to_user() ;-).

It wants wrapping nicely. A generic prefetch and prefetchw does help some other
cases (scheduler for one).

Does the prefetch instruction fault on PIII/PIV then - the K7 one appears not
to be a source of faults

