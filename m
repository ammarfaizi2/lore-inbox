Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284611AbRLIXOK>; Sun, 9 Dec 2001 18:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284604AbRLIXN7>; Sun, 9 Dec 2001 18:13:59 -0500
Received: from pak200.pakuni.net ([207.91.34.200]:19191 "EHLO
	smp.paktronix.com") by vger.kernel.org with ESMTP
	id <S284555AbRLIXNo>; Sun, 9 Dec 2001 18:13:44 -0500
Date: Sun, 9 Dec 2001 17:13:57 -0600 (CST)
From: "Matthew G. Marsh" <mgm@paktronix.com>
X-X-Sender: <mgm@netmonster.pakint.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Oliver Xymoron <oxymoron@waste.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Default outgoing IP address?
In-Reply-To: <Pine.LNX.3.96.1011127151949.31174F-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.31.0112091712140.21426-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Bill Davidsen wrote:

> On Mon, 26 Nov 2001, Oliver Xymoron wrote:
>
> > On a machine with multiple interfaces, is it possible to set the default
> > outgoing IP address to something other than the address for the interface
> > on the outgoing route?

Yes.

ip route add 10.1.1.0/24 via 192.168.1.1 src 172.16.1.1
                                         ^^^
The src parameter tells the routing code to use this address when sending
packets. The address only needs to be on the system. IE:

ip addr add 172.16.1.1/32 dev dummy0

And send the packets out of eth0.

> > For instance, a machine acts as a gateway, with addresses A and B, where A
> > faces the world (but isn't in DNS) and B is the canonical address.
> > Outgoing connections from the machine should appear to come from B.
>
> If you mean having multiple IP addresses on the same NIC, sure you can do
> that, see the section on DNAT in iptables. However, if you have multiple
> NICs, you do not want to send a packet from one which has the IP of the
> other, as your router is very likely to become confused and get its ARP
> table in a twist.

No need for DNAT. Just routing.

> You can force packets out one NIC or the other, usually using iproute, but
> I don't think that's what you have in mind, is it? In any case, doable.
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250 x101
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

