Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292151AbSBBALV>; Fri, 1 Feb 2002 19:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292150AbSBBALN>; Fri, 1 Feb 2002 19:11:13 -0500
Received: from femail14.sdc1.sfba.home.com ([24.0.95.141]:8189 "EHLO
	femail14.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S292149AbSBBAK5>; Fri, 1 Feb 2002 19:10:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Larry McVoy <lm@work.bitmover.com>, Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Bitkeeper change granularity (was Re: A modest proposal -- We need a patch penguin)
Date: Fri, 1 Feb 2002 15:47:16 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>
In-Reply-To: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020202001056.UXDI10685.femail14.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 February 2002 06:11 am, Horst von Brand wrote:
> Larry McVoy <lm@bitmover.com> said:
> > On Fri, Feb 01, 2002 at 11:29:58AM +1100, Keith Owens wrote:
> > > That sounds almost like what I was looking for, with two differences.
> > >
> > > (1) Implement the collapsed set so bk records that it is equivalent to
> > >     the individual patchsets.  Only record that information in my tree.
> > >     I need the detailed history of what changes went into the collapsed
> > >     set, nobody else does.
> > >
> > > (2) Somebody else creates a change against the collapsed set and I pull
> > >     that change.  bk notices that the change is again a collapsed set
> > >     for which I have local detail.  The external change becomes a
> > >     branch off the last detailed patch in the collapsed set.
> >
> > This is certainly possible to do.  However, unless you are willing to
> > fund this development, we aren't going to do it.  We will pick up the
> > costs of making changes that you want if and only if we have commercial
> > customers who want (or are likely to want) the same thing.  Nothing
> > personal, it's a business and we make tradeoffs like that all the time.
>
> I wonder how your commercial customers develop code then. Either each
> programmer futzes around in his/her own tree, and then creates a patch (or
> some such) for everybody to see (then I don't see the point of source
> control as a help to the individual developer), or everybody sees all the
> backtracking going on everywhere (in which case the repository is a mostly
> useless mess AFAICS).

Speaking from my experience on OS/2 back at IBM (I.E. about as big as it 
gets), they simply don't mind having amazing amounts of cruft in the database 
dating back to at least the last time they switched source control systems.

Under those circumstances, looking at the code history becomes a major 
archaeological expedition, and you either still have the original 
implementors around who have it all in their heads and don't NEED the 
database, or you have people who just look at the code and try to guess what 
it means, possibly asking colleagues about particularly confusing bits.

IBM's source control system always struck me as a graveyard of old code more 
than anything else.  Lots of the really old stuff was stored offline on tapes 
and CDs filed lockers nobody ever opened, with backup copies at some big "we 
have a vault beneath NORAD" data warehousing company.

That's my impression, anyway.  (A few years out of date now.)  My experience 
with the source control system was that it DID have the complete revision 
history in it going back to the 1980's, but it was far more work than it was 
worth to try to mine through it to find something unless you were 
specifically looking to place blame and prove something wasn't YOUR fault.  
Nobody really ever had time to actually go through it for any other reason, 
we had far too much new stuff backlogged.  (And yeah a lot of changes were 
made where some old timer would pipe up afterwards "we tried that five years 
ago, and it didn't work for the same reason you just noticed".  But this was 
the kind of state that was usefully kept in people's heads, not in the source 
control system.)

Now in an open source, the source control system with history might be a 
useful educational resource.  (Non-commercial developers don't have to hit 
the ground running the way commercial ones do.)  But too much granularity 
would definitely diminish that usefulness.  Flood people with low signal and 
high noise, and only archaeologists will ever care about it.

A system that maintained obscene amounts of granularity but HID it (showing 
you only diffs between release versions unless you specifically asked so see 
more detail) would be a distinct improvement over a system that forces every 
query be an archaeological dig.  But since 99% of the people do NOT want to 
go on an archaeological dig, and since for most things only the most active 
10% of the developers even care about the -pre releases and only have time to 
track/sync with the main releases...

Maintaining the "reverted before it left the original implementors tree" 
state at ALL is clearly more trouble than it's worth.  If the original 
IMPLEMENTOR is likely to delete that after they ship, nobody else should EVER 
care unless they're writing some sort of biography of that developer or 
simply engaged in hero-worship.

I.E. yes, I think we honestly do want an easy way to limit the granularity of 
propogated diffs.  We can do this right now by exporting to patch and 
re-importing, but it seems that if we do, then bitkeeper's sync mechanism 
becomes a problem to be worked around.  I'd say this instance of all-out-war 
between what developers are trying to do and what bitkeeper is trying to do 
highlights a design gap in bitkeeper.

Just my opinion, your mileage may vary. :)

Rob

