Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136217AbRAGSDm>; Sun, 7 Jan 2001 13:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136242AbRAGSDd>; Sun, 7 Jan 2001 13:03:33 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:39332 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S136217AbRAGSDR>;
	Sun, 7 Jan 2001 13:03:17 -0500
Date: Sun, 7 Jan 2001 13:02:24 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Gleb Natapov <gleb@nbase.co.il>
cc: Chris Wedgwood <cw@f00f.org>, Ben Greear <greearb@candelatech.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: routable interfaces  WAS( Re: [PATCH] hashed device lookup (Does
 NOT meet Linus' sumission policy!)
In-Reply-To: <20010107193757.F28257@nbase.co.il>
Message-ID: <Pine.GSO.4.30.0101071241160.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Gleb Natapov wrote:

> > One could have the route daemon take charge of management of these
> > devices, a master device like "eth0" and a attached device like "vlan0".
> > They both share the same ifindex but different have labels.
> > Basically, i dont think there would be a problem.
> >
>
> Theoretically it seems to be possible but it's much harder to do in Zebra than
> in kernel. And "eth0" shouldn't share ifindex with "vlan0" I don't think SNMP
> will be happy about that.

A very good reason why you would want them to have separate ifindices.
Essentially, vlans have to be separate interfaces today. Other "virtual"
interfaces such as aliased devices are not going to work with route
daemons today since they dont meet this requirement.

Not to rain on Ben's parade but:
My thought was to have the vlan be attached on the interface ifa list and
just give it a different label since it is a "virtual interface" on top
of the "physical interface". Now that you mention the SNMP requirement,
maybe an idea of major:minor ifindex makes sense. Say make the ifindex
a u32 with major 16 bit and minor 16 bit. This way we can have upto 2^16
physical interfaces and upto 2^16 virtual interfaces on the physical
interface. The search will be broken into two 16 bits.

Thoughts?

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
