Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130774AbRAGP57>; Sun, 7 Jan 2001 10:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130656AbRAGP5k>; Sun, 7 Jan 2001 10:57:40 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:33700 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130151AbRAGP5f>;
	Sun, 7 Jan 2001 10:57:35 -0500
Date: Sun, 7 Jan 2001 10:56:23 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: "David S. Miller" <davem@redhat.com>
cc: <ak@suse.de>, <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <200101070543.VAA24689@pizda.ninka.net>
Message-ID: <Pine.GSO.4.30.0101071026070.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2001, David S. Miller wrote:

> I could not agree more.  This reminds me to do something I could not
> justify before, making netlink be enabled in the kernel and
> non-configurable.

I always use netlink and friends for something or the other. Route
protocols, traffic control configuration, device configuration,
firewalling; I dont see a problem turning it on. Maybe defaulting it to
on, and then totaly getting rid of the config option.

> I could almost, but not quite, justify it right now just because "ip"
> is becomming standard and needs it.

"ip" has been standard to some people for a few moons now ;->
It is more documneted than ifconfig ;-> and does a lot more

>
>    Not to stray from the subject, Ben's effort is still needed. I think real
>    numbers are useful instead of claims like it "displayed faster"
>
> See my previous email, if it's just slow because of some poorly coded
> version of ifconfig, it does not justify the patch.  If only a
> forcefully created "benchmark" can show some performance problem, that
> is not an acceptable reason to champion this patch.  Ok?
>

True.
All the kernel paths affected are really config/control paths as well as
slow paths (eg some device binding to sockets, MSG_DONTROUTE slow path,
traffic control setup, route config, arp config are some that seem useful).

The argumenet for the patch (and it might be weak) If you have 4000
devices, it makes sense for two reasons:
-Some of these paths might hold locks which might stall the fast path.
-Or if you have a busy system, they will contribute to the load.

I used to be against VLANS being devices, i am withdrawing that comment; it's
a lot easier to look on them as devices if you want to run IP on them. And
in this case, it makes sense the possibilirt of  over a thousand devices
is good.

So instead of depending what ifconfig does, maybe a better test for Ben is
to measure the kernel level improvement in the lookup for example from
2..6000 devices. Tests with the user space tools will also help. example
to add to Andi's flavor:
"date; time ifconfig -a; date" for each number of devices.
repeat for ip as well ;->
Plot kernel and the two user tools results after several iterations
(number of devices on x-axis and some time/CPU measure on y-axis).

cheers,
jamal




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
