Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283718AbRLTK1v>; Thu, 20 Dec 2001 05:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284009AbRLTK1l>; Thu, 20 Dec 2001 05:27:41 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:29365 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S283718AbRLTK13>; Thu, 20 Dec 2001 05:27:29 -0500
Date: Thu, 20 Dec 2001 11:27:28 +0100
From: bert hubert <ahu@ds9a.nl>
To: kuznet@ms2.inr.ac.ru
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [BUG/WANT TO FIX] Equal Cost Multipath Broken in 2.4.x
Message-ID: <20011220112728.A11112@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, kuznet@ms2.inr.ac.ru,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 # ip ro add dev eth0 default nexthop via 10.0.0.1 dev eth0 nexthop via
   10.0.0.202 dev eth0
 # ip ro ls
 10.0.0.0/8 dev eth0  proto kernel  scope link  src 10.0.0.11 
 default 
 	nexthop via 10.0.0.1  dev eth0 weight 1 dead
 	nexthop via 10.0.0.202  dev eth0 weight 1

10.0.0.1 however is far from dead, if we add yet another nexthop:

 # ip ro add dev eth0 default nexthop via 10.10.10.10 dev eth0 nexthop via
   10.0.0.1 dev eth0 nexthop via 10.0.0.202 dev eth0

 # ip ro ls
 10.0.0.0/8 dev eth0  proto kernel  scope link  src 10.0.0.11 
 default 
 	nexthop via 10.10.10.10  dev eth0 weight 1 dead
 	nexthop via 10.0.0.1  dev eth0 weight 1
 	nexthop via 10.0.0.202  dev eth0 weight 1

This first nexthop is *always* declared dead. Linux 2.4.x, iproute 20010824.

If anybody can point me in the direction of this problem, it must be known
as it has been there for a *long* time, it would be appreciated. I'll try to
fix it.

Thanks!

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
