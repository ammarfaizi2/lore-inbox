Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267784AbRGZMZ5>; Thu, 26 Jul 2001 08:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267816AbRGZMZh>; Thu, 26 Jul 2001 08:25:37 -0400
Received: from charybda.fi.muni.cz ([147.251.48.214]:13829 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S267784AbRGZMZ0>; Thu, 26 Jul 2001 08:25:26 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Thu, 26 Jul 2001 14:25:31 +0200
To: linux-kernel@vger.kernel.org
Cc: unix@fi.muni.cz
Subject: Linux 2.4 networking/routing slowdown
Message-ID: <20010726142531.G1024@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	Hello,

	I have tried to upgrade my firewall to 2.4 kernel (2.4.7), and I have
observed a major slowdown of the network speed.

	The firewall is Celeron-366 w/ 32M RAM. The server has five
ethernet ports: Two SMC Dual Etherpower NICs (Tulip chipset), and one
Intel EEPro 100. All five interfaces are running at 100baseTX-Full Duplex. The
firewall is ipchains with ~600 rules in a wide tree of chains (I guess the
maximum depth is about 20 rules. With 2.2 kernel, the firewall is able to route
about 300 Mbit/s of total bandwidth. FTP between two hosts on different
interfaces is able to reach nearly full speed of 100 Mbps network.

	Now after the upgrade, the firewall is _slow_ (it takes several
seconds to echo a single keystroke). I've figured out that ipchains.o in 2.4
is linked with connection tracking, which probably causes the main slowdown.
After rmmod ipchains the server seems to have its interactive performace
back on normal speed, but routing performance still sucks: FTP between
two hosts on different interfaces gets about 1600 KBytes/s (in 2.2 kernel
it runs at 9900 KBytes/s). When I disable CONFIG_NET_HW_FLOWCONTROL,
the throughput increases (ugh!) to 2300 KBytes/s.

	With 2.2 kernel, I use the CONFIG_IP_ROUTER=y option, which
is apparently not present in 2.4.

	Can anybody tell me why my firewall cannot route at wire
speed with 2.4, while with 2.2 it can?

	More information available on request.

	Thanks,

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
--Just returned after being 10 days off-line. Sorry for the delayed reply.--
