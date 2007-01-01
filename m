Return-Path: <linux-kernel-owner+w=401wt.eu-S932825AbXAAUzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbXAAUzq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbXAAUzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:55:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48964 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932825AbXAAUzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:55:45 -0500
Date: Mon, 1 Jan 2007 21:55:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Message-ID: <20070101205521.GB4901@elf.ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612281405.37143.david-b@pacbell.net> <20061229002752.GA3543@elf.ucw.cz> <200612291718.34494.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612291718.34494.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well. when you see (something) = gpio_number + 5 ... you most likely
> > have an error.
> 
> One could surely apply that argument to hundreds of places throughout
> the kernel ... that doesn't make it a good one.  One of the downfalls
> of many "object oriented programming" efforts was this same desire to
> encapsulate things that don't need it; it's lose, not a don't-care.
> 
> Think of it as "cookies represented by integers" if you like.

typedef int gpio_t would hurt, and would serve as a useful
documentation hint. Furthermore, you could switch it to enum on
platform where it makes sense.

> > No, that's a wrong way. I want you to admit that gpio numbers are
> > opaque cookies noone should look at, and use (something like)
> > gpio_t... so that we can teach sparse to check them.
> 
> You're welcome to dream on.  :)
> 
> The goal here is not to create new complexity, it's to wrap the

...it adds exactly one line.

> > > > > +The get/set calls have no error returns because "invalid GPIO" should have
> > > > > +been reported earlier in gpio_set_direction().  However, note that not all
> > > > > +platforms can read the value of output pins; those that can't should always
> > > > > +return zero.  Also, these calls will be ignored for GPIOs that can't safely
> > > > > +be accessed without sleeping (see below).
> > > > 
> > > > 'Silently ignored' is ugly. BUG() would be okay there.
> > > 
> > > The reason for "silently ignored" is that we really don't want to be
> > > cluttering up the code (source or object) with logic to test for this
> > > kind of "can't happen" failure, especially since there's not going to
> > > be any way to _resolve_ such failures cleanly.
> > 
> > You may not want to clutter up code for one arch, but for some of them
> > maybe it is okay and welcome. Please do not document "silently
> > ignored" into API.
> 
> Those words were yours; so you can consider that already done.
> Should it instead say that's an (obviously unchecked) error?

Saying it is an error would be okay by me. (Or "Behaviour of these calls for
GPIOs that can't be safely accessed without sleeping is undefined.").

> You are perverting what _I_ said.  (As you've done before; stop
>that.)

Sorry.

> In terms of API specs, emitting any warning is traditionally
> out-of-scope.

Ok, I mis-read your specs as trying to push warnings into the scope.

> > > > > +... It is an unchecked error to use a GPIO
> > > > > +number that hasn't been marked as an input using gpio_set_direction(), or
> > > > 
> > > > It should be valid to do irqs on outputs,
> > > 
> > > Good point -- it _might_ be valid to do that, on some platforms.
> > > Such things have been used as a software IRQ trigger, which can
> > > make bootstrapping some things easier.
> > > 
> > > That's not incompatible with it being an error for portable code to
> > > try that, or with refusing to check it so that those platforms don't
> > > needlessly cause trouble!
> > 
> > I believe your text suggests it _is_ incompatible. Plus that seems to
> > mean that  architecture must not check for that error...
> 
> Which -- that portable code mustn't try such things?  That seems clearly
> wrong; that's what the "is an error" phrase means.  Or that code

Ok, "debug behaviour is out of scope, again".

What about "Behavour of reading a GPIO that hasn't been marked as an
input using gpio_set_direction() is implementation-defined"?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
