Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbRFANkB>; Fri, 1 Jun 2001 09:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbRFANjv>; Fri, 1 Jun 2001 09:39:51 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:15795 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263244AbRFANji>; Fri, 1 Jun 2001 09:39:38 -0400
Date: Fri, 1 Jun 2001 15:39:26 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <3B179579.F9C9C721@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106011521440.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Jeff Garzik wrote:

> The loss and regain of link status should be proactively signalled to
> userspace using netlink or something similar.

[ For the general discussion ]
I fully agree, but I just wanted to give an example of legit use from
user space of _current_ values from hardware.

>  Currently we have
> netif_carrier_{on,off,ok} but it is only passively checked.
> netif_carrier_{on,off} should probably schedule_task() to fire off a
> netlink message...

[ Link status details ]
Just that not all NICs have hardware support (and/or not all drivers use
these facilities) for link status change notification using interrupts.
Right now, most drivers _poll_ for media status and based on the poll
rate, netif_carrier routines are (or should be) called. We can't make the
poll rate very small for the general case, as MII access is time
consuming (same discussion was some months ago when the bonding driver
was updated). However, for users who know that they need this info to be
more accurate (at the expense of CPU time), polling through ioctl's is the
only solution.

[ Back to general discussion ]
So far, to the problem of too often access to hardware, 2 solutions were
proposed:
1. cache the values. You can then let the user shoot him-/her-self in the
   foot by making too many ioctl calls. But this prevent any legit use of
   current hardware state.
2. rate limiting. You don't let the user access the hardware too often (to
   be defined), so he/she can't shoot his-/her-self in the foot. Legit use
   of current hardware state is possible.

IMHO, solution 2 is much better. Can you find situations when it's not ?

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De



