Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSBDAwj>; Sun, 3 Feb 2002 19:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSBDAwa>; Sun, 3 Feb 2002 19:52:30 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:27908 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288040AbSBDAwV>; Sun, 3 Feb 2002 19:52:21 -0500
Date: Sun, 3 Feb 2002 19:59:10 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Dan Kegel <dank@kegel.com>
Cc: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        <coder-com@undernet.org>, <feedback@distributopia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <3C5DD7D7.64A52BB1@kegel.com>
Message-ID: <Pine.LNX.4.44.0202031955480.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2002, Dan Kegel wrote:

> Kev wrote:
> >
> > > The /dev/epoll patch is good, but the interface is different enough
> > > from /dev/poll that ircd would need a new engine_epoll.c anyway.
> > > (It would look like a cross between engine_devpoll.c and engine_rtsig.c,
> > > as it would need to be notified by os_linux.c of any EWOULDBLOCK return values.
> > > Both rtsigs and /dev/epoll only provide 'I just became ready' notification,
> > > but no 'I'm not ready anymore' notification.)
> >
> > I don't understand what it is you're saying here.  The ircu server uses
> > non-blocking sockets, and has since long before EfNet and Undernet branched,
> > so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.
>
> Right.  poll() and Solaris /dev/poll are programmer-friendly; they give
> you the current readiness status for each socket.  ircu handles them fine.

I would have to agree with this comment.  Hybrid-ircd deals with poll()
and /dev/poll just fine.  We have attempted to make it use rtsig, but it
just doesn't seem to agree with the i/o model we are using, which btw, is
the same model that Squid (is/will be?) using.  I haven't played with
/dev/epoll yet, but I pray it is nothing like rtsig.

Basically what we need is, something like poll() but not so nasty.
/dev/poll is okay, but its a hack.  The best thing I've seen so far, but
it too seems to take the idea so far is FreeBSD's kqueue stuff(which
Hybrid-ircd handles quite nicely).


Regards,

Aaron

