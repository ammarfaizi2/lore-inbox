Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133096AbRAVUDD>; Mon, 22 Jan 2001 15:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135333AbRAVUCy>; Mon, 22 Jan 2001 15:02:54 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:50315 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S133096AbRAVUCf>; Mon, 22 Jan 2001 15:02:35 -0500
Date: Mon, 22 Jan 2001 12:01:23 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Val Henson <vhenson@esscom.com>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010122123707.B17540@esscom.com>
Message-ID: <Pine.LNX.4.31.0101221159120.29530-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how about always_defragment (or whatever the option is now called) so that
your routing box always reassembles packets and then fragments them to the
correct size for the next segment? wouldn't this do the job?

David Lang


 On Mon, 22 Jan 2001, Val Henson wrote:

> Date: Mon, 22 Jan 2001 12:37:07 -0700
> From: Val Henson <vhenson@esscom.com>
> To: David Lang <dlang@diginsite.com>
> Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
> Subject: Re: Is sendfile all that sexy?
>
> On Mon, Jan 22, 2001 at 10:27:58AM -0800, David Lang wrote:
> > On Mon, 22 Jan 2001, Val Henson wrote:
> >
> > > There is a use for an optimized socket->socket transfer - proxying
> > > high speed TCP connections.  It would be exciting if the zerocopy
> > > networking framework led to a decent socket->socket transfer.
> >
> > if you are proxying connextions you should really be looking at what data
> > you pass through your proxy.
> >
> > now replay proxying with routing and I would agree with you (but I'll bet
> > this is handled in the kernel IP stack anyway)
>
> Well, there is a (real-world) case where your TCP proxy doesn't want
> to look at the data and you can't use IP forwarding.  If you have TCP
> connections between networks that have very different MTU's, using IP
> forwarding will result in tiny packets on the large MTU networks.
>
> So who cares?  Some machines, notably Crays and NEC's, have a severely
> rate-limited network stack and can only transmit up to about 3500
> packets per second.  That's 40 Mbps on a 1500 byte MTU network, but
> greater than line speed on HIPPI (65280 MTU, 800 Mbps).
>
> So, for a rate-limited network stack on a HIPPI network, the best way
> to talk to a machine on a gigabit ethernet network is through a TCP
> proxy which just doesn't care about the data going through it.  Hence
> my interest in socket->socket sendfile().
>
> I'll admit this is an odd corner case which isn't important enough to
> justify socket->socket sendfile() on its own.  But this odd corner
> case did make enough money to pay my salary for years to come. :)
>
> -VAL
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
