Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTFPVTN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTFPVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:18:39 -0400
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:63928 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id S264312AbTFPVQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:16:17 -0400
Message-ID: <3EEE36DA.5010401@candelatech.com>
Date: Mon, 16 Jun 2003 14:30:02 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Routing problem with source-based routing and routing packets back
 to sender machine.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a machine with eth3 IP 10.3.1.40 and eth4 with 10.3.2.40

I am using source-based routing, and have the eth3 & eth4 ports connected
to another machine which is acting as a router (the other machine has 10.3.1.1 and 10.3.2.1
IP addresses).

I run ping with the -I option to bind it to eth3, but instead of sending
the arp and/or ICMP request to the gateway, it instead arps for the IP on
eth4 of the sending machine.

The machines are running RedHat 9, and the problem exists in the
default 2.4.20-8 kernel.  I have not tried other kernels yet, so if you
think this is a RedHat only issue, I can try the stock kernel.


Here is the output from the machine that is attempting to send the traffic:

[root@ss40demo root]# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:30:1B:11:15:04
           inet addr:192.168.1.24  Bcast:192.168.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:9782 errors:0 dropped:0 overruns:0 frame:0
           TX packets:11866 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:100
           RX bytes:708223 (691.6 Kb)  TX bytes:17020024 (16.2 Mb)
           Interrupt:11 Base address:0x6000

eth1      Link encap:Ethernet  HWaddr 00:80:C8:CF:CB:BD
           inet addr:172.5.1.7  Bcast:172.5.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:400
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:11 Base address:0x4000

eth2      Link encap:Ethernet  HWaddr 00:80:C8:CF:CB:BE
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:400
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:10 Base address:0x6000

eth3      Link encap:Ethernet  HWaddr 00:80:C8:CF:CB:BF
           inet addr:10.3.1.40  Bcast:10.3.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:6 errors:2 dropped:0 overruns:0 frame:0
           TX packets:26 errors:3 dropped:0 overruns:0 carrier:3
           collisions:0 txqueuelen:400
           RX bytes:512 (512.0 b)  TX bytes:1316 (1.2 Kb)
           Interrupt:9 Base address:0x8000

eth4      Link encap:Ethernet  HWaddr 00:80:C8:CF:CB:C0
           inet addr:10.3.2.40  Bcast:10.3.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:2 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:400
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:5 Base address:0xa000

eth5      Link encap:Ethernet  HWaddr 00:07:E9:08:5B:30
           inet addr:10.2.1.2  Bcast:10.2.1.255  Mask:255.255.255.0
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:400
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:10 Base address:0xe400 Memory:ee100000-ee120000

eth6      Link encap:Ethernet  HWaddr 00:07:E9:08:5B:31
           inet addr:10.16.82.200  Bcast:10.16.255.255  Mask:255.255.0.0
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:400
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:11 Base address:0xe800 Memory:ee120000-ee140000

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:290 errors:0 dropped:0 overruns:0 frame:0
           TX packets:290 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:242716 (237.0 Kb)  TX bytes:242716 (237.0 Kb)



[root@ss40demo root]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.2.1.0        0.0.0.0         255.255.255.0   U     0      0        0 eth5
192.168.1.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
172.5.1.0       0.0.0.0         255.255.255.0   U     0      0        0 eth1
10.3.1.0        0.0.0.0         255.255.255.0   U     0      0        0 eth3
10.3.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth4
10.16.0.0       0.0.0.0         255.255.0.0     U     0      0        0 eth6
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
0.0.0.0         192.168.1.5     0.0.0.0         UG    0      0        0 eth0

[root@ss40demo root]# ip ru
0:      from all lookup local
32747:  from 10.3.2.40 lookup 4
32748:  from 10.3.1.40 lookup 3
32751:  from 10.16.82.200 lookup 6
32752:  from 10.2.1.2 lookup 5
32755:  from 172.5.1.7 lookup 1
32766:  from all lookup main
32767:  from all lookup 253


[root@ss40demo root]# ip route show table 3
10.3.1.0/24 via 10.3.1.40 dev eth3
default via 10.3.1.1 dev eth3
[root@ss40demo root]# ip route show table 4
10.3.2.0/24 via 10.3.2.40 dev eth4
default via 10.3.2.1 dev eth4

[root@ss40demo root]# ping -I eth3 10.3.1.1
PING 10.3.1.1 (10.3.1.1) from 10.3.1.40 eth3: 56(84) bytes of data.
64 bytes from 10.3.1.1: icmp_seq=1 ttl=64 time=0.275 ms
64 bytes from 10.3.1.1: icmp_seq=2 ttl=64 time=0.100 ms

#  The other interface on the router machine (same machine as I just pinged above)
[root@ss40demo root]# ping -I eth3 10.3.2.1
PING 10.3.2.1 (10.3.2.1) from 10.3.1.40 eth3: 56(84) bytes of data.
 From 10.3.1.40 icmp_seq=1 Destination Host Unreachable
 From 10.3.1.40 icmp_seq=2 Destination Host Unreachable


#  It is NOT using the default gateway for this traffic, but is instead
#  just trying to ARP.
[root@ss40demo root]# tcpdump -n -i eth3
tcpdump: listening on eth3
14:22:03.978549 arp who-has 10.3.2.1 tell 10.3.1.40
14:22:04.977987 arp who-has 10.3.2.1 tell 10.3.1.40
14:22:05.978064 arp who-has 10.3.2.1 tell 10.3.1.40
14:22:06.978513 arp who-has 10.3.2.1 tell 10.3.1.40
14:22:07.978228 arp who-has 10.3.2.1 tell 10.3.1.40


In addition, I enabled some debugging in the FIB code, and see this output:
(I tried to add newlines to help make it easier to read, but there is also
  some inter-mingled text from ping and the printk data.)  It appears to be
using the right routing table...

  ping -I eth3 10.3.1
Lookup: 192.168.1.255 <- 192.168.1.28 tb 255 r 1
Lookup: 192.168.1.28 <- 0.0.0.0 tb 255 r 1 tb 254 r 12.1

Lookup: 10.3.2.1 <- 0.0.0.0 tb 255 r 1 tb 254 r 1 tb 253 r 1 FAILURE
Lookup: 10.3.2.1 <- 10.3.1.40 tb 255 r 1 tb 3 r 1

PING 10.3.2.1 (10.3.2.1) from 10.3.1.40 eth3: 56(84) bytes of data.

Lookup: 10.3.1.40 <- 0.0.0.0 tb 255 r 1

 From 10.3.1.40 icmp_seq=1 Destination Host Unreachable


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


