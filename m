Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSBDGG5>; Mon, 4 Feb 2002 01:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288565AbSBDGGq>; Mon, 4 Feb 2002 01:06:46 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:31716 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S288557AbSBDGGc>; Mon, 4 Feb 2002 01:06:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Aaron Sethman <androsyn@ratbox.org>, Dan Kegel <dank@kegel.com>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork  performance
Date: Mon, 4 Feb 2002 07:11:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        <coder-com@undernet.org>, <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0202031955480.3086-100000@simon.ratbox.org>
In-Reply-To: <Pine.LNX.4.44.0202031955480.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020204060630Z16287-31368+646@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 01:59 am, Aaron Sethman wrote:
> On Sun, 3 Feb 2002, Dan Kegel wrote:
> 
> > Kev wrote:
> > >
> > > > The /dev/epoll patch is good, but the interface is different enough
> > > > from /dev/poll that ircd would need a new engine_epoll.c anyway.
> > > > (It would look like a cross between engine_devpoll.c and engine_rtsig.c,
> > > > as it would need to be notified by os_linux.c of any EWOULDBLOCK return values.
> > > > Both rtsigs and /dev/epoll only provide 'I just became ready' notification,
> > > > but no 'I'm not ready anymore' notification.)
> > >
> > > I don't understand what it is you're saying here.  The ircu server uses
> > > non-blocking sockets, and has since long before EfNet and Undernet branched,
> > > so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.
> >
> > Right.  poll() and Solaris /dev/poll are programmer-friendly; they give
> > you the current readiness status for each socket.  ircu handles them fine.
> 
> I would have to agree with this comment.  Hybrid-ircd deals with poll()
> and /dev/poll just fine.  We have attempted to make it use rtsig, but it
> just doesn't seem to agree with the i/o model we are using, which btw, is
> the same model that Squid (is/will be?) using.  I haven't played with
> /dev/epoll yet, but I pray it is nothing like rtsig.
> 
> Basically what we need is, something like poll() but not so nasty.
> /dev/poll is okay, but its a hack.  The best thing I've seen so far, but
> it too seems to take the idea so far is FreeBSD's kqueue stuff(which
> Hybrid-ircd handles quite nicely).

In an effort to somehow control the mushrooming number of IO interface 
strategies, why not take a look at the work Ben and Suparna are doing in aio, 
and see if there's an interface mechanism there that can be repurposed?

Surparna's writeup, for quick orientation:

   http://lse.sourceforge.net/io/bionotes.txt

-- 
Daniel
