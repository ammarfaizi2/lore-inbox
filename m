Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135817AbRAHAWg>; Sun, 7 Jan 2001 19:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136018AbRAHAW0>; Sun, 7 Jan 2001 19:22:26 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:48292 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S135817AbRAHAWR>;
	Sun, 7 Jan 2001 19:22:17 -0500
Date: Sun, 7 Jan 2001 19:21:20 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <20010107212414.B25659@mea-ext.zmailer.org>
Message-ID: <Pine.GSO.4.30.0101071824250.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Matti Aarnio wrote:

> On Sun, Jan 07, 2001 at 02:10:52PM -0500, jamal wrote:
> > OK. I suppose an skb->vlan_tag is passed to the driver and it will know
> > what to do with it (pass it on a descriptor etc).
>
> 	Sure, nice.  WHY SHOULD THERE BE MORE LAYER-2 STUFF ADDED TO
> 	SKB OBJECTS ?
>
> 	One of important abstraction issues is to isolate device specific
> 	new things (like what VLAN/PVC/SVC is used at your favourtite
> 	802.1Q/ATM/X.25/FrameRelay connection).
>
> 	The less we leak that kind of things to SKB, the better, IMO.
> 	They are net_device issues, after all.

You are right, the IP-ization information should be a "device" specific.
What "device" means is the other discussion [I think we need new naming
conventions and abstractions]

> 	Tell me (if you can), why packet sender calls hardware-header
> 	generation for packet, if the card can insert it for you ?
> 	Consider the structure of Ethernet MAC header, where is source
> 	address ?  Where is the destination address ?  If you write the
> 	destination, why should you not write the source there too ?
>

It doesnt cost that much to do in s/ware if it is contigous and you have
the information. some form of neighbor discovery  protocol gathers
all that info for you it is pretty cheap to insert the dst/src/etherype
which you already have.
Linux already has the 14 bytes link layer header cached today based on ARP
for example. Works very nicely on the transmit path.
Now consider trying to insert the VLAN header after all this work (it goes
between the src MAC and the ethertype). If the hardware knows what to do
with the tag, you dont need the hardware header rebuilder function.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
