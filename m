Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281894AbRKUOwl>; Wed, 21 Nov 2001 09:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUOwb>; Wed, 21 Nov 2001 09:52:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18845 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281255AbRKUOwY>;
	Wed, 21 Nov 2001 09:52:24 -0500
Date: Wed, 21 Nov 2001 09:52:22 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Schwab <schwab@suse.de>
cc: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <jey9l09pge.fsf@sykes.suse.de>
Message-ID: <Pine.GSO.4.21.0111210945090.25953-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Nov 2001, Andreas Schwab wrote:

> Jan Hudec <bulb@ucw.cz> writes:
> 
> |> > On Wed, Nov 21, 2001 at 12:40:17PM +0000, vda wrote:
> |> > If you wanna do this type of cleanup, you can take it one step forward;
> |> > remember that the order of evaluation of foo and bar doesn't have to be
> |> > {foo => bar} so it can be {bar => foo}  I hope gcc's behaviour doesn't
> |> > change under our feet.
> |> > 
> |> > 	a = foo (i) + bar (j);
> |> > 
> |> > .. sprinkle some pointer arithmetic over there for fun ;)
> |> 
> |> AFAIK here the order *IS* defined. + operator is evaluated left to right
> 
> No.  It is undefined which of the operator's arguments is evaluated first,
> unless it is defined otherwise (only for ||, && and comma).

I suspect that real source of problem here is confusion with parsing -
+ operators are _grouped_ left to right.  I.e. a+b+c is parsed as (a+b)+c.
Which has nothing to order of evaluation of a, b and c...

