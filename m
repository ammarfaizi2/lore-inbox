Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSAMXyQ>; Sun, 13 Jan 2002 18:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288327AbSAMXyH>; Sun, 13 Jan 2002 18:54:07 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:161 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288325AbSAMXxw>; Sun, 13 Jan 2002 18:53:52 -0500
Date: Mon, 14 Jan 2002 01:00:20 +0100
From: Till Doerges <nospamplease@doerges.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: System locks up after "spurious 8259A interrupt: IRQ7"
Message-ID: <20020114010019.A2710@atlan.wanderer.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: <none>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[The e-mail-address *is* valid.]
[Please CC me, since I'm not subscribed to lkml.]

Hi everybody,

sporadically my machine hangs (no response to keyboard, can't connect
via network, no interaction via remote-control) and the last thing I
see (if I see anything at all) is something like

--- snip ---
[...]
Jan 13 21:30:00 atlan CROND[2876]: (till) CMD (fetchmail&> /dev/null)
Jan 13 21:30:09 atlan kernel: spurious 8259A interrupt: IRQ7.
Jan 13 21:36:12 atlan syslogd 1.3-3: restart (remote reception).
Jan 13 21:36:12 atlan kernel: klogd 1.3-3, log source = /proc/kmsg started.
[...]
--- snap ---

I've been looking through the archives of lkml concerning this
spurious 8259A interrupt but all I've learned is that I'm not the only
one having this problem. My apologies, if I've overlooked anything or
if this is not the correct address for my problem. (In this case,
hints concerning 'the-right-thing-to-do' would be appreciated.)

I'm not even sure, whether it's not only a symptom and the real
problem is anyting else, as for some people it merely seems to enlarge
the logs. But for me it indicates a complete hang.

The conditions leading to this lock up are not deterministically
reproducable (at least not to my knowledge), but if it appears I'm
always watching TV using my tuner-card. It seems to *help*, if I'm
trying to download something via ftp, although I have abstined from
that lately.

If I'm letting my machine idle, compile anything or compute anything
else w/o using the tuner-card, I don't have any problems.

Maybe some choking related to PCI-transfers?

If I remember correctly, I was only experiencing this problem w/ 2.4.x
kernels (some vanilla, some w/ patches from Alan) and w/ all versions
from Redhat's gcc-2.96.

I don't have APIC enabled, neither do I have a tulip-card. The current
kernel has been patched w/ v4l2-support, but I'm not using it. I
didn't try the bttv-0.8.x extensively, since I didn't manage to get
sound. To watch tv, I use xawtv-3.x (x = 48, right now).

I'm using a TEKRAM Board (P5MVP-A4) w/ a Via Apollo MP3, a Cyrix MII
(233 MHz) and 128 MB of RAM.

Below I've included some further information about my system. I hope
it's (enough to be) useful. If I forgot anything, please tell me. Or,
if you want me try something to hunt down the bug, I'll try my very
best.

Thanks -- Till

--- snip ---
till@atlan:/usr/src/linux> sh scripts/ver_linux
Linux atlan 2.4.16-v4l2 #2 Sun Dec 9 12:20:24 CET 2001 i686 unknown
 
Gnu C                  2.96-98
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11f
modutils               2.4.2
e2fsprogs              1.23
reiserfsprogs          3.x.0f
PPP                    2.4.0
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         tuner tvaudio bttv i2c-algo-bit videodev lirc_i2c i2c-core lirc_dev af_packet ppp_async ppp_generic slhc 8139too ipchains agpgart awe_wave sb sb_lib uart401
sound soundcore usb-uhci usbcore rtc apm

till@atlan:/usr/src/linux> cat /proc/interrupts
           CPU0
  0:     991950          XT-PIC  timer
  1:      14671          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        829          XT-PIC  bttv
  5:          1          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:       5593          XT-PIC  usb-uhci, eth0
 12:      47501          XT-PIC  PS/2 Mouse
 14:      11948          XT-PIC  ide0
NMI:          0
ERR:          0

till@atlan:/usr/src/linux> cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001d5f5b : Kernel code
  001d5f5c-0020eb03 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
e4000000-e7ffffff : PCI Bus #01
  e4000000-e7ffffff : ATI Technologies Inc Rage 128 PF
e8000000-e9ffffff : PCI Bus #01
  e9000000-e9003fff : ATI Technologies Inc Rage 128 PF
eb000000-eb000fff : Brooktree Corporation Bt878
  eb000000-eb000fff : bttv
eb001000-eb001fff : Brooktree Corporation Bt878
eb002000-eb002fff : Adaptec AHA-294x / AIC-7871
eb003000-eb0030ff : Realtek Semiconductor Co., Ltd. RTL-8139
  eb003000-eb0030ff : 8139too
ffff0000-ffffffff : reserved

till@atlan:/usr/src/linux> cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0220-022f : soundblaster
0330-0333 : MPU-401 UART
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0620-0623 : sound driver (AWE32)
0a20-0a23 : sound driver (AWE32)
0cf8-0cff : PCI conf1
0e20-0e23 : sound driver (AWE32)
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc Rage 128 PF
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : VIA Technologies, Inc. UHCI USB
  e400-e41f : usb-uhci
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e800-e8ff : 8139too
ec00-ecff : Adaptec AHA-294x / AIC-7871

till@atlan:/usr/src/linux> dmesg | grep bttv
bttv: driver version 0.7.83 loaded
bttv: Host bridge is VIA Technologies, Inc. VT82C597 [Apollo VP3]
bttv: Host bridge is VIA Technologies, Inc. VT82C586B ACPI
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:0a.0, irq: 3, latency: 64, memory: 0xeb000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]

till@atlan:/usr/src/linux> dmesg | grep via
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
agpgart: Detected Via MVP3 chipset

till@atlan:/usr/src/linux> dmesg | grep ide
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,1), internal journal
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,5), internal journal
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on ide0(3,8), internal journal

till@atlan:/usr/src/linux> dmesg | grep eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xc88e3000, 00:30:84:26:16:49, IRQ 9
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
--- snap ---
