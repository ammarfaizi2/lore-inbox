Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136050AbRAJSDb>; Wed, 10 Jan 2001 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136069AbRAJSDW>; Wed, 10 Jan 2001 13:03:22 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:18193 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S136050AbRAJSDB>; Wed, 10 Jan 2001 13:03:01 -0500
Date: Wed, 10 Jan 2001 19:02:58 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <Pine.LNX.4.10.10101100915290.4283-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101101833420.16888-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Wed, 10 Jan 2001, Marco Colombo wrote:
> > > 
> > > 	case xxx:
> > > 		/* fallthrough */ ;
> > > 	}
> > > 
> > > or something (or maybe just a "break" statement), just so that we don't
> > > turn the poor C language into line noise (can anybody say "perl" ;)
> > 
> > Of course, you don't mean that the fallthrough comment and the break
> > statement have the same functionality! (well you put the closing
> > bracket and I agree that for the last case it's the same).
> 
> Note that the warning case we're discussing was really only about case
> statements at the end of a compound statement.
> 
> In the middle of compound statements we're already fine: it's only the
> corner case of a case "statement" without the statement that gcc
> historically used to accept without warning, and that the gcc people only
> recently noticed that they really shouldn't accept at all.
> 
> So that's why a comment and a "break" is equivalent. ONLY for the special
> case of the new compile warning, though, obviously (see the subject line,
> but yes, I should have made that more explicit).

I see. The choice between the comment and the 'break' can be left
to the author, maybe he knows what is the best one (the one that will
let us add a new case with less effort).

If you bother setting a styleguide rule, I believe the latter is more
common.

But still I dislike semicolons *after* comments. Why not:

	case a:
		...
		; /* fallthrough */
	case b:
		...
		; /* fallthrough */
	}

It looks just a little less ugly to my eyes (please take a few seconds to
get used at it), maybe it's because it's reminiscent of shell
double-semicolon. In general, I find it more readable when comments
are somewhat "outside" the C code.

[ Note: I still put it after the first case, both for documenting the
fallthrough behaviour, which is a good thing anyway, and to allow
deleting the last case with no thinking of it. ]

I'd even put a tab before the comment.

	case b:
		...
		;	/* fallthrough */
	}

Ok, that's really a matter of taste. You spend more time in front
of the source than me, and you know better. I'd like you to set a kind
of rule, because it's something that many are not used to see and it's
easier to recognise it if it looks the same everywhere.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
