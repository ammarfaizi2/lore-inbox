Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbRFBOvV>; Sat, 2 Jun 2001 10:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbRFBOvM>; Sat, 2 Jun 2001 10:51:12 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:50818 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S262588AbRFBOu5>;
	Sat, 2 Jun 2001 10:50:57 -0400
Date: Sat, 2 Jun 2001 10:49:01 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.LNX.4.33.0106011620340.18082-100000@kenzo.iwr.uni-heidelberg.de>
Message-ID: <Pine.GSO.4.30.0106011357000.11540-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Jun 2001, Bogdan Costescu wrote:

> On Fri, 1 Jun 2001, jamal wrote:
>
> > One idea i have been toying with is to maintain hysteris or threshold of
> > some form in dev_watchdog;
>
> AFAIK, dev_watchdog is right now used only for Tx (if I'm wrong, please
> correct me!). So how do you sense link loss if you expect only high Rx
> traffic ?
>

Good question. Makes me think. Thoughts further below.

> > example: if watchdog timer expires threshold times, you declare the link
> > dead and send netif_carrier_off netlink message.
> > On recovery, you send  netif_carrier_on
>
> I assume that you mean "on recovery" as in "first succesful hard_start_xmit".
>

right.

> > Assumption:
> > If the tx path is blocked, more than likely the link is down.
>
> Yes, but is this a good approximation ? I'm not saying that it's not, I'm
> merely asking for counter-arguments.

It is an indirect approximation. Note that if the system data is very
asymetrical as in the case you pointed out, notification will take a long
long time. You need a plan B. Still, the tx watchdogs are a good source of
fault detection in the case of non-availabilty of MII detection and even
with the presence of MII.

I hate making this more complex than it should be:

Since we already have a messaging system within the kernel and
user<->kernel space aka "netlink" -- one could easily add a protocol in
user space which "dynamically heartbeats" the devices. Control should come
from user space; it would be a great idea to avoid ioctls.

"Dynamic" in the above sense means trying to totaly avoid making it a
synchronous poll. The poll rate is a function of how many packets go out
that device per average measurement time. Basically, the period that the
user space app dumps "hello" netlink packets to the kernel is a variable.

cheers,
jamal


