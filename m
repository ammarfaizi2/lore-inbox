Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSJaTgt>; Thu, 31 Oct 2002 14:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSJaTgt>; Thu, 31 Oct 2002 14:36:49 -0500
Received: from herald.cc.purdue.edu ([128.210.11.29]:18846 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id <S265423AbSJaTgs>; Thu, 31 Oct 2002 14:36:48 -0500
Date: Thu, 31 Oct 2002 14:42:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021031194212.GC22597@snerble.cc.purdue.edu>
Reply-To: shuey@purdue.edu
References: <Pine.LNX.4.44.0210302224180.20210-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com> <20021031171334.GA22597@snerble.cc.purdue.edu> <1036091071.8575.101.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036091071.8575.101.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Michael Shuey <shuey@purdue.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:04:31PM +0000, Alan Cox wrote:
> On Thu, 2002-10-31 at 17:13, Michael Shuey wrote:
> > I'm a user, and I request that LKCD get merged into the kernel. :-)
> > Do you feel like donating a 700-port console server?  Right, so it's LKCD
> > for me then.
> 
> Wouldn't you rather they neatly tftp'd dumps to a nominated central
> server which noticed the arrival, did the initial processing with a perl
> script and mailed you a summary ?

Generally speaking, no.

A tftp server doesn't provide enough security (specifically authentication).
It would need to be accessible from clusters in multiple buildings and on
multiple networks (some of which must be public).

I've seen more network adapter issues than drive controller issues.  In
particular, some vendors (Compaq, listen up) can't implement an eepro100 to
save their asses, especially on older hardware.

>From time to time bandwidth issues and/or network splits can prevent dumps
from being reliably delivered.

Right now we use the presence of a local dump to indicate that a machine
should not join the PBS pool (and begin to run more jobs) on a reboot.  I'd
rather not have the nodes check a central server to see if it's okay to run
jobs.  And no, I don't want machines to stay down after a crash - many nodes
are in distant corners of campus and it's cold outside. :-)  If I can fix the
problem through software I'd prefer that the problematic host be up, rather
than having to walk over to it just to hit reset and load a new kernel.

That said, it would be really nice if LKCD would log dumps to both the swap
device and to a remote server.  That way if the machine crashed because of
disk failure I'd still have an uncorrupted dump image (and could then notice
all the little errors coming back out of the swap device).  A tool to
automatically analyze a dump and email back summaries would be much more
useful, though.  If someone were to write such a widget, that'd be swell. :-)

Right now I'm less concerned with getting dumps to exactly the right place
and a bit more concerned with getting dumps in the main kernel at all.

-- 
Mike Shuey
