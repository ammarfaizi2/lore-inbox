Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130549AbQKGB2W>; Mon, 6 Nov 2000 20:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129278AbQKGB2R>; Mon, 6 Nov 2000 20:28:17 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:15111 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S130549AbQKGB1x>;
	Mon, 6 Nov 2000 20:27:53 -0500
Message-Id: <200011070117.eA71H4v05257@sleipnir.valparaiso.cl>
To: Martin Mares <mj@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Message from Martin Mares <mj@suse.cz> 
   of "Mon, 06 Nov 2000 22:12:54 BST." <20001106221254.A1196@albireo.ucw.cz> 
Date: Mon, 06 Nov 2000 22:17:04 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@suse.cz> said:

[...]

> I think that automatic loading / unloading of modules has been a terrible hack
> since its first days (although back in these times a useful one) and that the
> era of its usefulness is over. There are zillions of problems with this
> mechanism, the most important ones being:

Strange somebody from a distribution forgets _the_ most important use of
modules: Remember old-time Slackware, with dozens of different boot
diskettes, and the imperative to compile a kernel to your machine once you
got it running?

>    o  It would have to preserve _complete_ device state over module
>       reload.

If too hard, just leave it alone: Don't allow unloading.

>    o  For many drivers, the "device currently open" concept makes no
>       sense.

Ditto.

>    o It interferes with hotplug in nasty ways. Let's have a USB host
>      controller driver with currently no devices on its bus. It's also an
>      example of a zero use count driver, but it also must not be unloaded
>      as it's needed for recognizing newly plugged in devices.

Ditto.

> I don't argue whether we need or need not some kind of persistent storage
> for the modules (it might be a good idea when it comes to hotplug, but it
> should be probably taken care of by the userspace hotplug helpers), but I
> think that it has no chance to solve the problems with automatic
> unloading.

The cases mentioned are cases where unloading (automatic or manual, doesn't
matter) would break things. Just don't allow it, ever (IPv6 does this, for
one example). Or fix the loading/unloading somehow. Strategies to be able
to do so is what is being discussed here, BTW...

> We could of course attempt to circumvent the problems listed above by
> adding some hints to module state which will say whether it's possible to
> auto-unload the module or not even if it has zero use count,

Just force a non-zero count as long as the module is in use. Wait a
minute... that is exactly what a non-zero count is supposed to mean!

>                                                              but it means
> another thing to handle in all the drivers (well, at least another thing
> to think of whether it's needed or not for each driver) and I think that
> the total effect of the autounloading mechanism (a minimum amount of
> memory saved) in no way outweighs the cost of implementing it right.

What is a "minimal ammount of memory" on the 1+Gb RAM machines I've seen
discussed here isn't at all "minimal" for somebody who has to run Linux in
4Mb, preferably less...

Linux came to be what it is today in large part because the PC nobody
wanted anymore ("too slow", "can't run XYZ") became the router/firewall/web
server/mail server/... over in some closet, and soon nobody even remembered
where the machine was physically. Don't kill this.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
