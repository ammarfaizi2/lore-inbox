Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153844-31090>; Wed, 23 Dec 1998 09:38:57 -0500
Received: from smtp-out-006.wanadoo.fr ([193.252.19.98]:62315 "EHLO wanadoo.fr" ident: "root") by vger.rutgers.edu with ESMTP id <154455-31090>; Wed, 23 Dec 1998 09:35:28 -0500
From: christophe.leroy5@capway.com
Message-Id: <199812231531.QAA17905@wanadoo.fr>
To: Patrick Kursawe <kursawe@zaphod.anachem.ruhr-uni-bochum.de>
Date: Wed, 23 Dec 1998 16:33:54 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: ipip tunnel - route complains!
CC: linux-kernel@vger.rutgers.edu
X-mailer: Pegasus Mail for Win32 (v3.01d)
Sender: owner-linux-kernel@vger.rutgers.edu

>Hi,

>it looks like I can't get ipip tunneling to work. I use kernel 2.1.131 >and
>net-tools 1.49. I asked for help a few days ago and someone told >me to
>upgrade to the newest net-tools. Done. Still the same problem:


>Short version of what I tried:

>ifconfig tunl0 192.168.1.44 netmask 255.255.255.255 up
>route add -net 192.168.1.0 netmask 255.255.255.0 gw >134.147.2.1 dev tunl0
>SIOCADDRT: Network is unreachable

One solution to get it work quite correctly with nothing else:
route add -host 134.147.2.1 gw your_router
ifconfig tunl0 192.168.1.44 netmask 255.255.255.255 pointopoint 
134.147.2.1
route add -net 192.168.1.0 netmask 255.255.255.0 gw 134.147.2.1 
tunl0

as 134.147.2.1 has been declared pointopoint, it can be a gateway
as you have a host route via eth0 before route via tunl0 it works.
So this solution works, but is not the good one.

Second solution is:
 
- Get iproute2 package from ftp.inr.ac.ru/ip-routing
- Do on each side:
       ip tunnel add tunl1 mode ipip local your_eth0_ip remote 
rmt_eth0_ip
       ifconfig tunl1 this_side_tunnel_ip
 
dont know why, it doesnt work with tunl0

Both solutions works, the last one is hower the good one, 

christophe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
