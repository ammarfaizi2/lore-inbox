Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBIAb6>; Thu, 8 Feb 2001 19:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129035AbRBIAbs>; Thu, 8 Feb 2001 19:31:48 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:54798 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129026AbRBIAb3>; Thu, 8 Feb 2001 19:31:29 -0500
Date: Thu, 8 Feb 2001 19:31:20 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
Message-ID: <20010208193120.C1640@alcove.wittsend.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com> <20010208183232.A1642@alcove.wittsend.com> <3A833005.5C8E0D81@transmeta.com> <20010208185449.B1642@alcove.wittsend.com> <3A83335A.A5764CD7@transmeta.com> <20010208190823.B1640@alcove.wittsend.com> <3A8335BB.F3166F1@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <3A8335BB.F3166F1@transmeta.com>; from hpa@transmeta.com on Thu, Feb 08, 2001 at 04:11:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 04:11:39PM -0800, H. Peter Anvin wrote:
> "Michael H. Warfield" wrote:
> > 
> > > Please explain how there is any different between an CNAME or MX pointing
> > > to an A record in a different SOA versus an MX pointing to a CNAME
> > > pointing to an A record where at least one pair is local (same SOA).
> > 
> >         Ah!  But now you are placing conditions on it (that at least one
> > pair is local).  That is the very fine distinction that makes up the
> > "not quite" in the "almost" above and the difference between the "should
> > not" vs the "must not" in the specifications.  You basically can't qualify
> > it by saying "you can do this, but only if one pair is in the same SOA".


> No.  My point is that potential for inefficiency is not a valid reason
> for banning something outright.  This should be an administrative
> decision, nothing more.

	But, wait a minute.  CNAME -> CNAME is a "must not".  MX -> CNAME
is a "should not".  The "should not" leaves it to be implimentation
dependent and not an outright ban.  Sooo...

	I personally have no problem with Bind 9.x prohibiting an
MX -> CNAME, but that's an implimentation issue.

	In case people have tuned in late, there have been some rather
radical swings in Bind policy since Bind 4.x.

	Bind 8.x decided to ENFORCE (with a vengence) the character set
policies dictated by RFC.  This was (so they claimed) to protect poorly
coded programs that were prone to blowing chunks and doing Chernobyl
imitations on getting illegal characters in host names.  Of course that
also caused zones with underscores in names (more common than what you
would think) to crap all over themselves when unsuspecting (i.e. failure
to read warnings) admins upgraded.

	Bind 9.0 went back to the old 4.9 policy on characters (allow
what can be entered and poorly coded programs are on their own) but started
enforcing a requirement for a TTL directive and making the SOA TTL field
the true minimum TTL that it was defined as (instead of a default like
Bind 8 and 4 and previous used it as).  I figured I was all set, since I,
of course, had upgraded all MY zone files already.  Imagine my surprise
when 9.0 would not even load because OVER HALF of the 200+ zones I'm
responsible for or host did NOT have the $TTL directive!  It was assholes
and elbows for a not so brief but really intense time while I updated those
$@$%#@ zone files!

	You don't like the Bind enforcement of the DNS policy, bitch to
the ISC bunch.  They can be swayed (all too often, it appears).  If enough
DNS administrators really want to go against the "should not", maybe
they will make it configurable (Actually, I didn't think it really outright
prohibited it in the first place, but...  Oh well...)  There are lots
of other things in the DNS that need to be killed DEAD with a stake
through the heart like CNAME with other data (what is THAT suppose to
mean).  I run into lookups on sites with CNAMES and A records for a host!
I suppose one can come up with a hierachial reason for doing such
byzantine things, but do you REALLY want to?  In applying the KISS
principle (admitedly an oxymoron when it comes to DNS) I can see some
people wanting to ban MX -> CNAME in general if, for no other reason,
than to insure that you will do it only if you have really STRONG
reasons for doing it.

> 	-hpa

> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
