Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132847AbRDQTmL>; Tue, 17 Apr 2001 15:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRDQTkZ>; Tue, 17 Apr 2001 15:40:25 -0400
Received: from HIC-SR2.hickam.af.mil ([131.38.214.17]:36522 "EHLO
	hic-sr2.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S132847AbRDQTjv>; Tue, 17 Apr 2001 15:39:51 -0400
Message-ID: <4CDA8A6D03EFD411A1D300D0B7E83E8F6972B3@FSKNMD07.hickam.af.mil>
From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
To: "'Christopher Friesen'" <cfriesen@nortelnetworks.com>,
        Sampsa Ranta <sampsa@netsonic.fi>
Cc: linux-net <linux-net@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: ARP responses broken!
Date: Tue, 17 Apr 2001 18:07:41 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested this with kernel version 2.2.18 and arp_filter appeared to be
broken... I enabled it for /proc/sys/net/ipv4/conf/all/arp_filter,
/proc/sys/net/ipv4/conf/eth0/arp_filter and
/proc/sys/net/ipv4/conf/eth1/arp_filter and it did not change the arp
behavior at all.  I enabled hidden and it worked, is there a know problem
with this functionality?

	Sam Bingner
	PACAF CSS/SCHE
	Contractor RSIS
	DSN	315 449-7889
	COMM	808 449-7889


-----Original Message-----
From: Christopher Friesen [mailto:cfriesen@nortelnetworks.com]
Sent: Tuesday, April 17, 2001 4:25 AM
To: Sampsa Ranta
Cc: linux-net; linux-kernel
Subject: Re: ARP responses broken!


Sampsa Ranta wrote:

> I have two interfaces that share same subnet, I call eth0 194.29.192.37
> and eth1 194.29.192.38. I have forwarding turned on, proxy arp is not
> neighter are redirects.
> 
> When I flush local neighbor table in other machine I use to observe the
> response and ping the router I get response like:
> 
> 23:38:25.278848 > arp who-has 194.29.192.38 tell 194.29.192.10
(0:50:da:82:ae:9f)
> 23:38:25.278988 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:64
(0:50:da:82:ae:9f)
> 23:38:25.279009 < arp reply 194.29.192.38 is-at 0:1:2:dc:d2:6c
(0:50:da:82:ae:9f)
> 
> The second one is the valid one, but both interfaces seem to answer to the
> broadcasted packet with their own ARP addresses.

This is the default Linux behaviour.  It can be turned off by running the
following command as root:

echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

This ensures that interfaces will only respond to arp requests for IP
addresses
which are configured as belonging to that particular interface.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
