Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJUMgj>; Mon, 21 Oct 2002 08:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJUMgj>; Mon, 21 Oct 2002 08:36:39 -0400
Received: from atlas.inria.fr ([138.96.66.22]:4800 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S261347AbSJUMga>;
	Mon, 21 Oct 2002 08:36:30 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
Organization: SEMIR - INRIA Sophia Antipolis
To: linux-kernel@vger.kernel.org
Subject: lspci problem on dell cpi400 laptop (pci/pcmcia related ?)
Date: Mon, 21 Oct 2002 14:42:32 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210211442.33449.Nicolas.Turro@sophia.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,
To manage our linux parc, we use lspci (rpm  RedHat pciutils-2.1.9-2), and a 
home-compiled kernel (2.4.17).
We spotted a problem on dell cpi400 where lspci answers :

root@prao# lspci
pcilib: Cannot open /proc/bus/pci/07/00.1
lspci: Unable to read 64 bytes of configuration space.

The same version of lspci and kernel works everywhere (500+ machines).
Can some one give me any clue on what should i do ? Upgrade lspci ?
change some kernel configuration options ?


interresting files/traces :

part of strace lspci :

access("/proc/bus/pci", R_OK)           = 0
open("/proc/bus/pci/devices", O_RDONLY) = 3
fstat64(0x3, 0xbffff874)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40015000
read(3, "0000\t80867190\t0\tf0000008\t0000000"..., 1024) = 1024
read(3, "\t00000000\t00000000\t00000000\t0000"..., 1024) = 1024
read(3, "0000\t00000000\t00000000\t00000000\t"..., 1024) = 396
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
open("/proc/bus/pci/07/00.1", O_RDONLY) = -1 ENOENT (No such file or 
directory)
write(2, "pcilib: ", 8pcilib: )                 = 8
write(2, "Cannot open /proc/bus/pci/07/00."..., 33Cannot open 
/proc/bus/pci/07/00.1) = 33
write(2, "\n", 1
)                       = 1
write(2, "lspci: ", 7lspci: )                  = 7
write(2, "Unable to read 64 bytes of confi"..., 47Unable to read 64 bytes of 
configuration space.) = 47
write(2, "\n", 1
)                       = 1

interresting files/traces :

root@prao# ls /proc/bus/pci/
00  01  02  devices

kernel log :
Linux PCMCIA Card Services 3.1.33
  kernel build: 2.4.17 #1 Wed Jun 5 18:47:18 MEST 2002
  options:  [pci] [cardbus] [apm]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
PCI: Sharing IRQ 11 with 00:07.2
PCI: Found IRQ 11 for device 00:03.1
PCI: Sharing IRQ 11 with 00:03.0
PCI: Sharing IRQ 11 with 00:07.2
  TI 1225 rev 01 PCI-to-CardBus at slot 00:03, mem 0x10000000
    host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 32/176] [bus 
3/6]
    host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 32/176] [bus 
7/10]
    ISA irqs (scanned) = 3,4,7,15 PCI status changes
cs: cb_alloc(bus 7): vendor 0x115d, device 0x0003
ROM image dump:
  image 0: 0x000000-0x0001ff, signature PCIR
cs: cb_config(bus 7)
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0380-0x03bf: clean.
cs: IO port probe 0x03e0-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x84f 0x868-0x86f
cs: IO port probe 0x0870-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
  fn 0 bar 2: mem 0x60013000-0x600137ff
  fn 0 bar 3: mem 0x60012000-0x600127ff
  fn 1 bar 1: io 0x180-0x187
  fn 1 bar 2: mem 0x60011000-0x600117ff
  fn 1 bar 3: mem 0x60010000-0x600107ff
  fn 0 bar 1: io 0x100-0x17f
  fn 0 rom: mem 0x6000c000-0x6000ffff
  fn 1 rom: mem 0x60008000-0x6000bfff
  irq 11
cs: cb_enable(bus 7)
  bridge io map 0 (flags 0x21): 0x100-0x187
  bridge mem map 0 (flags 0x1): 0x60008000-0x60013fff
tulip_attach(device 07:00.0)
tulip.c:v0.91g-ppc 7/16/99 becker@scyld.com (modified by 
danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)
eth1: Xircom Cardbus Adapter (DEC 21143 compatible mode) rev 3 at 0x100, 
00:10:A4:E0:B9:BB, IRQ 11.
eth1:  MII transceiver #0 config 3100 status 7809 advertising 01e1.
serial_attach(device 07:00.1)


root@prao# cat /proc/bus/pci/devices
0000    80867190        0       f0000008        00000000        00000000        
00000000        00000000        00000000        00000000        04000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0008    80867191        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0018    104cac1c        b       10000000        00000000        00000000        
00000000        00000000        00000000        00000000        00001000        
00000000        00000000        00000000        00000000        00000000        
00000000
0019    104cac1c        b       10001000        00000000        00000000        
00000000        00000000        00000000        00000000        00001000        
00000000        00000000        00000000        00000000        00000000        
00000000
0038    80867110        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0039    80867111        0       00000000        00000000        00000000        
00000000        00000861        00000000        00000000        00000000        
00000000        00000000        00000000        00000010        00000000        
00000000
003a    80867112        b       00000000        00000000        00000000        
00000000        0000ece1        00000000        00000000        00000000        
00000000        00000000        00000000        00000020        00000000        
00000000        usb-uhci
003b    80867113        9       00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0088    8086124b        0       00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0100    10c80005        b       f9000008        fdc00000        fdb00000        
00000000        00000000        00000000        00000000        01000000        
00400000        00100000        00000000        00000000        00000000        
00000000
0101    10c88005        5       f8c00008        fda00000        00000000        
00000000        00000000        00000000        00000000        00400000        
00100000        00000000        00000000        00000000        00000000        
00000000
0208    102b0520        a       f6000008        fbffc000        fb000000        
00000000        00000000        00000000        80000000        01000000        
00004000        00800000        00000000        00000000        00000000        
00010000
0228    10950646        a       0000fcf9        0000fcf1        0000fce1        
0000fcd9        0000fcc1        00000000        00000000        00000008        
00000004        00000008        00000004        00000010        00000000        
00000000
0238    90046078        a       0000f801        fbffb000        00000000        
00000000        00000000        00000000        00000000        00000100        
00001000        00000000        00000000        00000000        00000000        
00000000
0240    10b79050        a       0000fc81        00000000        00000000        
00000000        00000000        00000000        fc000000        00000040        
00000000        00000000        00000000        00000000        00000000        
00010000        3c59x
0700    115d0003        b       00000101        60013000        60012000        
00000000        00000000        00000000        6000c000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
0701    115d0103        b       00000181        60011000        60010000        
00000000        00000000        00000000        60008000        00000000        
00000000        00000000        00000000        00000000        00000000        
00000000
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9s/Y5ty/HpgyBIboRAtOSAJ9u/5kaxxPlc0Rn7HM73IbVY5SUYgCg2/I5
YduHML1Eq5PYMBTSZhWPP5c=
=rC/K
-----END PGP SIGNATURE-----
