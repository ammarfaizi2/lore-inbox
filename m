Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRHaBUI>; Thu, 30 Aug 2001 21:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272577AbRHaBT6>; Thu, 30 Aug 2001 21:19:58 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:60682 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272576AbRHaBTr>;
	Thu, 30 Aug 2001 21:19:47 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108310119.f7V1Jws18144@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010830174227.A10673@furble> from "Gordon Oliver" at "Aug 30,
 2001 05:42:27 pm"
To: gordo@pincoya.com
Date: Fri, 31 Aug 2001 03:19:58 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Gordon Oliver wrote:"
[Charset ISO-8859-1 unsupported, filtering to ASCII...]
> On 2001.08.30 16:27 Peter T. Breuer wrote:
> > Possibly. I have little clue as to the real extent of the problem.
> 
>   You've missed the _vast_ majority of the real problems. And there is
> no way to fix some of them...
>     - if the sizeof the arguments is the same, it is a bug to have
>       signed vs. unsigned.

That's caught by the solution proposed.

>     - if the sizeof the arguments is different, it is a bug to have
>       the _larger_ argument unsigned.

This can't be caught at compile time.

>     - if one of the arguments is a constant, typeof will give you
>       a mostly arbitrary value, making { unsigned int i,j; j = max(i,5);}
>       return a bug.

?? I don't follow this at all. Typeof is deterministic, since the
gcc computer program is deterministic. Typeof MUST return the type of 
the expression to which it applies.  All expressions in C have 
precisely computed types -I guess  what you are saying is that that
the type of an expression may be context dependent, which I can easily
imagine in a random computer language, but seriously doubt for C.
C really does type calculations via narrowing :-o! Oh yeah!

Show me an instance of an expression that two differnt types depending
on context. I am prepared to be surprised, but dubious.

(umm ... what type is the "5" in "(short)5" ?? Why, signed integer, I
believe. It's truncated to short, modulo a language lawyer's second
opinion).

>     - not forcing the person to actually set the type of the argument
>       will allow things like
>       {
> 	int user_land_value, buffer_size;

Nice integers.

> 	user_land_value = magic_from_user_land();

signed integer value.

> 	buffer_size = min(user_land_value, 10);

well, 10 is a signed integer constant. AFAIK you'd have to write "10u"
to get an unsigned integer constant. And yes, the latter would be
caught by my solution.


> 	buffer = memcpy(some_place, some_other_place, buffer_size); /* BOOM
> */
>       }
>       to not show a bug at all (10 is signed).

I see no bug.

There would be a bug if 10u were used and user_land_value were negative,
since then the result of min would be 10u (and this bug would be flagged
by my solution).  But as things are, the result is user_land_value.

I just checked.


> Please, can we take this off of lkml... (btw, see the attached file
> for the bugs).

Are you SURE you can find the bugs! :-)

Peter
