Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292712AbSCESvC>; Tue, 5 Mar 2002 13:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293718AbSCESur>; Tue, 5 Mar 2002 13:50:47 -0500
Received: from [198.16.16.39] ([198.16.16.39]:61849 "EHLO carthage")
	by vger.kernel.org with ESMTP id <S292712AbSCESub>;
	Tue, 5 Mar 2002 13:50:31 -0500
Date: Tue, 5 Mar 2002 12:46:04 -0600
From: James Curbo <jcurbo@acm.org>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: a couple of USB related Oopses
Message-ID: <20020305184604.GA4590@carthage>
Reply-To: James Curbo <jcurbo@acm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[not subscribed to either list, cc: me please]

I got these today while trying to print to my HP Deskjet 845c USB printer.
I'm running 2.5.5-dj2. I think the first one came from when I booted,
and the second one came from when I unplugged the USB cable to my
printer and plugged it back in. My motherboard is a K7T Turbo, VIA KT133
chipset (UHCI controller). I'm using the alternate UHCI driver (JE), I
will try recompiling with the normal driver later and see if the problem
still occurs. (this is the first time I've really played around with the
USB drivers!) The ksymoops outputs, my dmesg, and my
/proc/dev/usb/devices are attached.


-- 
James Curbo <jcurbo@acm.org> <jc108788@rc.hsu.edu>
Undergraduate Computer Science, Henderson State University
PGP Keys at <http://reddie.henderson.edu/~curboj/>
Public Keys: PGP - 1024/0x76E2061B GNUPG - 1024D/0x3EEA7288

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-output-1.txt"

ksymoops 2.4.3 on i686 2.5.5-dj2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.5-dj2/ (default)
     -m /boot/System.map-2.5.5-dj2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 000000cd
c021caef
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c021caef>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: d78932c0   ecx: d78932dc   edx: c99a2000
esi: 00000000   edi: ccedc440   ebp: ffffffed   esp: c99a3f00
ds: 0018   es: 0018   ss: 0018
Stack: c022e11a d78932dc 000001f0 c030a860 c030b0e0 ccedc440 c021e868 d6bec0c0 
       ccedc440 c99a2000 ccedc440 00000000 d6bec0c0 c013761f d6bec0c0 ccedc440 
       ccedc440 d6bec0c0 00000000 c136e380 c0136051 d6bec0c0 ccedc440 00000000 
Call Trace: [<c022e11a>] [<c021e868>] [<c013761f>] [<c0136051>] [<c0135f62>] 
   [<c0136347>] [<c0108a1f>] 
Code: 8b 80 cc 00 00 00 85 c0 74 17 8b 50 18 85 d2 74 10 8b 44 24 

>>EIP; c021caee <usb_submit_urb+e/40>   <=====
Trace; c022e11a <usblp_open+ba/110>
Trace; c021e868 <usb_open+68/d0>
Trace; c013761e <chrdev_open+5e/a0>
Trace; c0136050 <dentry_open+e0/190>
Trace; c0135f62 <filp_open+52/60>
Trace; c0136346 <sys_open+36/80>
Trace; c0108a1e <syscall_call+6/a>
Code;  c021caee <usb_submit_urb+e/40>
00000000 <_EIP>:
Code;  c021caee <usb_submit_urb+e/40>   <=====
   0:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax   <=====
Code;  c021caf4 <usb_submit_urb+14/40>
   6:   85 c0                     test   %eax,%eax
Code;  c021caf6 <usb_submit_urb+16/40>
   8:   74 17                     je     21 <_EIP+0x21> c021cb0e <usb_submit_urb+2e/40>
Code;  c021caf8 <usb_submit_urb+18/40>
   a:   8b 50 18                  mov    0x18(%eax),%edx
Code;  c021cafa <usb_submit_urb+1a/40>
   d:   85 d2                     test   %edx,%edx
Code;  c021cafc <usb_submit_urb+1c/40>
   f:   74 10                     je     21 <_EIP+0x21> c021cb0e <usb_submit_urb+2e/40>
Code;  c021cafe <usb_submit_urb+1e/40>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


3 warnings issued.  Results may not be reliable.

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-output-2.txt"

ksymoops 2.4.3 on i686 2.5.5-dj2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.5-dj2/ (default)
     -m /boot/System.map-2.5.5-dj2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0115089
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0115089>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: d7d56000   ebx: 00000000   ecx: d7d57f30   edx: d78932d4
esi: d7d57f28   edi: 00000202   ebp: c13f2c00   esp: d7d57f08
ds: 0018   es: 0018   ss: 0018
Stack: d7d56000 d7d57f28 d78932c8 c01075d5 d78932c0 d78932c8 c030b1e0 00000000 
       00000001 c13f2c00 d78932d4 00000000 c01077e4 d78932c8 d78a01c0 c022ee10 
       c022ef5c c030b1c0 d78931c0 c021d971 d7d4da00 d78932c0 00000100 00000004 
Call Trace: [<c01075d5>] [<c01077e4>] [<c022ee10>] [<c022ef5c>] [<c021d971>] 
   [<c021fd1e>] [<c021f9fd>] [<c02200a9>] [<c0220267>] [<c0107048>] 
Code: 89 0b ff 48 10 8b 40 08 a8 08 74 0b e8 56 ee ff ff 8d b6 00 

>>EIP; c0115088 <add_wait_queue_exclusive+28/50>   <=====
Trace; c01075d4 <__down+44/e0>
Trace; c01077e4 <__down_failed+8/c>
Trace; c022ee10 <usblp_disconnect+0/c4>
Trace; c022ef5c <.text.lock.printer+88/9c>
Trace; c021d970 <usb_disconnect+90/160>
Trace; c021fd1e <usb_hub_port_connect_change+4e/2c0>
Trace; c021f9fc <usb_hub_port_status+6c/80>
Trace; c02200a8 <usb_hub_events+118/2a0>
Trace; c0220266 <usb_hub_thread+36/90>
Trace; c0107048 <kernel_thread+28/40>
Code;  c0115088 <add_wait_queue_exclusive+28/50>
00000000 <_EIP>:
Code;  c0115088 <add_wait_queue_exclusive+28/50>   <=====
   0:   89 0b                     mov    %ecx,(%ebx)   <=====
Code;  c011508a <add_wait_queue_exclusive+2a/50>
   2:   ff 48 10                  decl   0x10(%eax)
Code;  c011508c <add_wait_queue_exclusive+2c/50>
   5:   8b 40 08                  mov    0x8(%eax),%eax
Code;  c0115090 <add_wait_queue_exclusive+30/50>
   8:   a8 08                     test   $0x8,%al
Code;  c0115092 <add_wait_queue_exclusive+32/50>
   a:   74 0b                     je     17 <_EIP+0x17> c011509e <add_wait_queue_exclusive+3e/50>
Code;  c0115094 <add_wait_queue_exclusive+34/50>
   c:   e8 56 ee ff ff            call   ffffee67 <_EIP+0xffffee67> c0113eee <schedule+24e/250>
Code;  c0115098 <add_wait_queue_exclusive+38/50>
  11:   8d b6 00 00 00 00         lea    0x0(%esi),%esi


3 warnings issued.  Results may not be reliable.

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.5.5-dj2 (root@carthage) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Wed Feb 27 01:08:00 CST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
 BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
zone(0): 4096 pages.
zone(1): 94192 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda6 ro mem=nopentium hdd=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
Detected 899.588 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1795.68 BogoMIPS
Memory: 386348k/393152k available (1564k kernel code, 6416k reserved, 548k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb160, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling broken memory write queue: [55] 89->09
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
NTFS driver v1.1.22 [Flags: R/O]
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.32
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI slot 00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400BB-00AUA1, ATA DISK drive
hdb: CD-ROM Drive/G6D, ATAPI CD/DVD-ROM drive
hdc: CREATIVE DVD-ROM DVD1241E, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG CD-R/RW DRIVE SW-224B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c0373984, I/O limit 4095Mb (mask 0xffffffff)
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
hdb: ATAPI 56X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux Tulip driver version 1.1.11 (Feb 08, 2002)
PCI: Found IRQ 11 for device 00:09.0
IRQ routing conflict for 00:07.5, have irq 9, want irq 11
eth0: ADMtek Comet rev 17 at 0xe800, 00:03:6D:1F:0B:AC, IRQ 11.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SAMSUNG   Model: CD-R/RW SW-224B   Rev: R200
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
usb.c: registered new driver usbfs
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 9 for device 00:07.2
IRQ routing conflict for 00:07.2, have irq 10, want irq 9
IRQ routing conflict for 00:07.3, have irq 10, want irq 9
PCI: Sharing IRQ 9 with 00:0e.0
uhci.c: USB UHCI at I/O 0xd400, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at /
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:07.3
IRQ routing conflict for 00:07.2, have irq 10, want irq 9
IRQ routing conflict for 00:07.3, have irq 10, want irq 9
PCI: Sharing IRQ 9 with 00:0e.0
uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
usb.c: registered new driver usblp
printer.c: v0.10:USB Printer Device Class driver
mice: PS/2 mouse device common for all mice
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
spurious 8259A interrupt: IRQ7.
serio: i8042 AUX port at 0x60,0x64 irq 12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (3071 buckets, 24568 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 289128k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
hub.c: new USB device on bus 1 path /1, assigned address 2
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/46d/c00b/610 NAME=Logitech USB Mouse]
input.c: hotplug returned -2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:1
hid-core.c: ctrl urb status -32 received
hub.c: new USB device on bus 1 path /2, assigned address 3
printer.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0
Creative EMU10K1 PCI Audio Driver, version 0.18, 01:16:25 Feb 27 2002
PCI: Found IRQ 9 for device 00:0e.0
IRQ routing conflict for 00:07.2, have irq 10, want irq 9
IRQ routing conflict for 00:07.3, have irq 10, want irq 9
emu10k1: EMU10K1 rev 8 model 0x8040 found, IO at 0xec00-0xec1f, IRQ 9
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
hub.c: new USB device on bus 2 path /1, assigned address 2
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/45e/1b/a00 NAME=Microsoft SideWinder Force Feedback 2 Joystick]
input.c: hotplug returned -2
input: USB HID v1.00 Joystick [Microsoft SideWinder Force Feedback 2 Joystick] on usb2:1
hid-core.c: ctrl urb status -32 received
FAT: Using codepage default
FAT: Using IO charset default
lp0: compatibility mode
PCI: Found IRQ 9 for device 00:0e.0
IRQ routing conflict for 00:07.2, have irq 10, want irq 9
IRQ routing conflict for 00:07.3, have irq 10, want irq 9
Unable to handle kernel NULL pointer dereference at virtual address 000000cd
 printing eip:
c021caef
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c021caef>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: d78932c0   ecx: d78932dc   edx: c99a2000
esi: 00000000   edi: ccedc440   ebp: ffffffed   esp: c99a3f00
ds: 0018   es: 0018   ss: 0018
Process usb (pid: 4283, threadinfo=c99a2000 task=d1e20700)
Stack: c022e11a d78932dc 000001f0 c030a860 c030b0e0 ccedc440 c021e868 d6bec0c0 
       ccedc440 c99a2000 ccedc440 00000000 d6bec0c0 c013761f d6bec0c0 ccedc440 
       ccedc440 d6bec0c0 00000000 c136e380 c0136051 d6bec0c0 ccedc440 00000000 
Call Trace: [<c022e11a>] [<c021e868>] [<c013761f>] [<c0136051>] [<c0135f62>] 
   [<c0136347>] [<c0108a1f>] 

Code: 8b 80 cc 00 00 00 85 c0 74 17 8b 50 18 85 d2 74 10 8b 44 24 
 <3>input.c: calling hotplug from interrupt
input.c: calling hotplug from interrupt
input: AT Set 2 keyboard on isa0060/serio0
usb.c: USB disconnect on device 3
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0115089
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0115089>]    Not tainted
EFLAGS: 00010006
eax: d7d56000   ebx: 00000000   ecx: d7d57f30   edx: d78932d4
esi: d7d57f28   edi: 00000202   ebp: c13f2c00   esp: d7d57f08
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 9, threadinfo=d7d56000 task=c13f2c00)
Stack: d7d56000 d7d57f28 d78932c8 c01075d5 d78932c0 d78932c8 c030b1e0 00000000 
       00000001 c13f2c00 d78932d4 00000000 c01077e4 d78932c8 d78a01c0 c022ee10 
       c022ef5c c030b1c0 d78931c0 c021d971 d7d4da00 d78932c0 00000100 00000004 
Call Trace: [<c01075d5>] [<c01077e4>] [<c022ee10>] [<c022ef5c>] [<c021d971>] 
   [<c021fd1e>] [<c021f9fd>] [<c02200a9>] [<c0220267>] [<c0107048>] 

Code: 89 0b ff 48 10 8b 40 08 a8 08 74 0b e8 56 ee ff ff 8d b6 00 
 

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-devices.txt"

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=d800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=045e ProdID=001b Rev= a.00
S:  Manufacturer=Microsoft
S:  Product=SideWinder Force Feedback 2 Joystick
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=  1ms
E:  Ad=02(O) Atr=03(Int.) MxPS=  16 Ivl=  4ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=118/900 us (13%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00b Rev= 6.10
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 10ms

--IJpNTDwzlM2Ie8A6--
