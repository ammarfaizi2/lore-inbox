Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbTC0Ae7>; Wed, 26 Mar 2003 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262727AbTC0Ae7>; Wed, 26 Mar 2003 19:34:59 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:31504 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262722AbTC0Ae5>; Wed, 26 Mar 2003 19:34:57 -0500
Date: Wed, 26 Mar 2003 16:46:01 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030327004601.GI27622@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030326103036.064147C8DD@merlin.emma.line.org> <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com> <20030326201031.GA29746@merlin.emma.line.org> <20030326211508.GD16662@gtf.org> <Pine.LNX.4.50.0303261331540.1391-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303261331540.1391-100000@twinlark.arctic.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 01:33:45PM -0800, Jauder Ho wrote:
> 
> one suggestion I would make would be to break out the regex into a
> seperate file, that way you will no longer need to touch the script once
> the core logic is correct.
> 
> got this working nicely to count users based upon patterns.
> 
> --jauder

Second that.

Should definitely be split between fixed (quick hash lookup)
and regex.  Regexes for dns entries get ugly fast (. as
wildcard).  The split could be done while slurping the file
(check for /\*\[\]\+/).

> 
> On Wed, 26 Mar 2003, Jeff Garzik wrote:
> 
> > On Wed, Mar 26, 2003 at 09:10:31PM +0100, Matthias Andree wrote:
> > > On Wed, 26 Mar 2003, Linus Torvalds wrote:
> > >
> > > > Btw, one feature I'd like to see in shortlog is the ability to use
> > > > regexps for email address matching, ie something like
> > > >
> > > > 	'torvalds@.*transmeta.com' => 'Linus Torvalds'
> > > > 	...
> > > > 	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
> > > > 	...
> > > > 	'bcrl@redhat.com' => 'Benjamin LaHaise',
> > > > 	'bcrl@.*' => '?? Benjamin LaHaise',
> > > > 	..
> > > >
> > > > I don't know whether you can force perl to do something like this, but if
> > > > somebody were to try...
> >
> > Perl is very regex-friendly.  Sure it can do this :)
> >
> >
> > > I'd like to keep the hash for all those addresses that aren't wildcards
> > > and that aren't regexps -- we have fast, that is O(1) to O(log n),
> > > access to the hash (depending on Perl's implementation) and we have
> > > worse than O(n) for regexp, where n is the count of address strings or
> > > regexps.
> > >
> > > Would you agree to a version that has a set of fixed addresses and a
> > > separate list of regexps, tries the hash first and then a list of
> > > regexps?  That sounds like a) easy addition, b) good performance to me
> > > (before implementing it). If so, I could add some code for that feature.
> >
> > Do we really care about performance here?
> >
> > I think maintain-ability is probably more important.
> >
> > In any case, splitting the lists into "fixed" and "regex" doesn't seem
> > like a bad idea, provided that the change was fairly easy and
> > self-contained.
> >
> > 	Jeff
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
