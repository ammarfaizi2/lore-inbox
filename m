Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSLMMf4>; Fri, 13 Dec 2002 07:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262631AbSLMMf4>; Fri, 13 Dec 2002 07:35:56 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10370 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S262500AbSLMMfy>; Fri, 13 Dec 2002 07:35:54 -0500
Message-Id: <200212131243.gBDChgmi031144@hirsch.in-berlin.de>
X-Envelope-From: hp@lxhp.in-berlin.de
Content-Type: text/plain; charset=US-ASCII
From: h-peter recktenwald <hp@lxhp.in-berlin.de>
Organization: Lux3
To: linux-kernel@vger.kernel.org
Subject: kernel isapnp (2.4.20) 
Date: Fri, 13 Dec 2002 12:36:56 +0000
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.33.0212082154480.913-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0212082154480.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.20 inbuilt isapp returns false data:
-----------------------------------------------
from /var/log/messages
sb creative 'vibra16', 

1) non-functional with isapnp by kernel:

kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
kernel: sb: Creative ViBRA16X PnP detected
Dec  2 18:16:57 Lux3 kernel: sb: ISAPnP reports 'Creative ViBRA16X PnP' at 
i/o 0x220, irq 10, dma 1, 3
kernel: SB 4.16 detected OK (220)
kernel: SB16: Bad or missing 16 bit DMA channel
Dec  2 18:16:57 Lux3 kernel: sb: 1 Soundblaster PnP card(s) found.
------------------------------------------------

2) all but /dev/sndstat (which worked w. 2.4.19, same set-up) 
if kernel-isapnp disabled and, configured after <pnpdump> otput:

kernel: Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
kernel: SB 4.16 detected OK (220)
kernel: <Sound Blaster 16 (4.16)> at 0x220 irq 7 dma 1,5
kernel: <Sound Blaster 16> at 0x330 irq 7 dma 0,0
kernel: YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 
1993-1996
kernel: <Yamaha OPL3> at 0x388
kernel: MIDI Loopback device driver

# -----------------------------------

system, <ver_linux>:
 ---
Linux Lux3 2.4.20 #2 Sat Dec 7 09:50:48 GMT 2002 i586 unknown
 ---
C compiler             2.95.4
make                   3.79.1
binutils               20020814
util-linux             v2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
ppp                    2.4.1
isdn4k-utils           3.1pre4
C library              2.2.5
dynamic linker (ldd)   2.2.5
procps                 2.0.7
net-tools              1.60
console-tools          0.2.3
sh-utils               2.0.11
modules                isdn_bsdcomp hisax isdn ipchains bridge romfs nls_utf8 
nls_koi8-u nls_koi8-ru nls_koi8-r nls_iso8859-7 nls_iso8859-5 nls_iso8859-4 
nls_iso8859-15 nls_iso8859-14 nls_iso8859-13 nls_iso8859-1 nls_gb2312 
nls_cp936 nls_cp866 nls_cp865 nls_cp864 nls_cp855 nls_cp852 nls_cp850 
nls_cp775 nls_cp437 nls_cp1251 nls_cp1250 nls_cp950 nls_big5 minix autofs acm 
usbcore v_midi opl3 sb sb_lib uart401 sound soundcore 8139too mii nbd

# -----------------------------------

statistics (after pnpdump config, only):

cat /dev/sndstat:
-----------------
	-/-

cat /proc/modules:
------------------
isdn_bsdcomp            5888   0
hisax                 131104  29 (autoclean)
isdn                  115200  30 (autoclean) [isdn_bsdcomp hisax]
ipchains               35876   0 (unused)
bridge                 15308   0 (unused)
romfs                   3584   0 (unused)
nls_utf8                 800   0 (unused)
    ...(more lang. mods)
nls_koi8-u              3872   1 (autoclean)
nls_iso8859-13          3392   0 (unused)
nls_iso8859-1           2880   2
minix                  18176   0 (unused)
autofs                  8932   0 (unused)
acm                     5024   0 (unused)
usbcore                53536   0 [acm]
v_midi                  4992   0 (unused)
opl3                   10792   0 (unused)
sb                      1792   0
sb_lib                 32288   0 [sb]
uart401                 6048   0 [sb_lib]
sound                  52588   0 [v_midi opl3 sb_lib uart401]
soundcore               3460   7 [sb_lib sound]
8139too                13376   1
mii                     2224   0 [8139too]
nbd                    14944   0 (unused)

cat /proc/interrupts:
---------------------
           CPU0       
  0:   44823924          XT-PIC  timer
  1:    1045591          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:    5026848          XT-PIC  HiSax
  7:        350          XT-PIC  soundblaster
  8:          3          XT-PIC  rtc
 10:          0          XT-PIC  eth0
 12:    3054844          XT-PIC  PS/2 Mouse
 14:     147687          XT-PIC  ide0
 15:    1403251          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

cat /proc/ioports:
------------------
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0220-022f : soundblaster
0240-0240 : HiSax hscx A fifo
02f8-02ff : serial(set)
0330-0333 : MPU-401 UART
0376-0376 : ide1
0378-037a : parport0
0388-038b : Yamaha OPL3
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0640-065f : HiSax hscx A
0a40-0a40 : HiSax hscx B fifo
0cf8-0cff : PCI conf1
0e40-0e5f : HiSax hscx B
1240-1240 : HiSax isac fifo
1640-165f : HiSax isac
1a40-1a47 : avm cfg
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
d400-d40f : Acer Laboratories Inc. [ALi] M5229 IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d800-d8ff : 8139too

cat /proc/dma:
 1: SoundBlaster8
 4: cascade
 5: SoundBlaster16
