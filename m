Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262858AbSJFBRq>; Sat, 5 Oct 2002 21:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJFBRq>; Sat, 5 Oct 2002 21:17:46 -0400
Received: from adsl-63-200-61-2.dsl.snfc21.pacbell.net ([63.200.61.2]:16572
	"EHLO irulethe.net") by vger.kernel.org with ESMTP
	id <S262858AbSJFBRo>; Sat, 5 Oct 2002 21:17:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [PowerPC] Bug in IEEE1394 implementation on PowerBooks
Message-Id: <20021006012230.629D595E84@irulethe.net>
Date: Sat,  5 Oct 2002 18:22:30 -0700 (PDT)
From: anrp@irulethe.net (Andrew Patrikalakis)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Putting the PowerBook to sleep with ieee1394 modules loaded causes a bus error after waking up the machine and trying to use the bus
[2.] 	If ieee1934 modules are loaded (ieee1394, ohci1394 and sbp2) on 
a PowerBook and the pbook is put to sleep with the modules loaded, if you
try to use the modules after waking the machine up it causes a Bus error
[3.] ieee1394, pbook, apple, mac, pmu
[4.] Linux version 2.4.19-rc5-hfsplus (root@mizuho) (gcc version 2.95.3 20010315 (release)) #2 Fri Aug 2 20:16:29 EDT 2002
[5.] n/a
[6.] ----
#!/bin/sh
# With a ieee1394 disk connected
insmod ieee1394
insmod ohci1394
insmod sbp2
snooze
# now wakeup the machine ;-)
mount /dev/sda1 /mnt/other
# end -------
[7.] --- Enviroment? ok... ---
PWD=/dev/scsi
COLORFGBG=default;15
ACLOCAL_FLAGS=-I /usr/local/share/aclocal
WINDOWID=18874371
HZ=100
LD_LIBRARY_PATH=/lib:/lib:
PS1=[\u@\h \W]$ 
USER=root
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:
MAIL=/var/mail/root
COLORTERM=rxvt-xpm
DISPLAY=:0.0
LOGNAME=root
SHLVL=4
HUSHLOGIN=FALSE
IRCPORT=7001
SHELL=/bin/bash
TERM=rxvt
HOME=/root
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin:/usr/games:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11R6/bin
DVDCSS_METHOD=title
_=/usr/bin/printenv
OLDPWD=/root
----
[7.1.] Software ---
Linux mizuho 2.4.19-rc5-hfsplus #2 Fri Aug 2 20:16:29 EDT 2002 ppc unknown
 
 Gnu C                  2.95.3
 Gnu make               3.79.1
 util-linux             2.11o
 mount                  2.11o
 modutils               2.4.15
 e2fsprogs              1.27
 pcmcia-cs              3.1.33
 PPP                    2.4.1
 awk: cmd. line:2: (FILENAME=- FNR=1) fatal: attempt to access field -1 (gawk v3.1)
 Dynamic linker (ldd)   2.2.5
 Procps                 2.0.7
 Net-tools              1.60
 Kbd                    1.06
 Sh-utils               2.0
 Modules Loaded         dmasound_pmac dmasound_core soundcore usb-storage macserial i2c-core
 
[7.2.] Processor information (from /proc/cpuinfo):
cpu             : 740/750
temperature     : 40 C (uncalibrated)
clock           : 400MHz
revision        : 131.2 (pvr 0008 8302)
bogomips        : 797.90
machine         : PowerBook3,1
motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
detected as     : 70 (PowerBook Pismo)
pmac flags      : 00000003
L2 cache        : 1024K unified
memory          : 192MB
pmac-generation : NewWorld
[7.3.] Module information (from /proc/modules):
dmasound_pmac          46616   1
dmasound_core          13512   1 [dmasound_pmac]
soundcore               4632   3 [dmasound_core]
usb-storage            97896   0 (unused)
macserial              39220   1
i2c-core               14584   0 [dmasound_pmac]
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
00000000-007fffff : /pci@f2000000
00802000-01001fff : /pci@f0000000
  00802400-008024ff : ATI Technologies Inc Rage Mobility M3 AGP 2x
  d0a1e010-d0a1e010 : ide0
  d0a1e020-d0a1e020 : ide0
  d0a1e030-d0a1e030 : ide0
  d0a1e040-d0a1e040 : ide0
  d0a1e050-d0a1e050 : ide0
  d0a1e060-d0a1e060 : ide0
  d0a1e070-d0a1e070 : ide0
  d0a1e160-d0a1e160 : ide0
  d0a26010-d0a26010 : ide2
  d0a26020-d0a26020 : ide2
  d0a26030-d0a26030 : ide2
  d0a26040-d0a26040 : ide2
  d0a26050-d0a26050 : ide2
  d0a26060-d0a26060 : ide2
  d0a26070-d0a26070 : ide2
  d0a26160-d0a26160 : ide2
  ff7fe000-ffffdfff : /pci@f4000000

 --- iomem
  80000000-8007ffff : Apple Computer Inc. KeyLargo Mac I/O
    80000034-80000034 : media-bay
    80008400-800084ff : ch-a (tx dma)
    80008500-800085ff : ch-a (rx dma)
    80008600-800086ff : ch-b (tx dma)
    80008700-800087ff : ch-b (rx dma)
    80008800-800088ff : davbus (tx dma)
    80008900-800089ff : davbus (rx dma)
    80008a00-80008aff : ata-4 (mac-io IDE DMA)
    80008b00-80008bff : ata-3 (mac-io IDE DMA)
    80008c00-80008cff : ata-3 (mac-io IDE DMA)
    80013000-80013000 : ch-b
    80013020-80013020 : ch-a
    80014000-80014fff : davbus
    80016000-80017fff : via-pmu
    8001f000-8001ffff : ata-4  (mac-io IDE IO)
    80020000-80020fff : ata-3  (mac-io IDE IO)
    80021000-80021fff : ata-3  (mac-io IDE IO)
    80040000-8007ffff : interrupt-controller
  a0000000-a0000fff : Texas Instruments PCI1211
  a0001000-a0001fff : Apple Computer Inc. KeyLargo USB (#2)
    a0001000-a0001fff : usb-ohci
  a0002000-a0002fff : Apple Computer Inc. KeyLargo USB
    a0002000-a0002fff : usb-ohci
b0000000-bfffffff : /pci@f0000000
  b0000000-b0003fff : ATI Technologies Inc Rage Mobility M3 AGP 2x
    b0000000-b0003fff : aty128fb MMIO
  b4000000-b7ffffff : ATI Technologies Inc Rage Mobility M3 AGP 2x
    b4000000-b7ffffff : aty128fb FB
f1000000-f1ffffff : /pci@f0000000
f3000000-f3ffffff : /pci@f2000000
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : Apple Computer Inc. UniNorth FireWire
  f5200000-f53fffff : Apple Computer Inc. UniNorth GMAC (Sun GEM)
    f5200000-f53fffff : ethernet (gmac)
f8000000-f8ffffff : uni-n
[7.5.] PCI information ('lspci -vvv' as root)
>don't have lspci, cat /proc/pci<
PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Computer Inc. UniNorth AGP (rev 0).
      Master Capable.  Latency=16.  
  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 
2).
      IRQ 48.
      Master Capable.  Latency=255.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xb4000000 [0xb7ffffff].
      I/O at 0x802400 [0x8024ff].
      Non-prefetchable 32 bit memory at 0xb0000000 [0xb0003fff].
  Bus  1, device  11, function  0:
    Host bridge: Apple Computer Inc. UniNorth PCI (rev 0).
      Master Capable.  Latency=16.  
  Bus  1, device  23, function  0:
    Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 3).
      Master Capable.  Latency=16.  
      Non-prefetchable 32 bit memory at 0x80000000 [0x8007ffff].
  Bus  1, device  24, function  0:
    USB Controller: Apple Computer Inc. KeyLargo USB (rev 0).
      IRQ 27.
      Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0xa0002000 [0xa0002fff].
  Bus  1, device  25, function  0:
    USB Controller: Apple Computer Inc. KeyLargo USB (#2) (rev 0).
      IRQ 28.
      Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0xa0001000 [0xa0001fff].
  Bus  1, device  26, function  0:
    CardBus bridge: Texas Instruments PCI1211 (rev 0).
      IRQ 58.
      Master Capable.  Latency=16.  Min Gnt=64.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xa0000000 [0xa0000fff].
  Bus  6, device  11, function  0:
    Host bridge: Apple Computer Inc. UniNorth Internal PCI (rev 0).
      Master Capable.  Latency=16.  
  Bus  6, device  14, function  0:
    Class ffff: Apple Computer Inc. UniNorth FireWire (rev 255).
      IRQ 40.
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf5000000 [0xf5000fff].
  Bus  6, device  15, function  0:
    Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun GEM) (rev 1).
      IRQ 41.
      Master Capable.  Latency=16.  Min Gnt=64.Max Lat=64.
      Non-prefetchable 32 bit memory at 0xf5200000 [0xf53fffff].
[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: none
[7.7.] It's fairly obvious what this problem is - the device isn't shut down
properly at a sleep request (it doesn't request to be shutdown from the PMU
code). This should be an easy fix that I can do, but I'd need some pointers
to other drivers that do this (insert a sleep notification into the PMU
driver).
[X.] If someone can e-mail me with the pertinent information, I'd be
happy to fix the problem ;-). Or anything else for that matter, I'm
not subscribed to the list ^^; I'm also relatively sure it hasn't 
been fixed in the latest version (2.4.20-pre9) as the pertinant parts
of the code aren't different.

Andrew Patrikalakis

-----
Fear the geeks in black! THEY'RE OUT TO GET YOU!!!
