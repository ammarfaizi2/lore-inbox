Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288262AbSBDDTW>; Sun, 3 Feb 2002 22:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288274AbSBDDTM>; Sun, 3 Feb 2002 22:19:12 -0500
Received: from relay1.pair.com ([209.68.1.20]:14860 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S288262AbSBDDSz>;
	Sun, 3 Feb 2002 22:18:55 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5DFF0F.3B5EFFC0@kegel.com>
Date: Sun, 03 Feb 2002 19:25:03 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kev <klmitch@MIT.EDU>
CC: Arjen Wolfs <arjen@euro.net>, coder-com@undernet.org,
        feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <200202040255.VAA20532@multics.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kev wrote:
> 
> > > I don't understand what it is you're saying here.  The ircu server uses
> > > non-blocking sockets, and has since long before EfNet and Undernet branched,
> > > so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.
> >
> > Right.  poll() and Solaris /dev/poll are programmer-friendly; they give
> > you the current readiness status for each socket.  ircu handles them fine.
> >
> > /dev/epoll and Linux 2.4's rtsig feature, on the other hand, are
> > programmer-hostile; they don't tell you which sockets are ready.
> > Instead, they tell you when sockets *become* ready;
> > your only indication that those sockets have become *unready*
> > is when you see an EWOULDBLOCK from them.
> 
> If I'm reading Poller_sigio::waitForEvents correctly, the rtsig stuff at
> least tries to return a list of which sockets have become ready, and your
> implementation falls back to some other interface when the signal queue
> overflows.  It also seems to extract what state the socket's in at that
> point.
> 
> If that's true, I confess I can't quite see your point even still.  Once
> the event is generated, ircd should read or write as much as it can, then
> not pay any attention to the socket until readiness is again signaled by
> the generation of an event.  Sorry if I'm being dense here...

If you actually do read or write *until an EWOULDBLOCK*, no problem.
If your code has a path where it fails to do so, it will get stuck,
as no further readiness events will be forthcoming.  That's all.
- Dan
