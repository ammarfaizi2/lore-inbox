Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318015AbSHLNt3>; Mon, 12 Aug 2002 09:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSHLNt3>; Mon, 12 Aug 2002 09:49:29 -0400
Received: from feline.chl.chalmers.se ([129.16.214.88]:61452 "EHLO
	feline.chl.chalmers.se") by vger.kernel.org with ESMTP
	id <S318015AbSHLNt2>; Mon, 12 Aug 2002 09:49:28 -0400
Date: Mon, 12 Aug 2002 15:53:11 +0200 (CEST)
From: Fredrik Ohrn <ohrn@chl.chalmers.se>
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: sungem 0.97 driver doesn't work with "Sun GigabitEthernet/P 2.0"
 card.
Message-ID: <Pine.LNX.4.44.0208121524060.17083-100000@feline.chl.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I have salvaged a Sun GigabitEthernet/P 2.0 card from a retired Sun server 
and am trying to put it to use.


Inserting the driver gives the following in dmesg:

sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
eth2: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:00:00:00:00:00
gem: SW reset is ghetto.

Notice the missing MAC address.


Configuring the card gives the following:

[root@olivia ~]# ifconfig eth2 129.xxx.xxx.17 netmask 255.255.255.128 broadcast 129.xxx.xxx.127
[root@olivia ~]# ifconfig eth2
eth2      Link encap:Ethernet  HWaddr 00:00:00:00:00:00  
          inet addr:129.xxx.xxx.17  Bcast:129.xxx.xxx.127  Mask:255.255.255.128
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:4294967170
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:4294967254
          collisions:4294967212 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:22 Base address:0x7000 

Notice the bogus frame, carrier and collision error counts.


When trying to communicate with the box using 129.xxx.xxx.17 it will 
advertize the MAC address of eth0 on ARP queries. This means that to other 
machines 129.xxx.xxx.17 seems to work just fine but in reality the 
traffic passes over eth0, not the sungem card. Similar things seems to 
happen when trying to do outward connections.


Gritty system details:

Plain 2.4.19 kernel.
ASUS TR-DLS mobo with ServerWorks LE chipset.
The card is 64-bit and sits in a 64-bit PCI slot.

[root@olivia ~]# lspci -v -x -s 01:02
01:02.0 Ethernet controller: Sun Microsystems Computer Corp. GEM (rev 01)
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 22
        Memory at f5800000 (32-bit, non-prefetchable) [size=2M]
        Expansion ROM at 40000000 [size=1M]
00: 8e 10 ad 2b 16 00 a0 04 01 00 00 02 08 20 00 00
10: 00 00 80 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00
30: 01 00 00 40 00 00 00 00 00 00 00 00 09 01 40 40



What can I do to help debug and fix this?


Regards,
Fredrik

-- 
   "It is easy to be blinded to the essential uselessness of computers by
   the sense of accomplishment you get from getting them to work at all."
                                                   - Douglas Adams

Fredrik Öhrn                               Chalmers University of Technology
ohrn@chl.chalmers.se                                                  Sweden

