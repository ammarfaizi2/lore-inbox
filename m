Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311763AbSCOAAk>; Thu, 14 Mar 2002 19:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311870AbSCOAAb>; Thu, 14 Mar 2002 19:00:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9969 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311763AbSCOAAX>;
	Thu, 14 Mar 2002 19:00:23 -0500
Date: Thu, 14 Mar 2002 19:00:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
In-Reply-To: <E16lej0-0002FE-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Mar 2002, Alan Cox wrote:

> > I have experimented with using NFS for that -- start a local daemon that
> > exports a virtual filesystem and mount that. The great bonus is that it's
> > platform independent -- it works on Solaris, HP-UX and even Ultrix just as
> > well. Other projects have become more important, however, and I haven't
> > finished it. If you're interested, drop me a line.
> 
> There are several of these and also some folks using the coda interface
> to do the same work, as the coda interface is sometimes better suited. 

... for some kinds of work.

First of all, "VFS mediator" is simply a userland filesystem.  That's
precisely what it is - filesystem that talks to a process.  We've got
quite a few of them and which one fits the task depends on the task.

	* NFS (v2,v3):  Portable.  And that's the only good thing to say
about it - it's stateless, it has messy semantics all over the place and
implementing userland server requires a lot of glue.
	* CIFS/SMB: even worse - it has some provisions for sane cache
coherency, but its heritage shows.  Neither OS/2 nor NT (not to mention
DOS derivatives) have a sane API and that's where the thing had come
from.  Protocol is choke-full of ugly crap and stuff that doesn't map
on UNIX (and these categories overlap).
	* NFS v4: take NFS, mix with SMB, shake, evaporate and you've got
it.  Wave Of Future(tm) according to committee that had produced it.
If they are right we'll need gas masks and dramamine.
	* NCP: Creature from Black Latrine.  As elegant and sane
as its parent company - take a lot of bitty-box ad-hackery from 80s,
let it rot for 15 years and you've got it.
	* CODA: nice if you want commit-on-close semantics and basically
want a lot of regular files.  More or less portable, userland side doesn't
require much glue.  Has a nice local caching and as the result bad for any
RPC-style uses.
	* 9P: more or less sane UNIX semantics, very well suited for
RPC-style stuff, moderate amounts of glue in clients.  Standard on Plan 9
and Inferno, has a protable UNIX client (export a subtree of existing
filesystem over 9P).  There are implementations for Linux and FreeBSD, but
both need more work.  There are provisions for local caching, but AFAIK
nobody had seriously played with them.
	* 9P2000: extended version of the above.  It would be nice if
somebody who has specifications would post them.

	Sane projects: toolkit for light-weight NFS servers; cleanup of
similar toolkit for CODA (podfuk); getting 9P implementations up to date
and giving them a decent beating (possibly - with modifications needed
for 9P2000).

