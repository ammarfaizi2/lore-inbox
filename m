Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136105AbRAHAiu>; Sun, 7 Jan 2001 19:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136156AbRAHAia>; Sun, 7 Jan 2001 19:38:30 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:49316 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S136079AbRAHAi1>;
	Sun, 7 Jan 2001 19:38:27 -0500
Date: Sun, 7 Jan 2001 19:37:30 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Sandy Harris <sandy@storm.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device lookup(DoesNOT
   meet Linus' sumission policy!)
In-Reply-To: <3A58D49D.C4152BD5@candelatech.com>
Message-ID: <Pine.GSO.4.30.0101071922200.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Ben Greear wrote:

> Hrm, what if they just made each IP-SEC interface a net_device?  If they
> are a routable entity, with it's own IP address, it starts to look a lot
> like an interface/net_device.

As in my response to Matti, i thing a netdevice is a generalized link
layer structure and should remain that way.
To add a new naming convention a "link" or maybe an "interface"
is what the protocol aware part should be.
Define a routable "interface" to be  one that (from an abstraction
perspective) sits on top of a netdevice and has a ifindex, name, and IP
address (v4 or V6)
I think the goals of the author of that IPSEC article are served with this
scheme. I need to read that article, i just schemed through it.

>
> This has seeming worked well for VLANs:  Maybe net_device is already
> general enough??

I think it is not proper to generalize netdevices for IP. I am not
thinking of dead protocols like IPX, more of other newer encapsulations
such as MPLS etc.

>
> So, what would be the down-side of having VLANs and other virtual interfaces
> be net_devices?  The only thing I ever thought of was the linear lookups,
> which is why I wrote the hash code.  The beauty of working with existing
> user-space tools should not be over-looked!
>

IP configuration tools you mean. Fine, they should be used to configure
"interfaces" in the way i defined them above.

> It may be easier to fix other problems with many interface/net_devices
> than cram a whole other virtual net_device structure (with many duplicate
> functionalities found in the current net_device).
>

It makes sense from an abstraction and management perspective to have all
virtual interfaces which run on top of a physical interface to be
managed in conjuction with the device. Device goes down, you destroy them
or send them to a shutdown state (instead of messaging) etc.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
