Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278635AbRJSTz7>; Fri, 19 Oct 2001 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278637AbRJSTzu>; Fri, 19 Oct 2001 15:55:50 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:55524 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S278635AbRJSTze>; Fri, 19 Oct 2001 15:55:34 -0400
Message-ID: <3BD085A2.8CE0987B@nortelnetworks.com>
Date: Fri, 19 Oct 2001 15:57:22 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew G. Marsh" <mgm@paktronix.com>
Cc: kuznet <kuznet@ms2.inr.ac.ru>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to see manually specified proxy arp entries using "ip neigh"
In-Reply-To: <Pine.LNX.4.31.0110191340330.17932-100000@netmonster.pakint.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matthew G. Marsh" wrote:

> > Currently I have been doing this by manually setting proxy arping on the NIC for
> > the IP address assigned to the ethertap device.  If this feature is going to be
> > removed, then how should I be doing this?
> 
> If an IP address is routed to on the external network then it will be
> available. It does _not_ matter what interface that address is assigned
> to. EX:
> 
> ip addr add 10.1.1.1/24 dev dummy0
> ip link set dev dummy0 up
> 
> now ping 10.1.1.1 from another machine on eth0 that has an appropriate
> route. I suspect what is really biting you is that your rp_filters are way
> too restrictive on your machine.

Sorry, I guess I explained it wrong.  Ethertap has an IP address assigned to the
device in the linux kernel.  It is then configured with a point to point route
to another IP address on the other concepual end of the link (ie in userspace). 
It is this other IP address that I am proxy arping for.

Thus, 

[mtc@10.40.14.70 mtc]$ /sbin/ip add
<stuff removed>
4: tap0: <BROADCAST,MULTICAST,NOARP,UP> mtu 1500 qdisc noqueue
    link/ether fe:fd:00:00:00:00 brd ff:ff:ff:ff:ff:ff
    inet 10.40.14.73 peer 10.40.14.74/32 brd 10.40.14.255 scope global tap0

[mtc@10.40.14.70 mtc]$ /sbin/ip ro
10.40.14.74 dev tap0  proto kernel  scope link  src 10.40.14.73
<stuff removed>

[mtc@10.40.14.70 mtc]$ /sbin/arp
Address                 HWtype  HWaddress           Flags Mask            Iface
<stuff removed
10.40.14.74             *       *                   MP                    eth1


Thus, anyone arping for 10.40.14.74 (which is on top of a protocol stack in
userspace) will get the MAC address of eth1 as a response.

I cannot turn on proxy arping for the interface in general as I have eth0 and
eth1 on the same subnet and turning on proxy arping causes bad things to
happen.  Thus I have a single manual proxy entry in the arp table.


                
-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
