Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbTGJP3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269361AbTGJP3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:29:03 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:35201 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S269358AbTGJP2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:28:54 -0400
Date: Fri, 11 Jul 2003 01:43:03 +1000
From: CaT <cat@zip.com.au>
To: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, pekkas@netcore.fi
Subject: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
Message-ID: <20030710154302.GE1722@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.21-pre2 I can get a nice tunnel going over my ppp connection
and as such get ipv6 connectivity. I think went to 2.4.21 and then to
2.4.22-pre4 and bringing up the tunnel fails as follows:

[01:37:04] root@nessie:/usr/src/linux>> ifup --verbose sit1
Configuring interface sit1=sit1 (inet6)
run-parts /etc/network/if-pre-up.d
ip tunnel add sit1 mode sit remote 138.25.6.14
ip link set sit1 up
ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
 ip route add ::/0 via 3ffe:8001:000c:ffff::36 
RTNETLINK answers: Invalid argument

Basically nothing gets through. Any attempts to ping/connect past my
gw fail and pinging the external gw results in packets coming back from
my gw (though with the eth0 IP addy) as if I were pinging it instead.

ie:

15 [01:41:34] hogarth@theirongiant:/home/hogarth>> ping6 3ffe:8001:000c:ffff::36PING 3ffe:8001:000c:ffff::36(3ffe:8001:c:ffff::36) from 3ffe:8002:1005::2 : 56 data bytes
64 bytes from 3ffe:8002:1005::1: icmp_seq=1 ttl=64 time=0.159 ms
64 bytes from 3ffe:8002:1005::1: icmp_seq=2 ttl=64 time=0.118 ms
64 bytes from 3ffe:8002:1005::1: icmp_seq=3 ttl=64 time=0.109 ms
64 bytes from 3ffe:8002:1005::1: icmp_seq=4 ttl=64 time=0.116 ms
64 bytes from 3ffe:8002:1005::1: icmp_seq=5 ttl=64 time=0.114 ms

--- 3ffe:8001:000c:ffff::36 ping statistics ---
5 packets transmitted, 5 received, 0% loss, time 3999ms
rtt min/avg/max/mdev = 0.109/0.123/0.159/0.019 ms

Mind you, the same exact config works beautifully under 2.4.21-pre2.

If there are any patches you want me to try or help in any other way
(as far as debugging goes anyways :) then holler. :)

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
