Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSBDCzt>; Sun, 3 Feb 2002 21:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSBDCzj>; Sun, 3 Feb 2002 21:55:39 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:27566 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S288248AbSBDCzc>; Sun, 3 Feb 2002 21:55:32 -0500
Message-Id: <200202040255.VAA20532@multics.mit.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Dan Kegel <dank@kegel.com>
cc: Kev <klmitch@MIT.EDU>, Arjen Wolfs <arjen@euro.net>,
        coder-com@undernet.org, feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork performance
In-Reply-To: Your message of "Sun, 03 Feb 2002 16:37:43 PST."
             <3C5DD7D7.64A52BB1@kegel.com> 
Date: Sun, 03 Feb 2002 21:55:25 -0500
From: Kev <klmitch@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't understand what it is you're saying here.  The ircu server uses
> > non-blocking sockets, and has since long before EfNet and Undernet branched,
> > so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.
> 
> Right.  poll() and Solaris /dev/poll are programmer-friendly; they give 
> you the current readiness status for each socket.  ircu handles them fine.
> 
> /dev/epoll and Linux 2.4's rtsig feature, on the other hand, are
> programmer-hostile; they don't tell you which sockets are ready.
> Instead, they tell you when sockets *become* ready;
> your only indication that those sockets have become *unready*
> is when you see an EWOULDBLOCK from them.

If I'm reading Poller_sigio::waitForEvents correctly, the rtsig stuff at
least tries to return a list of which sockets have become ready, and your
implementation falls back to some other interface when the signal queue
overflows.  It also seems to extract what state the socket's in at that
point.

If that's true, I confess I can't quite see your point even still.  Once
the event is generated, ircd should read or write as much as it can, then
not pay any attention to the socket until readiness is again signaled by
the generation of an event.  Sorry if I'm being dense here...
-- 
Kevin L. Mitchell <klmitch@mit.edu>

