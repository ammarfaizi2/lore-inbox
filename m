Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRCMASU>; Mon, 12 Mar 2001 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130699AbRCMASK>; Mon, 12 Mar 2001 19:18:10 -0500
Received: from smtp.networkusa.net ([216.162.106.18]:59661 "EHLO
	smtp.networkusa.net") by vger.kernel.org with ESMTP
	id <S130673AbRCMASD>; Mon, 12 Mar 2001 19:18:03 -0500
Message-ID: <3AAD67D3.A48285BE@networkusa.net>
Date: Mon, 12 Mar 2001 18:20:35 -0600
From: Ian Zink <zforce@networkusa.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Broken Tulip Driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, I have an SMC Etherpower10/100 in my system that refuses to
work under linux 2.4.2, it worked fine in 2.4.0 and the 2.2.x series. I
know the card is working fine since when I dual-boot into windows it
links fine. Strangely, once the linux drivers load it will not even link
to my hub at all. The light on the back of the card blinks green.
ifconfig shows lots of carrier errors. I will attach below all the
relevant information I can think of. Any help will be greatly
appreciated. Please CC me on any responses, as I'm not on the kernel
mailing list.

Thanks, Ian Zink


zforce:/home/zforce# gcc --version
2.95.3

(Note: I tried the 2.4.3-pre3 patch to see if the problem was already
fixed)

zforce:/home/zforce# uname -a
Linux zforce 2.4.3-pre3 #1 Sun Mar 11 20:13:44 CST 2001 i686 unknown

Interesting parts of /proc/pci
(This card works perfectly fine)

  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
(rev 0).
      IRQ 5.
      I/O at 0xd000 [0xd01f].
  Bus  0, device  10, function  0:
...

  Bus  0, device  11, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 32).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=40.
      I/O at 0xb000 [0xb07f].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe080007f].


zforce:/home/zforce# ifconfig -a
(Take note of all of the carrier errors)
eth0      Link encap:Ethernet  HWaddr 00:00:C0:41:99:E9
          inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:199 dropped:0 overruns:0 carrier:199
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:10 Base address:0xb000

(IP address edited out for security)
eth1      Link encap:Ethernet  HWaddr 00:C0:F0:45:BD:04
          inet addr:xxx.xxx.xxx.xxx  Bcast:216.162.97.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:7736 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8543 errors:0 dropped:0 overruns:0 carrier:0
          collisions:1 txqueuelen:100
          RX bytes:5565587 (5.3 Mb)  TX bytes:978504 (955.5 Kb)
          Interrupt:5 Base address:0xd000

zforce:/home/zforce# less /var/log/dmesg
....
Linux Tulip driver version 0.9.14 (February 20, 2001)
PCI: Found IRQ 10 for device 00:0b.0
eth0: Digital DS21140 Tulip rev 32 at 0xb000, 00:00:C0:41:99:E9, IRQ 10.

eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1)
block.
eth0:  MII transceiver #3 config 3100 status 7809 advertising 01e1.
eth0:  Advertising 0001 on PHY 3, previously advertising 01e1.
eth0:  Advertising 0001 (to advertise is 0001).
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 5 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
eth1: RealTek RTL-8029 found at 0xd000, IRQ 5, 00:C0:F0:45:BD:04.
...


Please remember to CC! Thanks again...


