Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTKCH3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 02:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTKCH3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 02:29:22 -0500
Received: from de46d.ipsec0.torres.ka0.zugschlus.de ([212.126.222.70]:6148
	"EHLO torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id S261938AbTKCH3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 02:29:19 -0500
Date: Mon, 3 Nov 2003 08:29:17 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 sending out "need to fragment" on wrong interface
Message-ID: <20031103072917.GA18992@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a Linux machine with freeS/WAN for my connectivity. The
default route points to the IPSEC link. It has recently begun to send
out "need to fragment" packets on the wrong interface.

Traffic on internal interface (int0):
08:23:23.254711 192.168.130.117.3913 > 10.173.220.202.22: tcp 112 (DF)
08:23:23.295669 10.173.220.202.22 > 192.168.130.117.3913: tcp 0 (DF) [tos 0x10]
08:23:24.166039 10.173.220.202.22 > 192.168.130.117.3913: tcp 48 (DF) [tos 0x10] 
08:23:24.177886 10.173.220.202.22 > 192.168.130.117.3913: tcp 144 (DF) [tos 0x10] 
08:23:24.178021 192.168.130.117.3913 > 10.173.220.202.22: tcp 0 (DF)
08:23:24.181494 192.168.130.117.3913 > 10.173.220.202.22: tcp 48 (DF)
08:23:24.189591 10.173.220.202.22 > 192.168.130.117.3913: tcp 0 (DF) [tos 0x10]
08:23:24.193480 10.173.220.202.22 > 192.168.130.117.3913: tcp 144 (DF) [tos 0x10] 
08:23:24.320311 192.168.130.117.3913 > 10.173.220.202.22: tcp 0 (DF)
08:23:24.492389 192.168.130.117.3913 > 10.173.220.202.22: tcp 48 (DF)
08:23:24.502863 10.173.220.202.22 > 192.168.130.117.3913: tcp 112 (DF) [tos 0x10] 
08:23:24.507594 192.168.130.117.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:24.507605 192.168.130.117.3913 > 10.173.220.202.22: tcp 44 (DF)
08:23:24.525303 10.173.220.202.22 > 192.168.130.117.3913: tcp 0 (DF) [tos 0x10]
08:23:24.721878 192.168.130.117.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:25.323799 192.168.130.117.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:26.527647 192.168.130.117.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:28.935316 192.168.130.117.3913 > 10.173.220.202.22: tcp 1460 (DF)

Traffic on external interface (ipsec0):
08:23:23.254981 10.173.222.70.3913 > 10.173.220.202.22: tcp 112 (DF)
08:23:23.295116 10.173.220.202.22 > 10.173.222.70.3913: tcp 0 (DF) [tos 0x10] 
08:23:24.165446 10.173.220.202.22 > 10.173.222.70.3913: tcp 48 (DF) [tos 0x10] 
08:23:24.177235 10.173.220.202.22 > 10.173.222.70.3913: tcp 144 (DF) [tos 0x10] 
08:23:24.178225 10.173.222.70.3913 > 10.173.220.202.22: tcp 0 (DF)
08:23:24.181726 10.173.222.70.3913 > 10.173.220.202.22: tcp 48 (DF)
08:23:24.189057 10.173.220.202.22 > 10.173.222.70.3913: tcp 0 (DF) [tos 0x10] 
08:23:24.192856 10.173.220.202.22 > 10.173.222.70.3913: tcp 144 (DF) [tos 0x10] 
08:23:24.320551 10.173.222.70.3913 > 10.173.220.202.22: tcp 0 (DF)
08:23:24.492626 10.173.222.70.3913 > 10.173.220.202.22: tcp 48 (DF)
08:23:24.502248 10.173.220.202.22 > 10.173.222.70.3913: tcp 112 (DF) [tos 0x10] 
08:23:24.507881 10.173.222.70.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:24.510045 10.173.222.70.3913 > 10.173.220.202.22: tcp 44 (DF)
08:23:24.524751 10.173.220.202.22 > 10.173.222.70.3913: tcp 0 (DF) [tos 0x10] 
08:23:24.722148 10.173.222.70.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:25.324085 10.173.222.70.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:26.527928 10.173.222.70.3913 > 10.173.220.202.22: tcp 1460 (DF)
08:23:28.935608 10.173.222.70.3913 > 10.173.220.202.22: tcp 1460 (DF)

Traffic on lo:
08:23:24.508192 10.173.222.70 > 192.168.130.117: icmp: 10.173.220.202 unreachable - need to frag (mtu 1443) [tos 0xc0] 
08:23:24.722400 10.173.222.70 > 192.168.130.117: icmp: 10.173.220.202 unreachable - need to frag (mtu 1443) [tos 0xc0] 
08:23:25.324338 10.173.222.70 > 192.168.130.117: icmp: 10.173.220.202 unreachable - need to frag (mtu 1443) [tos 0xc0] 
08:23:26.528190 10.173.222.70 > 192.168.130.117: icmp: 10.173.220.202 unreachable - need to frag (mtu 1443) [tos 0xc0] 
08:23:28.935862 10.173.222.70 > 192.168.130.117: icmp: 10.173.220.202 unreachable - need to frag (mtu 1443) [tos 0xc0] 
08:23:33.751079 10.173.222.70 > 192.168.130.117: icmp: 10.173.220.202 unreachable - need to frag (mtu 1443) [tos 0xc0] 

Routing table:
[6/506]mh@torres:~$ ip route
192.168.131.0/29 dev eth0  proto kernel  scope link  src 192.168.131.1 
10.173.222.64/29 dev eth0  proto kernel  scope link  src 10.173.222.70 
10.173.222.64/29 dev ipsec0  proto kernel  scope link  src 10.173.222.70 
10.173.222.72/29 dev eth1  proto kernel  scope link  src 10.173.222.73 
10.173.222.72/29 dev ipsec1  proto kernel  scope link  src 10.173.222.73 
192.168.130.0/24 dev int0  proto kernel  scope link  src 192.168.130.1 
0.0.0.0/1 via 10.173.222.65 dev ipsec0 
128.0.0.0/1 via 10.173.222.65 dev ipsec0 
default via 10.173.222.65 dev eth0 

[1/501]mh@torres:~$ ip route list match 192.168.130.117
192.168.130.0/24 dev int0  proto kernel  scope link  src 192.168.130.1 
128.0.0.0/1 via 212.126.222.65 dev ipsec0 
default via 212.126.222.65 dev eth0 
[2/502]mh@torres:~$ 

Can anybody tell me why my box is sending out the ICMP 10.173.220.202
unreachable packets on lo instead of int0 where the route points to?
Thank you very much.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
