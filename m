Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTBGUfa>; Fri, 7 Feb 2003 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTBGUfa>; Fri, 7 Feb 2003 15:35:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58524 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266434AbTBGUf2>; Fri, 7 Feb 2003 15:35:28 -0500
Date: Fri, 7 Feb 2003 15:47:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Russell King <rmk@arm.linux.org.uk>, fdavis@si.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
In-Reply-To: <200302072003.h17K3t2U002303@darkstar.example.net>
Message-ID: <Pine.LNX.3.95.1030207152853.31273A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, John Bradford wrote:

> > > --- linux/sound/oss/vidc.c.old	2003-01-16 21:21:38.000000000 -0500
> > > +++ linux/sound/oss/vidc.c	2003-02-07 02:59:44.000000000 -0500
> > > @@ -225,7 +225,7 @@
> > >  			newsize = 208;
> > >  		if (newsize > 4096)
> > >  			newsize = 4096;
> > > -		for (new2size = 128; new2size < newsize; new2size <<= 1);
> > > +		for (new2size = 128; new2size < newsize; new2size <<= 1)
> > >  			if (new2size - newsize > newsize - (new2size >> 1))
> > >  				new2size >>= 1;
> > >  		if (new2size > 4096) {
> > 
> > The code is correct as it originally stood.
> > 
> > It looks like indent has a bug and incorrectly formats this to look wrong.
> > Back in 2.2 times, the code looks  like this:
> > 
> > 		for (new2size = 128; new2size < newsize; new2size <<= 1);
> > 		if (new2size - newsize > newsize - (new2size >> 1))
> > 			new2size >>= 1;
> > 
> > and this is the intended functionality.  Please do NOT apply the patch.
> 
> I thought we were switching to negative tab indentation, anyway:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104125431009832&w=2
> 
> :-)
> 
> John.

If the code is correct, it really should be written as:

   for (new2size = 128; new2size < newsize; new2size <<= 1)
       ;

The code seems to want to make the value of new2size a power of
2 and, greater than 128, but less than newsize. It ignores the
fact that newsize might be less than 128, maybe this is okay.
But, the code goes on, eventually settling on new2size being
less than 4096... hmmm. I'll bet this could be greatly
simplified. I think 'new2size' is really something that will
fit inside 128-byte groups. Maybe an & or a % will greatly
simplify?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


