Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131519AbRAOFEJ>; Mon, 15 Jan 2001 00:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131607AbRAOFD7>; Mon, 15 Jan 2001 00:03:59 -0500
Received: from mtaout.telus.net ([199.185.220.235]:62807 "EHLO
	priv-edtnes09-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S131519AbRAOFDu>; Mon, 15 Jan 2001 00:03:50 -0500
Date: Sun, 14 Jan 2001 21:02:18 +0000 (PST)
From: Konstantin Cherenkoff <cherenkoff@telus.net>
To: linux-kernel@vger.kernel.org
Subject: Oops in rtl8139, and more ...
Message-ID: <Pine.LNX.4.21.0101102330380.351-100000@-V>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I have an ADSL Internet connection and use dhcpcd (ver. 1.3.19-pl2) as
DHCP client. Everything works OK, but in one particular situation I always
get a kernel Oops. Here's how:

1) Boot into runlevel 1
2) Put computer into suspend mode (it wakes up immediately)
3) Change to runlevel 3

When dhcpcd is started from boot script, I immediately get the following
Oops (translated here via ksymoops):


ksymoops 2.3.7 on i686 2.4.0-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-ac4/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer derefernce at virtual address 00000000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010 : [<c01a180e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c500100c   ebx: 00000001     ecx: c115bd40       edx: 00000000
esi: 00000000   edi: c500100      ebp: c115bc00        esp: c39f3d6c
ds: 0018        es: 0018       ss: 0018
Process dhcpcd (pid: 57, stackpage=c39f3000)
Stack: 00000001 c500103e c5001000 c115bc00 c01249c0 c5001037 00000000 c39f0000
       00000001 c01a1d53 c115bc00 c115bd40 c5001000 c11f0f80 04000001 0000000b
       c39f3e04 00000000 00000014 c115bd40 c010a16d 0000000b c115bc00 c39f3e04
Call trace: <c500103e> <c5001000> <c01249c0> <c5001037> <c01a1d53> <c5001000>
            <c010a16d> <c010a2d7> <c0108f68> <c010a6a1> <c01a1c84> <c010a3a8>
            <c01a067e> <c01a1c84> <c01f4f90> <c01f5bad> <c0219634> <c0125990>
            <c0122b00> <c021b2ab> <c01f0491> <c022a9e1> <c01f0a05> <c01f09e4>
            <c013ec97> <c0108ebf>
Code: 8b 04 16 89 44 24 18 c1 6c 24 18 10 8b 6c 24 18 83 c5 fc 81

>>EIP; c01a180e <rtl8139_rx_interrupt+b6/264>   <=====
Trace; c500103e <END_OF_CODE+4cc1de6/????>
Trace; c5001000 <END_OF_CODE+4cc1da8/????>
Trace; c01249c0 <___wait_on_page+9c/a4>
Trace; c5001037 <END_OF_CODE+4cc1ddf/????>
Trace; c01a1d53 <rtl8139_interrupt+cf/164>
Trace; c5001000 <END_OF_CODE+4cc1da8/????>
Trace; c010a16d <handle_IRQ_event+31/5c>
Trace; c010a2d7 <do_IRQ+6b/ac>
Trace; c0108f68 <ret_from_intr+0/20>
Trace; c010a6a1 <setup_irq+81/98>
Trace; c01a1c84 <rtl8139_interrupt+0/164>
Trace; c010a3a8 <request_irq+90/ac>
Trace; c01a067e <rtl8139_open+1e/128>
Trace; c01a1c84 <rtl8139_interrupt+0/164>
Trace; c01f4f90 <dev_open+48/a4>
Trace; c01f5bad <dev_change_flags+51/108>
Trace; c0219634 <devinet_ioctl+268/5b4>
Trace; c0125990 <filemap_nopage+0/448>
Trace; c0122b00 <handle_mm_fault+e8/164>
Trace; c021b2ab <inet_ioctl+133/198>
Trace; c01f0491 <sockfd_lookup+11/74>
Trace; c022a9e1 <packet_ioctl+315/340>
Trace; c01f0a05 <sock_ioctl+21/28>
Trace; c01f09e4 <sock_ioctl+0/28>
Trace; c013ec97 <sys_ioctl+1fb/214>
Trace; c0108ebf <system_call+33/38>
Code;  c01a180e <rtl8139_rx_interrupt+b6/264>
00000000 <_EIP>:
Code;  c01a180e <rtl8139_rx_interrupt+b6/264>   <=====
   0:   8b 04 16                  mov    (%esi,%edx,1),%eax   <=====
Code;  c01a1811 <rtl8139_rx_interrupt+b9/264>
   3:   89 44 24 18               mov    %eax,0x18(%esp,1)
Code;  c01a1815 <rtl8139_rx_interrupt+bd/264>
   7:   c1 6c 24 18 10            shrl   $0x10,0x18(%esp,1)
Code;  c01a181a <rtl8139_rx_interrupt+c2/264>
   c:   8b 6c 24 18               mov    0x18(%esp,1),%ebp
Code;  c01a181e <rtl8139_rx_interrupt+c6/264>
  10:   83 c5 fc                  add    $0xfffffffc,%ebp
Code;  c01a1821 <rtl8139_rx_interrupt+c9/264>
  13:   81 00 00 00 00 00         addl   $0x0,(%eax)

Kernel panic: Aiee, killing interrupt handler !

1 warning issued.  Results may not be reliable.


 

When I try to do emergency sync before rebooting, I see this:

SysReq: Emergency Sync
Syncing device 03:02 ... Scheduling in interrupt
Kernel BUG at sched.c: 688 !

And then, oops #2 ...

ksymoops 2.3.7 on i686 2.4.0-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-ac4/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Invalid operand: 0000
CPU: 0
EIP: 0010 : [<c0114421>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: 00000000     ecx: 00000001       edx: 00000001
ds: 0018        es: 0018       ss: 0018
Process dhcpcd (pid: 57, stackpage=c39f3000)
Stack: c0240a45 c0240b96 000002b0 c11ed180 c39f2000 c39f3be8 c11ed1c8 c39f2000
       c01abe8f c115c160 00000000 c017d3b4 00000282 c39f3bc8 c011a33c c39f2000
       c11ed180 00000000 c39f2000 c03363bc c11ed1c8 c0131f48 c11ed840 00000302
Call trace: <c01abe8f> <c017d3b4> <c011a33c> <c0131f48> <c01320d4> <c01321b0>
            <c019f2ca> <c019f31b> <c01163ee> <c0118eb3> <c010939e> <c0113943>
            <c0113604> <c01b0764> <c01abae0> <c01abada> <c0150db9> <c0108fdc>
            <c5001000> <c500100c> <c01a180e> <c500103e> <c5001000> <c01249c0>
            <c5001037> <c01a1d53> <c5001000> <c01a067e> <c01a1c84> <c01f4f90>
            <c01f5bad> <c0219634> <c0125990> <c0122b00> <c021b2ab> <c01f0491>
            <c022a9e1> <c01f0a05> <c01f09e4> <c013ec97> <c0108ebf>
Code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 8d 76 00 55 89 e5 83 ec	           

>>EIP; c0114421 <schedule+421/430>   <=====
Trace; c01abe8f <do_ide_request+f/14>
Trace; c017d3b4 <generic_unplug_device+20/28>
Trace; c011a33c <__run_task_queue+50/64>
Trace; c0131f48 <__wait_on_buffer+48/90>
Trace; c01320d4 <sync_buffers+144/1d4>
Trace; c01321b0 <fsync_dev+28/30>
Trace; c019f2ca <go_sync+106/118>
Trace; c019f31b <do_emergency_sync+3f/a4>
Trace; c01163ee <panic+de/e0>
Trace; c0118eb3 <do_exit+27/218>
Trace; c010939e <die+42/44>
Trace; c0113943 <do_page_fault+33f/41c>
Trace; c0113604 <do_page_fault+0/41c>
Trace; c01b0764 <piix_dmaproc+0/2c>
Trace; c01abae0 <start_request+1ec/25c>
Trace; c01abada <start_request+1e6/25c>
Trace; c0150db9 <ext2_get_block+2d/514>
Trace; c0108fdc <error_code+34/3c>
Trace; c5001000 <END_OF_CODE+4cc1da8/????>
Trace; c500100c <END_OF_CODE+4cc1db4/????>
Trace; c01a180e <rtl8139_rx_interrupt+b6/264>
Trace; c500103e <END_OF_CODE+4cc1de6/????>
Trace; c5001000 <END_OF_CODE+4cc1da8/????>
Trace; c01249c0 <___wait_on_page+9c/a4>
Trace; c5001037 <END_OF_CODE+4cc1ddf/????>
Trace; c01a1d53 <rtl8139_interrupt+cf/164>
Trace; c5001000 <END_OF_CODE+4cc1da8/????>
Trace; c01a067e <rtl8139_open+1e/128>
Trace; c01a1c84 <rtl8139_interrupt+0/164>
Trace; c01f4f90 <dev_open+48/a4>
Trace; c01f5bad <dev_change_flags+51/108>
Trace; c0219634 <devinet_ioctl+268/5b4>
Trace; c0125990 <filemap_nopage+0/448>
Trace; c0122b00 <handle_mm_fault+e8/164>
Trace; c021b2ab <inet_ioctl+133/198>
Trace; c01f0491 <sockfd_lookup+11/74>
Trace; c022a9e1 <packet_ioctl+315/340>
Trace; c01f0a05 <sock_ioctl+21/28>
Trace; c01f09e4 <sock_ioctl+0/28>
Trace; c013ec97 <sys_ioctl+1fb/214>
Trace; c0108ebf <system_call+33/38>
Code;  c0114421 <schedule+421/430>
00000000 <_EIP>:
Code;  c0114421 <schedule+421/430>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0114423 <schedule+423/430>
   2:   8d 65 bc                  lea    0xffffffbc(%ebp),%esp
Code;  c0114426 <schedule+426/430>
   5:   5b                        pop    %ebx
Code;  c0114427 <schedule+427/430>
   6:   5e                        pop    %esi
Code;  c0114428 <schedule+428/430>
   7:   5f                        pop    %edi
Code;  c0114429 <schedule+429/430>
   8:   89 ec                     mov    %ebp,%esp
Code;  c011442b <schedule+42b/430>
   a:   5d                        pop    %ebp
Code;  c011442c <schedule+42c/430>
   b:   c3                        ret    
Code;  c011442d <schedule+42d/430>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0114430 <__wake_up+0/140>
   f:   55                        push   %ebp
Code;  c0114431 <__wake_up+1/140>
  10:   89 e5                     mov    %esp,%ebp
Code;  c0114433 <__wake_up+3/140>
  12:   83 ec 00                  sub    $0x0,%esp


1 warning issued.  Results may not be reliable.
 

If I don't suspend my PC, but switch direcly from runlevel 1 to 3, this
Oops doesn't happen. Also, when I try to reproduce this error while
already in runlevel 3 (kill dhcpcd -> suspend PC -> start dhcpcd), I don't
get any oopses either.

There goes ver-linux:

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux -V 2.4.0-ac4 #2 Mon Jan 8 00:47:45 PST 2001 i686 unknown
Kernel modules         2.3.2
Gnu C                  egcs-2.91.66
Gnu Make               3.79.1
Binutils               2.10
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.3
Mount                  2.10m
Kbd                    command
Sh-utils               2.0
Modules Loaded         


... and dmesg:

Linux version 2.4.0-ac4 (root@localhost) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #2 Mon Jan 8 00:47:45 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01112000)
Kernel command line: BOOT_IMAGE=Console ro root=302 parport=auto video=vesa:pmipal,mtrr 2.4
Initializing CPU#0
Detected 300.689 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 61724k/65536k available (1247k kernel code, 3428k reserved, 483k data, 244k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0080f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0080f9ff 00000000 00000000 00000000
CPU: Common caps: 0080f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Klamath) stepping 04
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf06d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
31 structures occupying 1022 bytes.
DMI table at 0x000F57AA.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS P2L97 ACPI BIOS Revision 1009                              
BIOS Release: 10/26/99
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: P2L97.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
Winbond chip at EFER=0x3f0 key=0x87 devid=97 devrev=73 oldid=ff
Winbond chip type 83977TF / SMSC 97w33x/97w34x
Winbond LPT Config: cr_30=01 60,61=0378 70=07 74=03, f0=3b
Winbond LPT Config: active=yes, io=0x0378 irq=7, dma=3
Winbond LPT Config: irqtype=pulsed low, high-Z, ECP fifo threshold=7
Winbond LPT Config: Port mode=ECP and EPP-1.9
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 9
0x378: readIntrThreshold is 9
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x48
0x378: ECP settings irq=7 dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Brother HL-1250
vesafb: framebuffer at 0xe3000000, mapped to 0xc4800000, size 8192k
vesafb: mode is 1024x768x24, linelength=3072, pages=2
vesafb: protected mode interface info at c000:7330
vesafb: pmi: set display start = c00c737f, set palette = c00c73aa
vesafb: pmi: ports = 3c0 3c4 3c5 3c7 3c8 3c9 3d4 3d5 3d6 3d7 3d8 3d9 3da 
vesafb: scrolling: redraw
vesafb: directcolor: size=0:8:8:8, shift=0:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
lp0: using parport0 (interrupt-driven).
lp0: console ready
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL ST6.4A, ATA DISK drive
hdb: ATAPI CD-ROM DRIVE 32X MAXIMUM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12594960 sectors (6449 MB) w/81KiB Cache, CHS=784/255/63, UDMA(33)
hdb: ATAPI 27X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
8139too Fast Ethernet driver 0.9.13a loaded
PCI: Found IRQ 11 for device 00:0c.0
eth0: RealTek RTL8139 Fast Ethernet at 0xc5001000, 00:50:ba:8d:cd:28, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139B'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 28M
agpgart: Detected Intel 440LX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 PnP detected
sb: ISAPnP reports 'Creative SB AWE64 PnP' at i/o 0x220, irq 5, dma 1, 5
<Sound Blaster 16 (4.16)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
ISAPnP reports AWE64 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM512k)>
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 10 for device 00:04.2
uhci.c: USB UHCI at I/O 0xd400, IRQ 10
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack (512 buckets, 4096 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k freed
uhci.c: root-hub INT complete: port1: 93 port2: 80 data: 2
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x46d/0xd001) is not claimed by any active driver.
VFS: Disk change detected on device ide0(3,64)
microcode: CPU0 updated from revision 0 to 55, date=09231998
microcode: freed 2048 bytes
Adding Swap: 135160k swap-space (priority -1)
 
... and, finally, kernel config:

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_M686FXSR is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_LVM_PROC_FS is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
CONFIG_IP_NF_QUEUE=y
# CONFIG_IP_NF_IPTABLES is not set
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139TOO=y
# CONFIG_RTL8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
CONFIG_SERIAL_EXTENDED=y
# CONFIG_SERIAL_MANY_PORTS is not set
# CONFIG_SERIAL_SHARE_IRQ is not set
CONFIG_SERIAL_DETECT_IRQ=y
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_UNIX98_PTYS is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_SMB_NLS is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
# CONFIG_FBCON_CFB32 is not set
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FBCON_VGA=y
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Sound
#
CONFIG_SOUND=y
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_YMFPCI is not set
CONFIG_SOUND_OSS=y
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=y
CONFIG_SOUND_AWE32_SYNTH=y
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=y
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMPCI is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_UHCI_ALT=y
# CONFIG_USB_OHCI is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y


I would appreciate any suggestions on how to fix it.


Since I am not subscribed to LKML, please CC me at cherenkoff@telus.net


Konstantine Cherenkoff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
