Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTJ3DMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTJ3DMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:12:39 -0500
Received: from h1ab.lcom.net ([216.51.237.171]:29315 "EHLO digitasaru.net")
	by vger.kernel.org with ESMTP id S262156AbTJ3DMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:12:35 -0500
Date: Wed, 29 Oct 2003 21:12:25 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       Dax Kelson <dax@gurulabs.com>, Hans Reiser <reiser@namesys.com>,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-ID: <20031030031223.GA15309@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Alex Belits <abelits@phobos.illtel.denver.co.us>,
	Dax Kelson <dax@gurulabs.com>, Hans Reiser <reiser@namesys.com>,
	andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <3FA0475E.2070907@namesys.com> <1067466349.3077.274.camel@mentor.gurulabs.com> <20031030002005.GC3094@digitasaru.net> <Pine.LNX.4.58.0310291848590.11170@sm1420.belits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310291848590.11170@sm1420.belits.com>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Alex Belits on Wednesday, 29 October, 2003:
>On Wed, 29 Oct 2003, Joseph Pingenot wrote:
>> >> them.
>> >Except, they didn't release a beta.
>> >They released a developer preview (not even alpha), mostly to show off
>> >the APIs.
>> >AFAIK the developer preview has no WinFS bits in it at all.
>> Regardless, it's an interesting idea, and one which might be fruitful.
>  There is another possibility -- that the only implementation of the
>standardized indexable/searchable format that Microsoft wants to base this
>system on is a horrendous resource pig, infected with inflexible
>restrictions and requirements, that everything will have to follow, and
>will be unable to do any further progress in various directions where
>non-Microsoft software has advantage.

Interesting take on XML.

>  What most of XML-based formats certainly are. If further development
>will blindly take this road, we will lose huge amount of flexibility in
>exchange for a certain Microsoft-compatible (for a while) system of
>organizing data. But, say, using grep on a text file will become

Actually, the point isn't to be Microsoft-compatible; rather, it's to
  aid in the indexing of information for quick search and cross-reference
  (their thrust at the 'knowledge worker').

>impossible without making a XML-ified file, and XML-ified grep. Pipes and
>sockets will have to be redesigned, too, and many kinds of low-level
>functionality that Unixlike systems enjoyed thanks to unified file
>descriptors and nonintrusive way of OS handling the data will become
>cumbersome second-class citizens in a world where structured data files
>(VMS? Mainframes?) and strong file-type binding (MacOS? PalmOS?) are what
>the system is based on. Not to mention niceties like having to stuff the

Well, the point of making this a modular userspace daemon is that we don't
  *have* to dictate any such thing.  The idea is that writes could be
  piped through the indexing daemon, and the daemon would then have plugins
  that understand *different* formats.  Optionally, I suppose, one could
  add a new open() flag to say "don't index this".

>whole expat into the kernel, and enjoy memory bloat and various kinds of
>DoS based on that. It won't harm Microsoft a single bit -- it would be

The idea is also to keep the kernel as clean as possible, while keeping
  it also as transparent/opaque (depending on your viewpoint) as possible.

There are two extrema: completely in-kernel (either dictating the choice
  of backend and formats or using modules to allow choice) and completely
  userspace.  The nicety of in-kernel is speed and the fact that the process
  need not know anything about the indexing unless it wants to.  The cost
  is stability and security.  The nicety of userspace is that it is very
  highly modular, with obvious, strict APIs and the security that goes
  with being in userspace.  The cost is the context switching performance
  hit and the fact that each process that wants to index its stuff must
  tell the filesystem and the indexing service its data (effectively, two
  writes and a completely separate API).  [I'm likely preaching to the
  choir here, but it's good to outline it]

I think the Golden Mean is, erm, in the mean.  :)

>their wet dream to outlaw all file formats but MS Office, and make every
>program talk through the Office-based interface, but it will turn Linux
>(or any other system that follows this idea) into something else.

Indeed, but we're not trying to dictate a format.  That's why it'd have
  to be pluggable.  Unix/Linux is all about choice and freedom.  Let
  Microsoft straightjacket their product; we should build it open, transparent,
  and free, and welcome the Microsoft refugees.

>It may be a great idea to add additional interfaces that will provide
>a similar functionality through multiple userspace applications that will
>form another layer of data access. But those can't be just stuffed into
>kernel, or have one, set in stone format, imposed on files and queries. It

Dang straight.

>may allow something compatible with Microsoft, but it certainly should not
>grant immortality to current incarnation of XML, SQL and derivatives of
>those. Linux's greatest strength is in providing good infrastructure, and

Indeed.  That's the whole point of choice and freedom.  If/when something
  better comes along, the implementer can quickly add the format to the
  indexing service, and people will find the transition that much easier.
  And humanity is better off for the ease in migration.

>just stuffing particular (bound to be bad) implementations of some ideas
>(that are not necessarily good beyond their basic core) into the system
>instead of providing sufficient infrastructure to provide those in various
>ways, makes it more like an ideologically-charged finished environment
>than an infrastructure for creating such environments. Microsoft always
>created narrowly-defined, bloated, followed-the-party-line environments
>that captured and confined the developers. There is no need to imitate
>that in a system that is known for being just the opposite.

Indeed.  Couldn't agree more.  That's why we should create *infrastructure*
  for such an indexing service, and allow the community to create plugins
  as needed.

I'm sure the user community can come up with excellent ways of using such
  a service, especially when it's open and free.  (Indeed, I just thought
  of a new use: identifying .desktop files on the system, and potentially
  linking them together in menus automatically, regardless of their location.
  Such an implementation would require a .desktop file indexing plugin, but
  with such an open and free system, it's quite easy, I'd think.)

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Asked by CollabNet CTO Brian Behlendorf whether Microsoft will enforce its
 patents against open source projects, Mundie replied, 'Yes, absolutely.'
 An audience member pointed out that many open source projects aren't
 funded and so can't afford legal representation to rival Microsoft's. 'Oh
 well,' said Mundie. 'Get your money, and let's go to court.' 
Microsoft's patents only defensive? http://swpat.ffii.org/players/microsoft
