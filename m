Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbRFFIrL>; Wed, 6 Jun 2001 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263494AbRFFIrB>; Wed, 6 Jun 2001 04:47:01 -0400
Received: from sniip-netline.inet.ntl.ru ([213.247.145.170]:3332 "EHLO
	gw.sniip.ru") by vger.kernel.org with ESMTP id <S263491AbRFFIqr> convert rfc822-to-8bit;
	Wed, 6 Jun 2001 04:46:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Info <arling@sniip.ru>
Date: Wed, 6 Jun 2001 12:49:48 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01060611353200.01030@sh.lc>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Testing DEC 21041 and 21142 chipsets (tulip): it looks like kernels after 2.4.4 does not work with 21041; and 21142 does not work in 10M net at all
X-Chameleon-Return-To: Info <arling@sniip.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 tests.

TEST 1.

Both IP and IPX does not work with 2.4.5 kernel on DEC 24041 
chipset card (CNet 935E).

I compile and try 2.4.5, 2.4.4-ac8-xfs-kdb and 2.4.5-ac8. 
In all cases system does not see Netware server (NW5.0 sp3) in 
ipx net and can't operate IP.

In 2.4.4 kernet all is o'k. It's work configuration for me.

I compile all kernels with the same parameters (copy .config 
from /usr/src/linux-2.4.4 to new /linux, then make oldconfig -> 
make dep -> make bzImage). All kernels are monolyte 
(firewall-style) - without module support; all modules I need 
included into kernel.

Ethernet card type selected when kernel config.

This effect appears in first time when I try 2.4.5-pre3. I take 
no attention to it that time.

It looks as one of changes after 2.4.4 causes unfunctionability 
with 21041 DEC chipset. 


TEST 2.

After trying 21041 card I decide to try 21142 card (CNet 
100TX). I didn't use this card, because when I try it in 
november-december 1999 (on kernels like 2.2.10-12) it 
demonstrate unstable work with IPX in my 10BASE-T network (CNet 
CN8816 TPC hub) - tulip uncorrectly recognized 10Base net, and 
switch card to 100Mbps by his own initiative, so connection 
loses.

Now 21242 did not work in 10Mbps net at all, in all kernels, 
both on IP and IPX.

TABLE OF RESULTS

10BASE-T ethernet network
+++++++++++++++++++++++++++++++++++++++++++
Kernel                 +   21041           +        21142    +
+++++++++++++++++++++++++++++++++++++++++++
early 2.2.x            +    OK              +    unstable     +
+++++++++++++++++++++++++++++++++++++++++++
2.4.4                    +    OK              +   unworkable  +
+++++++++++++++++++++++++++++++++++++++++++
2.4.4-ac8-xfs-kdb+  unworkable+   unworkable      +
+++++++++++++++++++++++++++++++++++++++++++
2.4.5-pre3           +  unworkable+   unworkable      +
+++++++++++++++++++++++++++++++++++++++++++
2.4.5                   +  unworkable+   unworkable      +
+++++++++++++++++++++++++++++++++++++++++++
2.4.5-ac8            +  unworkable+   unworkable      +
+++++++++++++++++++++++++++++++++++++++++++

Results of ifconfig, slist and 2 pings followed. It is the same 
system, exept of kernels.

System-specific addresses (my IP, IP of my proxy/firewall, 
hwaddr of my cards etc.) replaced by *.

Best regards to all.
George Afanassew

****************************************************************
****************************************************************
The 21041 chipset

***************************************************************
Failed test: kernel 2.4.5-ac8 (analogically for 2.4.5, 
2.4.4-ac8-xfs-kdb, 2.4.5-pre3):

[root@sh root]# ifconfig
eth0      Link encap:Ethernet  HWaddr **:**:**:**:**:**
          inet addr:**.*.*.***  Bcast:**.255.255.255  
Mask:255.0.0.0
          IPX/Ethernet 802.2 addr:00000001:00**********
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:30 dropped:0 overruns:0 carrier:60
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:10 Base address:0xe000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:39 errors:0 dropped:0 overruns:0 frame:0
          TX packets:39 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:2407 (2.3 Kb)  TX bytes:2407 (2.3 Kb)
 
[root@sh root]# slist
slist: Server not found (0x8847) in ncp_open
[root@sh root]# ping www.ru
ping: unknown host www.ru
[root@sh root]# ping **.*.*.**
PING **.*.*.** (**.*.*.**) from **.*.*.*** : 56(84) bytes of 
data.
>From **.*.*.***: Destination Host Unreachable
>From **.*.*.***: Destination Host Unreachable
>From **.*.*.***: Destination Host Unreachable
>From **.*.*.***: Destination Host Unreachable
>From **.*.*.***: Destination Host Unreachable
 
--- **.*.*.** ping statistics ---
7 packets transmitted, 0 packets received, +5 errors, 100% 
packet loss
[root@sh root]#
********************************************************
Sucessfull test: kernel 2.4.4

[root@sh root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:**:**:**:**:**
          inet addr:**.*.*.***  Bcast:**.255.255.255  
Mask:255.0.0.0
          IPX/Ethernet 802.2 addr:00000001:00**********
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:92 errors:0 dropped:0 overruns:0 frame:0
          TX packets:89 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:10305 (10.0 Kb)  TX bytes:7851 (7.6 Kb)
          Interrupt:10 Base address:0xe000

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:30 errors:0 dropped:0 overruns:0 frame:0
          TX packets:30 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1620 (1.5 Kb)  TX bytes:1620 (1.5 Kb)

[root@sh root]# slist

Known NetWare File Servers         Network   Node Address
------------------------------------------------
NETWARE50                             00000003  000000000001
[root@sh root]# ping www.ru
PING www.ru (194.87.0.50) from **.*.*.*** : 56(84) bytes of 
data.
64 bytes from www.ru (194.87.0.50): icmp_seq=0 ttl=54 
time=20.731 msec
64 bytes from www.ru (194.87.0.50): icmp_seq=1 ttl=54 
time=26.062 msec
64 bytes from www.ru (194.87.0.50): icmp_seq=2 ttl=54 
time=48.289 msec
64 bytes from www.ru (194.87.0.50): icmp_seq=3 ttl=54 
time=18.040 msec
64 bytes from www.ru (194.87.0.50): icmp_seq=4 ttl=54 
time=14.867 msec
64 bytes from www.ru (194.87.0.50): icmp_seq=5 ttl=54 
time=12.444 msec
64 bytes from www.ru (194.87.0.50): icmp_seq=6 ttl=54 
time=15.213 msec
 
--- www.ru ping statistics ---
7 packets transmitted, 7 packets received, 0% packet loss
round-trip min/avg/max/mdev = 12.444/22.235/48.289/11.419 ms
[root@sh root]# ping **.*.*.**
PING **.*.*.** (**.*.*.**) from **.*.*.*** : 56(84) bytes of 
data.
64 bytes from **.*.*.**: icmp_seq=0 ttl=255 time=428 usec
64 bytes from **.*.*.**: icmp_seq=1 ttl=255 time=394 usec
64 bytes from **.*.*.**: icmp_seq=2 ttl=255 time=394 usec
64 bytes from **.*.*.**: icmp_seq=3 ttl=255 time=392 usec
 
--- **.*.*.** ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.392/0.402/0.428/0.015 ms
[root@sh root]#

****************************************************
****************************************************
The 21142 chipset

****************************************************
Failed test: kernel 2.4.5-ac8 (analogically for 2.4.5, 
2.4.4-ac8-xfs-kdb, 2.4.5-pre3)

[root@sh root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:80:AD:B6:19:29
          inet addr:**.*.*.***  Bcast:10.255.255.255  
Mask:255.0.0.0
          IPX/Ethernet 802.2 addr:00000001:0080ADB61929
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:1 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:10 Base address:0xe000
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:33 errors:0 dropped:0 overruns:0 frame:0
          TX packets:33 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1878 (1.8 Kb)  TX bytes:1878 (1.8 Kb)
 
[root@sh root]# slist
slist: Server not found (0x8847) in ncp_open
[root@sh root]# ping www.ru
ping: unknown host www.ru
[root@sh root]# ping **.*.*.**
PING **.*.*.** (**.*.*.**) from **.*.*.*** : 56(84) bytes of 
data.
>From **.*.*.***: Destination Host Unreachable
>From **.*.*.***: Destination Host Unreachable
 
--- **.*.*.** ping statistics ---
5 packets transmitted, 0 packets received, +2 errors, 100% 
packet loss
[root@sh root]#

*****************************************************
Failed test: kernel 2.4.4

[root@sh root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:80:AD:B6:19:29
          inet addr:**.*.*.***  Bcast:10.255.255.255  
Mask:255.0.0.0
          IPX/Ethernet 802.2 addr:00000001:0080ADB61929
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:10 Base address:0xe000
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:33 errors:0 dropped:0 overruns:0 frame:0
          TX packets:33 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1878 (1.8 Kb)  TX bytes:1878 (1.8 Kb)
 
[root@sh root]# slist
slist: Server not found (0x8847) in ncp_open
[root@sh root]# ping www.ru
ping: unknown host www.ru
[root@sh root]# ping **.*.*.**
PING **.*.*.** (**.*.*.**) from **.*.*.*** : 56(84) bytes of 
data.
>From **.*.*.***: Destination Host Unreachable
>From **.*.*.***: Destination Host Unreachable
 
--- **.*.*.** ping statistics ---
4 packets transmitted, 0 packets received, +2 errors, 100% 
packet loss
[root@sh root]#
