Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUHHGKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUHHGKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 02:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUHHGKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 02:10:48 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:58824 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S265195AbUHHGKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 02:10:17 -0400
Date: Sun, 08 Aug 2004 02:10:11 -0400
From: consolebandit@netscape.net (Maurice)
To: vda@port.imtp.ilyichevsk.odessa.ua (Denis Vlasenko),
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.xSMP and IPv4 issues (ifconfig(s))
MIME-Version: 1.0
Message-ID: <00D27771.68563E3E.345005B1@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 216.227.167.63
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

>> I re-booted to see what, if anything, would fail on start-up.
>>
>> I did have a failure, the FA311 NIC card could no longer get an address
>> from the DHCP server???
>> Seems that the NIC now only "runs" IPv6, and the info I've gathered from
>>  the Net isn't helping me correct this -- I must be searching the wrong
>> phrase(s).
>>
>> Has anyone else followed this upgrade path and had the same problem?
>> Has anyone else moved to the 2.6 kernel and had IPv4 problems?
>>
>> I've poked around and added line to certain system files and even gave
>> the card a static IPv4 number -- but nothing has corrected this problem.
>
>ifconfig output? tcpdump of ping attempts? dmesg?
>--
>vda
>
>


Ifconfig(s):

Seems that the non-SMP kernel works fine.
Here is the ifconfig;
    [root@localhost root]# uname -r
    2.6.6-1.435.2.3
    [root@localhost root]# ifconfig
    eth0      Link encap:Ethernet  HWaddr 00:02:E3:1D:3F:32
              inet addr:192.168.0.102  Bcast:192.168.0.255  Mask:255.255.255.0
              UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
              RX packets:33 errors:0 dropped:0 overruns:0 frame:0
              TX packets:7 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:5810 (5.6 Kb)  TX bytes:1036 (1.0 Kb)
              Interrupt:10 Base address:0x2000
                                                                               
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:143 errors:0 dropped:0 overruns:0 frame:0
              TX packets:143 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:9270 (9.0 Kb)  TX bytes:9270 (9.0 Kb)
                                                                               
    [root@localhost root]#




But the SMP kernel has issues;

    [root@localhost root]# uname -r
    2.6.6-1.435.2.3smp
    [root@localhost root]# ifconfig
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:128 errors:0 dropped:0 overruns:0 frame:0
              TX packets:128 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:8670 (8.4 Kb)  TX bytes:8670 (8.4 Kb)
        
                                                                      
    [root@localhost root]# ifconfig -a
    eth0      Link encap:Ethernet  HWaddr 00:02:E3:1D:3F:32
              BROADCAST MULTICAST  MTU:1500  Metric:1
              RX packets:0 errors:0 dropped:0 overruns:0 frame:0
              TX packets:8 errors:0 dropped:3 overruns:0 carrier:0
              collisions:0 txqueuelen:1000
              RX bytes:0 (0.0 b)  TX bytes:2736 (2.6 Kb)
              Interrupt:10 Base address:0x2000
                                                                               
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:128 errors:0 dropped:0 overruns:0 frame:0
              TX packets:128 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0
              RX bytes:8670 (8.4 Kb)  TX bytes:8670 (8.4 Kb)
 
    [root@localhost root]#



Then I did the static IP number thing, but had/have a communication problem;

[root@localhost root]# ifconfig eth0 down
[root@localhost root]# ifconfig eth0 192.168.0.49 netmask 255.255.255.0 broadcast 192.168.0.255
[root@localhost root]# ifconfig eth0 up
[root@localhost root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:02:E3:1D:3F:32
          inet addr:192.168.0.49  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:40 errors:0 dropped:32 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:4080 (3.9 Kb)
          Interrupt:10 Base address:0x2000
                                                                                                 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:210 errors:0 dropped:0 overruns:0 frame:0
          TX packets:210 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:18787 (18.3 Kb)  TX bytes:18787 (18.3 Kb)
                                                                                                 
[root@localhost root]# ping 192.168.0.103
PING 192.168.0.103 (192.168.0.103) 56(84) bytes of data.
>From 192.168.0.49 icmp_seq=0 Destination Host Unreachable
>From 192.168.0.49 icmp_seq=1 Destination Host Unreachable
>From 192.168.0.49 icmp_seq=2 Destination Host Unreachable
>From 192.168.0.49 icmp_seq=3 Destination Host Unreachable
>From 192.168.0.49 icmp_seq=4 Destination Host Unreachable
>From 192.168.0.49 icmp_seq=5 Destination Host Unreachable
                                                                                                 
--- 192.168.0.103 ping statistics ---
7 packets transmitted, 0 received, +6 errors, 100% packet loss, time 5999ms
, pipe 4


 
--------
-Maurice

"Linux -- it not just for breakfast anymore..."
-Moe





__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
