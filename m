Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317529AbSFKUNu>; Tue, 11 Jun 2002 16:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317532AbSFKUNt>; Tue, 11 Jun 2002 16:13:49 -0400
Received: from spruce.woods.net ([166.70.175.33]:50843 "EHLO a.smtp.woods.net")
	by vger.kernel.org with ESMTP id <S317529AbSFKUNs>;
	Tue, 11 Jun 2002 16:13:48 -0400
Date: Tue, 11 Jun 2002 14:07:53 -0600 (MDT)
From: "Christopher E. Brown" <cbrown@woods.net>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: QoS on incoming data
In-Reply-To: <3D064FE7.mail1Z311DBJT@viadomus.com>
Message-ID: <Pine.LNX.4.44.0206111351550.27344-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, DervishD wrote:

>     Hi all :)
>
>     After reading a bit of the HOWTO about traffic control and
> advanced routing, I have a doubt about the queue disciplines and
> traffic shaping.
>
>     I've seen that, except the 'ingress' qdisc (and maybe the
> hierarchycal token bucket) all other qdisc's seem to be only valid
> for outgoing traffic, although I suppose that some of those qdisc
> could be easily applied to incoming traffic.


The ingress system is for corner cases and special situations.  In
general you do not control the flows *entering* the router, but
*leaving* it.


I router or system *cannot* limit the traffic it receives, if it is
coming down the wire at you you receive it.  The ingress system simply
lets you decide to discard or delay a packet before it gets passed to
the local stack.

This allows you to cover a few corner cases, such as not being in
control of the upstream router where you *must* limit traffic *to*
the local machine.

For an example 2 interface machine, you receive traffic on A and limit
its retransmission on B, you receive traffic on B and limit its
retransmission on A.

For the special case of a server that needs to limit traffic to/from
itself you use an ingress rule  to throttle incoming traffic, and an
egress rule to throttle outbound.  To control *any* bi-directional
flow requires at least 2 rules.


 --
I route, therefore you are.

