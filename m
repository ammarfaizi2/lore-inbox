Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRI3KrS>; Sun, 30 Sep 2001 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRI3KrJ>; Sun, 30 Sep 2001 06:47:09 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:33700 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S273255AbRI3Kqu>; Sun, 30 Sep 2001 06:46:50 -0400
Date: Sun, 30 Sep 2001 12:44:09 +0200 (MET DST)
From: Oliver Seemann <oseemann@cs.tu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: rtl8139 nic dies with load (2.4.10, kt266)
Message-ID: <Pine.SOL.4.10.10109301241210.11643-100000@gorisa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my box got 2 rtl8139 nics (longshine iirc), eth0 connected to localnet
and eth1 for adsl (pppoe).
since i upgraded the hardware to via kt266 + athlon c 1.4 and kernel
to 2.4.9 all network activity dies when i copy big files over
localnet. with old hx chipset, cyrix 200mhz cpu and redhat 2.4.3
kernel i didn't have these problems.
no matter if ftp or smb, when transferring files over eth0 to a win2k
pc (3com nic), after some seconds or mbytes transfer, suddenly all
network activity on eth0 dies. the adsl connection over eth1 remains
alive.
after /etc/rc.d/init.d/network restart  all is fine again (rebooting
the win2k pc doesn't help ;). and it remains so until i make significant
traffic. even while watching an divx files over a samba share, the nic
died after 45 minutes of continuous watching.

meanwhile i updated to 2.4.10 but it does not fix it. also 2.4.9-ac16
shows the same behaviour.
i found no messages in /var/log/* or on console telling errors.
below some hw-specs (rtl8139-diag output at the end).
i'd be glad if i could help with more information or trying patches etc.

good luck,
Oliver Seemann

ps: i'm not subscribed, please reply directly. thx
----

redhat 7.1 system on msi k7t266 pro-r with 512mb pc266 ram.
kernel 2.4.10 with iptables-1.2.3
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)

from dmesg:
8139too Fast Ethernet driver 0.9.18a
eth0: RealTek RTL8139 Fast Ethernet at 0xe086bf00, 00:e0:7d:c0:01:99, IRQ
12
eth0:  Identified 8139 chip type 'RTL-8139B'
eth1: RealTek RTL8139 Fast Ethernet at 0xe086de00, 00:e0:7d:9c:7d:f1, IRQ
5
eth1:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability
45e1.
task `ifconfig' exit_signal 17 in reparent_to_init
eth1: Setting half-duplex based on auto-negotiated partner ability 0000.
task `ifconfig' exit_signal 17 in reparent_to_init

from /proc/cpuinfo:
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1399.803

from /proc/pci:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8367 [KT266] (rev 0).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    VGA compatible controller: ATI Technologies Inc 264VT [Mach64 VT] (rev
64).
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdfffffff].
      I/O at 0xd800 [0xd8ff].
  Bus  0, device   8, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
16).
      IRQ 12.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xdefbff00 [0xdefbffff].
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (#2)
(rev 16).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xbc00 [0xbcff].
      Non-prefetchable 32 bit memory at 0xdefbfe00 [0xdefbfeff].
  Bus  0, device  12, function  0:
    RAID bus controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 11.
      Master Capable.  Latency=64.  
      I/O at 0xd400 [0xd407].
      I/O at 0xd000 [0xd003].
      I/O at 0xcc00 [0xcc07].
      I/O at 0xc800 [0xc803].
      I/O at 0xc400 [0xc43f].
      Non-prefetchable 32 bit memory at 0xdefc0000 [0xdefdffff].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xff00 [0xff0f].
  Bus  0, device  17, function  4:
    USB Controller: VIA Technologies, Inc. UHCI USB (#3) (rev 24).
      IRQ 12.
      Master Capable.  Latency=64.  
      I/O at 0xb400 [0xb41f].
  Bus  0, device  17, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 24).
      IRQ 12.
      Master Capable.  Latency=64.  
      I/O at 0xb000 [0xb01f].
  Bus  0, device  17, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 24).
      IRQ 12.
      Master Capable.  Latency=64.  
      I/O at 0xac00 [0xac1f].
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 16).
      IRQ 10.
      I/O at 0xb800 [0xb8ff].


rtl8139-diag -mmaaavvveef output, with eth0 ALIVE:

rtl8139-diag.c:v2.01 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a RealTek RTL8139 adapter at 0xc000.
RealTek chip registers at 0xc000
 0x000: c07de000 00009901 80000000 00000000 0008a04a 0008a04a 0008a04a
0008a05a
 0x020: 1c44e000 1c44e600 1c44ec00 1c44f200 1f300000 0d0a0000 96b096a0
0000c07f
 0x040: 78000600 0e00f78e 53539ad8 00000000 004d1000 00000000 0080c180
00100000
 0x060: 1100f00f 05e1782d 000145e1 00000000 00000004 000517c0 58fab388
a438d843.
  No interrupt sources are pending.
 The chip configuration is 0x10 0x4d, MII full-duplex mode.
EEPROM size test returned 6, 0x204a4 / 0x2.
Parsing the EEPROM of a RealTek chip:
  PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 0x10ec.
  PCI timer settings -- minimum grant 32, maximum latency 64.
  General purpose pins --  direction 0xe1  value 0x10.
  Station Address 00:E0:7D:C0:01:99.
  Configuration register 0/1 -- 0x4d / 0xc2.
 EEPROM active region checksum is 0a34.
EEPROM contents:
  8129 10ec 8139 10ec 8139 4020 e110 e000
  c07d 9901 4d10 f7c2 8001 b388 58fa 0708
  d843 a438 d843 a438 d843 a438 d843 a438
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0xca6a.
Index #2: Found a RealTek RTL8139 adapter at 0xbc00.
RealTek chip registers at 0xbc00
 0x000: 9c7de000 0000f17d 80000000 00000000 9008a5c2 9008a5c2 9008a5c2
9008a5c2
 0x020: 1bc8a000 1bc8a600 1bc8ac00 1bc8b200 02dd0000 0d0a0000 fcd8fcc8
0000c07f
 0x040: 74000600 0e00f78e 53563b8a 00000000 004d1000 00000000 0088c118
00100000
 0x060: 1000f00f 01e1782d 00000000 00000000 00000005 000f77c0 b0f243b9
7a36d743.
  No interrupt sources are pending.
 The chip configuration is 0x10 0x4d, MII full-duplex mode.
EEPROM size test returned 6, 0x204a4 / 0x2.
Parsing the EEPROM of a RealTek chip:
  PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 0x10ec.
  PCI timer settings -- minimum grant 32, maximum latency 64.
  General purpose pins --  direction 0xe1  value 0x12.
  Station Address 00:E0:7D:9C:7D:F1.
  Configuration register 0/1 -- 0x4d / 0xc2.
 EEPROM active region checksum is 0ae6.
EEPROM contents:
  8129 10ec 8139 10ec 8139 4020 e112 e000
  9c7d f17d 4d10 f7c2 8801 43b9 b0f2 031a
  df43 8a36 df43 8a36 43b9 b0f2 1111 1111
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0xe2f6.


rtl8139-diag -mmaaavvveef output, with eth0 DEAD:

rtl8139-diag.c:v2.01 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a RealTek RTL8139 adapter at 0xc000.
RealTek chip registers at 0xc000
 0x000: c07de000 00009901 80000000 00000000 0008a5ea 0008a5ea 0008a5ea
0008a5ea
 0x020: 1c44e000 1c44e600 1c44ec00 1c44f200 1f300000 0d000000 0000fff0
0000c07f
 0x040: 78000600 00000000 fc7278d1 00000000 004d10c6 00000000 0080c180
00100000
 0x060: 1100f00f 05e1782d 000145e1 00000000 00000004 000417c8 58fab388
a438d843.
  No interrupt sources are pending.
 The chip configuration is 0x10 0x4d, MII full-duplex mode.
EEPROM size test returned 6, 0x204a4 / 0x2.
Parsing the EEPROM of a RealTek chip:
  PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 0x10ec.
  PCI timer settings -- minimum grant 32, maximum latency 64.
  General purpose pins --  direction 0xe1  value 0x10.
  Station Address 00:E0:7D:C0:01:99.
  Configuration register 0/1 -- 0x4d / 0xc2.
 EEPROM active region checksum is 0a34.
EEPROM contents:
  8129 10ec 8139 10ec 8139 4020 e110 e000
  c07d 9901 4d10 f7c2 8001 b388 58fa 0708
  d843 a438 d843 a438 d843 a438 d843 a438
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0xca6a.
Index #2: Found a RealTek RTL8139 adapter at 0xbc00.
RealTek chip registers at 0xbc00
 0x000: 9c7de000 0000f17d 80000000 00000000 9008a5c2 9008a5c2 9008a5c2
9008a5c2
 0x020: 1bc8a000 1bc8a600 1bc8ac00 1bc8b200 02dd0000 0d0a0000 fdf8fde8
0000c07f
 0x040: 74000600 0e00f78e fc751d5c 00000000 004d10c6 00000000 0088c118
00100000
 0x060: 1000f00f 01e1782d 00000000 00000000 00000005 000f77c0 b0f243b9
7a36d743.
  No interrupt sources are pending.
 The chip configuration is 0x10 0x4d, MII full-duplex mode.
EEPROM size test returned 6, 0x204a4 / 0x2.
Parsing the EEPROM of a RealTek chip:
  PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 0x10ec.
  PCI timer settings -- minimum grant 32, maximum latency 64.
  General purpose pins --  direction 0xe1  value 0x12.
  Station Address 00:E0:7D:9C:7D:F1.
  Configuration register 0/1 -- 0x4d / 0xc2.
 EEPROM active region checksum is 0ae6.
EEPROM contents:
  8129 10ec 8139 10ec 8139 4020 e112 e000
  9c7d f17d 4d10 f7c2 8801 43b9 b0f2 031a
  df43 8a36 df43 8a36 43b9 b0f2 1111 1111
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0xe2f6.


EOF

