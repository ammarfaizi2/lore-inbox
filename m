Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263529AbRFAOQn>; Fri, 1 Jun 2001 10:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263527AbRFAOQe>; Fri, 1 Jun 2001 10:16:34 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:25730 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S263529AbRFAOQV>;
	Fri, 1 Jun 2001 10:16:21 -0400
Date: Fri, 1 Jun 2001 10:14:08 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.LNX.4.33.0106011521440.18082-100000@kenzo.iwr.uni-heidelberg.de>
Message-ID: <Pine.GSO.4.30.0106011006220.10502-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff, Thanks for copying netdev. Wish more people would do that.

On Fri, 1 Jun 2001, Bogdan Costescu wrote:

> On Fri, 1 Jun 2001, Jeff Garzik wrote:
>
> > The loss and regain of link status should be proactively signalled to
> > userspace using netlink or something similar.
>
> [ For the general discussion ]
> I fully agree, but I just wanted to give an example of legit use from
> user space of _current_ values from hardware.
>
> >  Currently we have
> > netif_carrier_{on,off,ok} but it is only passively checked.
> > netif_carrier_{on,off} should probably schedule_task() to fire off a
> > netlink message...
>
> [ Link status details ]
> Just that not all NICs have hardware support (and/or not all drivers use
> these facilities) for link status change notification using interrupts.
> Right now, most drivers _poll_ for media status and based on the poll
> rate, netif_carrier routines are (or should be) called. We can't make the
> poll rate very small for the general case, as MII access is time
> consuming (same discussion was some months ago when the bonding driver
> was updated). However, for users who know that they need this info to be
> more accurate (at the expense of CPU time), polling through ioctl's is the
> only solution.

Not really.

One idea i have been toying with is to maintain hysteris or threshold of
some form in dev_watchdog;
example: if watchdog timer expires threshold times, you declare the link
dead and send netif_carrier_off netlink message.
On recovery, you send  netif_carrier_on

Assumption:
If the tx path is blocked, more than likely the link is down.

cheers,
jamal

