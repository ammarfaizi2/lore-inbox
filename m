Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264279AbRFOJLV>; Fri, 15 Jun 2001 05:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264294AbRFOJLL>; Fri, 15 Jun 2001 05:11:11 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:28044 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S264279AbRFOJK5>; Fri, 15 Jun 2001 05:10:57 -0400
Message-ID: <3B29D11E.FA3B816E@bigfoot.com>
Date: Fri, 15 Jun 2001 02:10:54 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p2-ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: chuckw@altaserv.net
Subject: Re: [BUG] 2.2.19 -> 80% Packet Loss
In-Reply-To: <Pine.LNX.4.33.0106141325210.20189-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chuckw@altaserv.net wrote:
> ...
> 2. A "ping -f -s 64589" to a machine running kernel 2.2.19 results in 0%
> packet loss. By incrementing the packetsize by one "ping -f -s 64590"  or
> higher, I consistently see 80% packet loss. ifconfig on the receiving
> machine shows no anomolies.
> ...
> 4. Linux version 2.2.19-7.0.1 (root@porky.devel.redhat.com) (gcc version
> egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Apr 10 00:55:03
> EDT 2001

No problems here.

rgds,
tim.

[note: -ai = athlon kernel + ide patch]

[tim@abit cron.daily]# cat /proc/version
Linux version 2.2.20p2-ai (root@abit) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #12 Fri May 25 16:31:02 PDT 2001

[tim@abit cron.daily]# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:A0:CC:57:89:93  
          inet addr:192.168.1.10  Bcast:192.168.1.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10204 errors:0 dropped:0 overruns:0 frame:0
          TX packets:15280 errors:1 dropped:0 overruns:0 carrier:1
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0xec00 

[tim@abit cron.daily]# ping -f -s 64590 dell
PING dell.yoyodyne.org (192.168.1.11) from 192.168.1.10 : 64590(64618)
bytes of data.
Warning: no SO_RCVTIMEO support, falling back to poll
..
--- dell.yoyodyne.org ping statistics ---
639 packets transmitted, 637 packets received, 0% packet loss
round-trip min/avg/max/mdev = 15.852/16.406/38.972/2.068 ms
[tim@abit cron.daily]# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:A0:CC:57:89:93  
          inet addr:192.168.1.10  Bcast:192.168.1.255 
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:38312 errors:0 dropped:0 overruns:0 frame:0
          TX packets:43421 errors:3 dropped:0 overruns:2 carrier:1
          collisions:0 txqueuelen:100 
          Interrupt:11 Base address:0xec00 

[tim@abit cron.daily]# ping dell -c 3
PING dell.yoyodyne.org (192.168.1.11) from 192.168.1.10 : 56(84) bytes
of data.
64 bytes from dell.yoyodyne.org (192.168.1.11): icmp_seq=0 ttl=255
time=334 usec
64 bytes from dell.yoyodyne.org (192.168.1.11): icmp_seq=1 ttl=255
time=294 usec
64 bytes from dell.yoyodyne.org (192.168.1.11): icmp_seq=2 ttl=255
time=296 usec

--- dell.yoyodyne.org ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.294/0.308/0.334/0.018 ms


[tim@abit cron.daily]# ifconfig lo
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:724500 errors:0 dropped:0 overruns:0 frame:0
          TX packets:724500 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

[tim@abit cron.daily]# ping -f -s 64590 localhost
PING localhost (127.0.0.1) from 127.0.0.1 : 64590(64618) bytes of data.
Warning: no SO_RCVTIMEO support, falling back to poll
.
--- localhost ping statistics ---
7754 packets transmitted, 7754 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.960/1.011/25.556/0.623 ms
[tim@abit cron.daily]# ifconfig lo
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:988136 errors:0 dropped:0 overruns:0 frame:0
          TX packets:988136 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 

--
