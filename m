Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbTBYP4O>; Tue, 25 Feb 2003 10:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268005AbTBYP4N>; Tue, 25 Feb 2003 10:56:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24590 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268000AbTBYP4M>; Tue, 25 Feb 2003 10:56:12 -0500
Date: Tue, 25 Feb 2003 08:02:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Schwab <schwab@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <jevfz84bee.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0302250742400.10210-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, Andreas Schwab wrote:
> |> 
> |> So? Gcc does that anyway. _Any_ good compiler has to.
> 
> But the point is that determining the common type does not require _any_
> kind of data flow analysis, and this is the place where the unsigned
> warning is generated.

Go back and read my mail. In fact, go back and read just about _any_ of my 
mails on the subject. Gop back and read the part you snipped:

 "And if the compiler isn't good enough to do it, then the compiler 
  shouldn't be warning about something that it hasn't got a clue about."

In other words, either gcc should do it right, or it should not be done at 
all. Right now the warning IS GENERATED IN THE WRONG PLACE. Your argument 
seems to be "but that's the place it is generated" is a total 
non-argument. It's just stating a fact, and it's exactly that fact that 
causes the BUG IN GCC.

> |> Trivial example:
> |> 
> |> 	int x[2][2];
> |> 
> |> 	int main(int argc, char **argv)
> |> 	{
> |> 		return x[1][-1];
> |> 	}
> |> 
> |> 
> |> the above is actually a well-defined C program, and 100%
> |> standards-conforming ("strictly conforming").
> 
> This isn't as trivial as it seems.  Look in comp.std.c for recent
> discussions on this topic (out-of-array references). 

It is as trivial as it seems, and this is _not_ an out-of-array reference.  
Sorry. C very clearly specifies the layout of arrays (6.5.2.1: last
subscript varies fastest, together with sizeof(array) = sizeof(entry)*n),
which _guarantees_ that the pointers involved in the above calculations
are all within the object, and thus there is _zero_ undefined behaviour.

So if they argued about this on comp.std.c, they either had clueless
people there (in addition to the ones that obviously aren't ;), _or_ you
misunderstood the argument.

		Linus

