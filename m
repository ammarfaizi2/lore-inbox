Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129931AbQLNH7a>; Thu, 14 Dec 2000 02:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbQLNH7U>; Thu, 14 Dec 2000 02:59:20 -0500
Received: from ja.ssi.bg ([193.68.177.189]:16132 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129931AbQLNH7C>;
	Thu, 14 Dec 2000 02:59:02 -0500
Date: Thu, 14 Dec 2000 09:28:22 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Chris Dunlop <chris@onthe.net.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Source address selection
Message-ID: <Pine.LNX.4.21.0012140904580.869-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Chris Dunlop wrote:

> using the IPs on the aliases as source addresses, except of course when
> an application binds to that address.
>
> Is there a way to do this ?

ip addr add 192.168.0.1/24 brd + dev eth0 scope host
					  ^^^^^^^^^^
default is "scope global" (achieved with ifconfig too). There
is a "scope link" too.

Such address (scope host):

- will not be autoselected for the ARP probes (only scope link and global)
- will be answered/used in ARP replies (hidden=1 stops this)
- will not be autoselected in IP talks with neighbours on the links
and with talks to external hosts
- the programs can bind to it and to talk with everyone

The rule is to set the proper scope for the addresses and to add
preferred source addresses in your routes using the "ip" command,
especially for the default gateway:

ip route add ... src SRC_IP

hidden=1 is the next step to hide an IP address but it is not needed
for your setup. It is needed when many hosts share same IP address
or for other ARP filtering purposes.


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
