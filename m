Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268456AbTANAo5>; Mon, 13 Jan 2003 19:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268457AbTANAou>; Mon, 13 Jan 2003 19:44:50 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:15002
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S268456AbTANAni>; Mon, 13 Jan 2003 19:43:38 -0500
Message-ID: <3E235F4B.8010808@tupshin.com>
Date: Mon, 13 Jan 2003 16:52:27 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5 ethernet/irq problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm engaged in an ongoing saga, trying to get at least one of my five 
machines working properly with kernel 2.5. I'll save additional problem 
reports until I can make them concrete.

Today's episode involves a KT400 chipset that works fine with recent 2.4 
kernels(running 2.4.21-pre3-ac4 right now without any problems).

With 2.5.56, the ethernet cards don't work, while the exact same 
hardware/bios options work with with 2.4.

Specifically, I have tried with the onboard realtek (8139too driver) as 
well as a 3c59x pci card. Either separately or together, these cards 
don't work due to claimed irq problems. Interestingly, /proc/pci reports 
wildly different irq settings with 2.5 vs. 2.4 (output of both below). 
2.4 maps the pci devices to irqs 16-19, while 2.5 reports them the same 
way that the bios post screen reports them (5,10,11, ans 12). These 
results are obtained by letting the bios automatically choose the pci 
irqs. Different, but equally non-functional results have been obtained 
by manually tweaking these bios settings.

Below, you'll find /proc/pci from both kernels as well as the syslog 
output that reports irq problems on 2.5. The syslog error comes from the 
3c59x card.

-Tupshin

------------------------2.5.56 /proc/pci-------------------------
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, In VT8377 [KT400 AGP] H (rev 0).
       Master Capable.  Latency=8.
       Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, In VT8235 PCI Bridge (rev 0).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device  10, function  0:
     Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E 
Audio (rev 0).
       IRQ 11.
       Master Capable.  Latency=32.  Min Gnt=5.Max Lat=25.
       Non-prefetchable 32 bit memory at 0xe3000000 [0xe3007fff].
       I/O at 0xd000 [0xd03f].
       I/O at 0xd400 [0xd403].
   Bus  0, device  11, function  0:
     Multimedia video controller: Brooktree Corporatio Bt878 Video 
Capture (rev 17).
       IRQ 5.
       Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
       Prefetchable 32 bit memory at 0xe300a000 [0xe300afff].
   Bus  0, device  11, function  1:
     Multimedia controller: Brooktree Corporatio Bt878 Audio Capture 
(rev 17).
       IRQ 5.
       Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
       Prefetchable 32 bit memory at 0xe3008000 [0xe3008fff].
   Bus  0, device  13, function  0:
     Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Torn (rev 120).
       IRQ 10.
       Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
       I/O at 0xd800 [0xd87f].
       Non-prefetchable 32 bit memory at 0xe3009000 [0xe300907f].
   Bus  0, device  16, function  0:
     USB Controller: VIA Technologies, In USB (rev 128).
       IRQ 12.
       Master Capable.  Latency=32.
       I/O at 0xdc00 [0xdc1f].
   Bus  0, device  16, function  1:
     USB Controller: VIA Technologies, In USB (#2) (rev 128).
       IRQ 10.
       Master Capable.  Latency=32.
       I/O at 0xe000 [0xe01f].
   Bus  0, device  16, function  2:
     USB Controller: VIA Technologies, In USB (#3) (rev 128).
       IRQ 11.
       Master Capable.  Latency=32.
       I/O at 0xe400 [0xe41f].
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, In VT8235 ISA Bridge (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, In VT82C586/B/686A/B PI (rev 6).
       IRQ 12.
       Master Capable.  Latency=32.
       I/O at 0xe800 [0xe80f].
   Bus  0, device  19, function  0:
     Ethernet controller: Realtek Semiconducto RTL-8139/8139C/8139C (rev 
16).
       IRQ 11.
       Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
       I/O at 0xec00 [0xecff].
       Non-prefetchable 32 bit memory at 0xe300c000 [0xe300c0ff].
   Bus  1, device   0, function  0:
     VGA compatible controller: ATI Technologies Inc Radeon R200 QL 
[Rade (rev 0).
       IRQ 12.
       Master Capable.  Latency=32.  Min Gnt=8.
       Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
       I/O at 0xc000 [0xc0ff].
       Non-prefetchable 32 bit memory at 0xe1000000 [0xe100ffff].


------------------------2.4.21-pre3-ac4 /proc/pci---------------------

PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge 
(rev 0).
       Master Capable.  Latency=8.
       Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].
   Bus  0, device   1, function  0:
     PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (rev 0).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device  10, function  0:
     Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E 
Audio Controller] (rev 0).
       IRQ 18.
       Master Capable.  Latency=32.  Min Gnt=5.Max Lat=25.
       Non-prefetchable 32 bit memory at 0xe3000000 [0xe3007fff].
       I/O at 0xd000 [0xd03f].
       I/O at 0xd400 [0xd403].
   Bus  0, device  11, function  0:
     Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 17).
       IRQ 19.
       Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
       Prefetchable 32 bit memory at 0xe300a000 [0xe300afff].
   Bus  0, device  11, function  1:
     Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 17).
       IRQ 19.
       Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
       Prefetchable 32 bit memory at 0xe3008000 [0xe3008fff].
   Bus  0, device  13, function  0:
     Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 
120).
       IRQ 17.
       Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
       I/O at 0xd800 [0xd87f].
       Non-prefetchable 32 bit memory at 0xe3009000 [0xe300907f].
   Bus  0, device  16, function  0:
     USB Controller: VIA Technologies, Inc. USB (rev 128).
       IRQ 21.
       Master Capable.  Latency=32.
       I/O at 0xdc00 [0xdc1f].
   Bus  0, device  16, function  1:
     USB Controller: VIA Technologies, Inc. USB (#2) (rev 128).
       IRQ 21.
       Master Capable.  Latency=32.
       I/O at 0xe000 [0xe01f].
   Bus  0, device  16, function  2:
     USB Controller: VIA Technologies, Inc. USB (#3) (rev 128).
       IRQ 21.
       Master Capable.  Latency=32.
       I/O at 0xe400 [0xe41f].
   Bus  0, device  17, function  0:
     ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge (rev 0).
   Bus  0, device  17, function  1:
     IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 6).
       Master Capable.  Latency=32.
       I/O at 0xe800 [0xe80f].
   Bus  0, device  19, function  0:
     Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 16).
       IRQ 18.
       Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
       I/O at 0xec00 [0xecff].
       Non-prefetchable 32 bit memory at 0xe300c000 [0xe300c0ff].
   Bus  1, device   0, function  0:
     VGA compatible controller: ATI Technologies Inc Radeon R200 QL 
[Radeon 8500 LE] (rev 0).
       IRQ 16.
       Master Capable.  Latency=32.  Min Gnt=8.
       Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
       I/O at 0xc000 [0xc0ff].
       Non-prefetchable 32 bit memory at 0xe1000000 [0xe100ffff].

------------------------2.5.56 syslog error---------------------
Jan 13 16:34:31 fussbudget kernel: NETDEV WATCHDOG: eth0: transmit timed out
Jan 13 16:34:31 fussbudget kernel: eth0: transmit timed out, tx_status 
00 status e601.
Jan 13 16:34:31 fussbudget kernel:   diagnostics: net 0cc6 media 8880 
dma 0000003a fifo 0000
Jan 13 16:34:31 fussbudget kernel: eth0: Interrupt posted but not 
delivered -- IRQ blocked by another device?
Jan 13 16:34:31 fussbudget kernel:   Flags; bus-master 1, dirty 16(0) 
current 16(0)
Jan 13 16:34:31 fussbudget kernel:   Transmit list 00000000 vs. de0bd200.
Jan 13 16:34:31 fussbudget kernel:   0: @de0bd200  length 8000002a 
status 0001002a
Jan 13 16:34:31 fussbudget kernel:   1: @de0bd2a0  length 8000002a 
status 0001002a
Jan 13 16:34:31 fussbudget kernel:   2: @de0bd340  length 8000002a 
status 0001002a
Jan 13 16:34:31 fussbudget kernel:   3: @de0bd3e0  length 8000002a 
status 0001002a
Jan 13 16:34:31 fussbudget kernel:   4: @de0bd480  length 8000002a 
status 0001002a
Jan 13 16:34:31 fussbudget kernel:   5: @de0bd520  length 8000002a 
status 0001002a
Jan 13 16:34:31 fussbudget kernel:   6: @de0bd5c0  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   7: @de0bd660  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   8: @de0bd700  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   9: @de0bd7a0  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   10: @de0bd840  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   11: @de0bd8e0  length 80000123 
status 0c010123
Jan 13 16:34:31 fussbudget kernel:   12: @de0bd980  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   13: @de0bda20  length 8000006e 
status 0c01006e
Jan 13 16:34:31 fussbudget kernel:   14: @de0bdac0  length 8000006e 
status 8c01006e
Jan 13 16:34:31 fussbudget kernel:   15: @de0bdb60  length 8000006e 
status 8c01006e
Jan 13 16:34:31 fussbudget kernel: eth0: Resetting the Tx ring pointer.



