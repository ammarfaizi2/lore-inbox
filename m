Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293351AbSBYIja>; Mon, 25 Feb 2002 03:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293345AbSBYIjV>; Mon, 25 Feb 2002 03:39:21 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:55782 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S293341AbSBYIjN>; Mon, 25 Feb 2002 03:39:13 -0500
Date: Mon, 25 Feb 2002 09:39:11 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Equal cost multipath crash
Message-ID: <20020225083911.GA18777@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello network hackers,

	I had a strange failure of my Linux router yesterday. It is quite
uncommon setup, but I wonder what could have caused this. The router
started to dump the following messages into the syslog, and it stopped
routing so our network was not reachable from the outside world:

Feb 24 21:26:49 router kernel: impossible 888
Feb 24 21:39:20 router kernel: ible 888
Feb 24 21:39:20 router kernel: impossible 888
Feb 24 21:39:20 router last message repeated 42 times
Feb 24 21:39:20 router kernel: impossible 888
Feb 24 21:39:21 router kernel: NET: 344 messages suppressed.
Feb 24 21:39:21 router kernel: dst cache overflow
Feb 24 21:39:21 router kernel: impossible 888
Feb 24 21:39:21 router last message repeated 275 times
[... and so on ...]

	After few minutes, a co-worker of mine pressed the big red button.

	The box is dual Athlon 1200 MP (Tyan Thunder K7 board), two
on-board NICs (some kind of 3c90x) - eth0 and eth1 - running IPv4 over
ethernet, and one 3c985B (Tigon II, eth2) gigabit NIC, running IPv4 over
802.1Q VLANs. I have five VLANs on the gigabit NIC. 

	Routing was set up statically, with about 100 IP rules
(used mainly for blocking IP addresses -- ip rule ... blackhole).
In the routing table "main", there was static routes
to directly connected LANs or VLANs, and one default route, which
did equal cost multipath over eth0 and one VLAN - eth2.61:

ip route add default table main nexthop via IP1 dev eth0 \
	nexthop via IP2 dev eth2.61

	There was one more routing table used mainly for testing
and experiments. Most of time (and at the time of crash) it looked
the same way as the table "main", and some IPs were directed to this
table using IP rules.

	Kernel 2.4.17, RedHat 7.2 with updates.

	What could cause this problem? I am willing to send more information
on request.

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|\    As anyone can tell you trying to force things on Linux developers   /|
|\\   generally works out pretty badly.              (Alan Cox in lkml)  //|
