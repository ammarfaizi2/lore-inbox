Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKFJpf>; Tue, 6 Nov 2001 04:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRKFJpZ>; Tue, 6 Nov 2001 04:45:25 -0500
Received: from pc-62-31-38-224-hy.blueyonder.co.uk ([62.31.38.224]:20881 "EHLO
	lian.jtfltd.co.uk") by vger.kernel.org with ESMTP
	id <S278709AbRKFJpR>; Tue, 6 Nov 2001 04:45:17 -0500
Subject: 2.4.14 doesn't compile: drivers/char/char.o(.text+0x13cb7):
	undefined reference to `register_serial'
From: Scott White <scott@clubguide.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16 (Preview Release)
Date: 06 Nov 2001 09:45:14 +0000
Message-Id: <1005039914.5258.6.camel@lian>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I hope this is of use to you all.  I am unable to compile 2.4.14 on my
system.  I will start looking into it.

[root@lian linux]# make oldconfig
....
[root@lian linux]# make clean && make dep && make && make modules &&
make modules_install
....
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon     -c -o mmx.o mmx.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o
memcpy.o strstr.o mmx.o
make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o
drivers/ide/idedriver.o drivers/cdrom/driver.o
drivers/sound/sounddrivers.o drivers/pci/driver.o
drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o
drivers/video/video.o \
	net/network.o \
	/usr/src/linux-2.4.14/arch/i386/lib/lib.a
/usr/src/linux-2.4.14/lib/lib.a
/usr/src/linux-2.4.14/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/char/char.o: In function `register_serial_portandirq':
drivers/char/char.o(.text+0x13cb7): undefined reference to
`register_serial'
make: *** [vmlinux] Error 1




[root@lian linux]# uname -a
Linux lian 2.4.10-ac5 #2 Fri Oct 5 19:13:16 BST 2001 i686 unknown
[root@lian linux]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 10b9:1647 (Acer Laboratories Inc. [ALi])
(rev 2).
      Prefetchable 32 bit memory at 0xf0000000 [0xf3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 0).
      Master Capable.  No bursts.  Min Gnt=14.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 3).
      IRQ 10.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xdf001000 [0xdf001fff].
  Bus  0, device   4, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 196).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev 0).
  Bus  0, device  13, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 120).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xd400 [0xd47f].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf00007f].
  Bus  0, device  15, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
16).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd800 [0xd8ff].
  Bus  0, device  16, function  0:
    RAID bus controller: CMD Technology Inc PCI0649 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0xdc00 [0xdc07].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe407].
      I/O at 0xe800 [0xe803].
      I/O at 0xec00 [0xec0f].
  Bus  0, device  17, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX)
(rev 178).
      IRQ 5.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].


