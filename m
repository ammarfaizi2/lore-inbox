Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTCCOB4>; Mon, 3 Mar 2003 09:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTCCOB4>; Mon, 3 Mar 2003 09:01:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52357 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265174AbTCCOBy>; Mon, 3 Mar 2003 09:01:54 -0500
Date: Mon, 3 Mar 2003 09:13:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Niels den Otter <otter@surfnet.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: IGMP problem with 2.5 kernels
In-Reply-To: <20030303134904.GA19636@pangsit>
Message-ID: <Pine.LNX.3.95.1030303090132.22417A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Niels den Otter wrote:

> On Wednesday, 12 February 2003, Niels den Otter wrote:
> > On Monday, 10 February 2003, Niels den Otter wrote:
> > > I have tried to run several IP Multicast applications (SDR, Vat,...)
> > > with on 2.5 kernels (now running 2.5.59bk3) without succes. Same
> > > applications appear to work on 2.4 kernels.
> > > 
> > > What seems to be happening is that the application binds to the lo
> > > interface instead of eth0 so that no IGMP queries are send out on
> > > the ethernet interface. I have a small application that tries to
> > > listen to address 233.4.5.9 and here is /proc/net/igmp with and
> > > without the app  running:
> > 
> > Did more debugging and disabled my loopback interface to ensure the
> > mcast apps don't bind to this interface. strace shows all applications
> > go wrong with the same error. Is this kernel related?
> 
> In the meantime I have had verious discussion on this subject with
> Antonio Querubin and others and I don't know any solution yet.
> 
> Is anyone able to use multicast applications on recent 2.5 kernels and
> make it send out IGMP joins on an ethernet device?
> 
> RFC 1112 says
>  If the upper-layer protocol chooses not to identify an outgoing
>  interface, a default interface should be used, preferably under the
>  control of system management.
> 
> In Linux 2.4 kernels this seems to work with adding a route for
> 224.0.0.0/4 on the desired ethernet interface. This doesn't work in 2.5
> kernels however.
> 
> 
> Anyone who knows what the problem is and how it can be solved?
> 
> 
> Thanks,

Did you try to use bind() to bind your socket to a specific interface?
Using `route` to obtain side-effects is not the correct way. The
application needs to bind the socket to a specific interface if
the applications requires a specific interface (which you seem to
require). Otherwise, the first interface found will be used as
the default. If you can't rebuild the programs, you might work-
around the problem by modifying start-up so that your ethernet
interfaces are started before loop-back.

You can expriment without rebooting...

Remove all routing entries first.
route del -default xxx
route del -net xxx, etc.

`ifconfig eth0 down`
`ifconfig lo down`

Completely reconfigure eth0 first....
Then configure lo.

If you don't remove all the routing entries first, you don't
really end up with a new configuration. Something 'remembers'
and the order of entries doesn't get changed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


