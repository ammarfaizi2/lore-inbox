Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSJLGY5>; Sat, 12 Oct 2002 02:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbSJLGY4>; Sat, 12 Oct 2002 02:24:56 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:25326 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S262813AbSJLGYv>; Sat, 12 Oct 2002 02:24:51 -0400
Date: Fri, 11 Oct 2002 23:30:36 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] pl2303 oops in 2.4.20-pre10 (and 2.5 too)
Message-ID: <20021012063036.GA10921@ip68-4-86-174.oc.oc.cox.net>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com> <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net> <20021011170623.GB4123@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021011170623.GB4123@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 10:06:23AM -0700, Greg KH wrote:
> On Thu, Oct 10, 2002 at 07:39:26PM -0700, Barry K. Nathan wrote:
> > usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
> > usbserial.c: descriptor matches
> > usbserial.c: found bulk out
> > usbserial.c: found bulk in
> > usbserial.c: found interrupt in for Prolific device on separate interface
> > usbserial.c: PL-2303 converter detected
> > usbserial.c: get_free_serial 1
> > usbserial.c: get_free_serial - minor base = 1
> > usbserial.c: usb_serial_probe - setting up 1 port structures for this device
> 
> Ick, I've always suspected the hack I added to support older pl2303
> devices that split the endpoints across different interfaces didn't
> quite work properly, and I think your post proves this.  I _really_
> recommend going and buying a newer device that does not need this hack,
> as Prolific did realize the error of their ways and fix this on newer
> versions.

I'll consider doing this.

FWIW the hack worked fine from 2.4.13pre (and maybe a bit earlier
even) through 2.4.19, and it also works in later 2.2 (haven't tried
2.2.22 yet, but 2.2.22rc1 works).

> This device should work even differently on 2.5 (as I took out this hack
> for now), so you should get a different error, right?

I haven't bothered decoding the oops, or enabling USB serial debug,
under 2.5 at this point.

That reminds me, though, at some point in the 2.5 series my PL-2303 was
getting detected twice. (I'm not sure if this still happens.) Would that
be related? (I think it started oopsing then too, but at that point in
time I had no time to report it.)

> Sorry about this, but please try to return this device and get a
> different one.

I don't think returning it is an option (I don't think it's even under
warranty anymore). It's a couple of years too late to return it to the
place of purchase, certainly.

Of course, if you can't get the driver working again or it's not worth
the effort or whatever, don't worry about it.

> That being said, I should change the driver to not oops in such a
> situation.  Can you try the patch below and let me know if it changes
> anything?

It changes stuff but it still oopses. The dmesg and decoded oops follow.

-Barry K. Nathan <barryn@pobox.com>

---dmesg begins here---
Linux version 2.4.20-pre10 (barryn@ip68-4-86-174.oc.oc.cox.net) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Oct 11 17:36:32 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fe00000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
254MB LOWMEM available.
On node 0 totalpages: 65024
zone(0): 4096 pages.
zone(1): 60928 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=bzimage root=/dev/hda6 vga=0 
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 533.391 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1064.96 BogoMIPS
Memory: 254940k/260096k available (1223k kernel code, 4772k reserved, 418k data, 92k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 533.4035 MHz.
..... host bus clock speed is 66.6753 MHz.
cpu: 0, clocks: 666753, slice: 333376
CPU0<T0:666752,T1:333376,D:0,S:333376,C:666753>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb640, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS620
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SV4084H, ATA DISK drive
hdd: CD-ROM Drive/F5E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02ddfa4, I/O limit 4095Mb (mask 0xffffffff)
hda: setmax LBA 79730784, native  62500000
hda: 62500000 sectors (32000 MB) w/426KiB Cache, CHS=3890/255/63, UDMA(66)
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
PCI: Found IRQ 11 for device 00:0b.0
pcnet32: PCnet/FAST 79C971 at 0xe000, 00 60 b0 fc 62 bb
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow 
    SRAMSIZE=0x7f00, SRAM_BND=0x3f00, assigned IRQ 11.
eth0: registered as PCnet/FAST 79C971
PCI: Found IRQ 10 for device 00:0d.0
pcnet32: PCnet/FAST 79C971 at 0xe400, 00 60 b0 fc 62 40
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow 
    SRAMSIZE=0x7f00, SRAM_BND=0x3f00, assigned IRQ 10.
eth1: registered as PCnet/FAST 79C971
pcnet32: 2 cards_found.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xd0800000, IRQ 12
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver serial
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for PL-2303
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2032 buckets, 16256 max) - 288 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 92k freed
hub.c: new USB device 00:01.2-2, assigned address 2
usbserial.c: descriptor matches
usbserial.c: found interrupt in
usbserial.c: PL-2303 converter detected
usbserial.c: get_free_serial 1
usbserial.c: get_free_serial - minor base = 0
usbserial.c: usb_serial_probe - setting up 1 port structures for this device
usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: descriptor matches
usbserial.c: found bulk out
usbserial.c: found bulk in
usbserial.c: found interrupt in for Prolific device on separate interface
usbserial.c: PL-2303 converter detected
usbserial.c: get_free_serial 1
usbserial.c: get_free_serial - minor base = 1
usbserial.c: usb_serial_probe - setting up 1 port structures for this device
usbserial.c: PL-2303 converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Sorry: masquerading timeouts set 5DAYS/2MINS/60SECS
microcode: CPU0 updated from revision 2 to 3, date=05051999
usbserial.c: serial_open
pl2303.c: pl2303_open -  port 0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x0  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 7b
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x1  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 6
pl2303.c: 0x40:0x1:0x0:0x1  0
pl2303.c: 0x40:0x1:0x1:0xc0  0
pl2303.c: 0x40:0x1:0x2:0x4  0
pl2303.c: pl2303_set_termios -  port 0, initialized = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 0 0 0 0 0 0
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 9600
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_open - submitting interrupt urb
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5415
pl2303.c: pl2303_ioctl (0) cmd = 0x5415
pl2303.c: pl2303_ioctl (0) TIOCMGET
pl2303.c: get_modem_info - result = 6
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5402
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
usbserial.c: serial_set_termios - port 0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_read_int_callback - length = 10, data = a1 20 00 00 00 00 02 00 82 00 
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 230400
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5415
pl2303.c: pl2303_ioctl (0) cmd = 0x5415
pl2303.c: pl2303_ioctl (0) TIOCMGET
pl2303.c: get_modem_info - result = 6
usbserial.c: serial_ioctl - port 0, cmd 0x5418
pl2303.c: pl2303_ioctl (0) cmd = 0x5418
pl2303.c: pl2303_ioctl (0) TIOCMSET/TIOCMBIC/TIOCMSET
pl2303.c: set_control_lines - value = 3, retval = 0
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5402
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
usbserial.c: serial_set_termios - port 0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 230400
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
pl2303.c: 0x40:0x1:0x0:0x41  -32
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5402
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
usbserial.c: serial_set_termios - port 0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: pl2303_set_termios - nothing to change...
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5402
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
usbserial.c: serial_set_termios - port 0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: pl2303_set_termios - nothing to change...
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x540b
pl2303.c: pl2303_ioctl (0) cmd = 0x540b
pl2303.c: pl2303_ioctl not supported = 0x540b
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5402
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
usbserial.c: serial_set_termios - port 0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 0
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
pl2303.c: 0x40:0x1:0x0:0x41  -32
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_ioctl - port 0, cmd 0x5402
pl2303.c: pl2303_ioctl (0) cmd = 0x5402
pl2303.c: pl2303_ioctl not supported = 0x5402
usbserial.c: serial_set_termios - port 0
pl2303.c: pl2303_set_termios -  port 0, initialized = 1
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 230400
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 84 3 0 0 0 8
pl2303.c: 0x40:0x1:0x0:0x41  -32
usbserial.c: serial_ioctl - port 0, cmd 0x5401
pl2303.c: pl2303_ioctl (0) cmd = 0x5401
pl2303.c: pl2303_ioctl not supported = 0x5401
usbserial.c: serial_write - port 0, 1 byte(s)
pl2303.c: pl2303_write - port 0, 1 bytes
Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip:
c01d7eb3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d7eb3>]    Not tainted
EFLAGS: 00010282
eax: 0000002c   ebx: 00000001   ecx: c133941c   edx: 00000000
esi: bffff5ab   edi: 00000001   ebp: cd94bec8   esp: cd94beac
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 111, stackpage=cd94b000)
Stack: c0254240 c0255670 00000000 00000001 c133941c c1339474 c1339400 cd94bef0 
       c01d5a4c c133941c 00000001 bffff5ab 00000001 ffffffea 00000001 bffff5ab 
       cd8cf000 cd94bf40 c017c138 cd8cf000 00000001 bffff5ab 00000001 cd94a000 
Call Trace:    [<c01d5a4c>] [<c017c138>] [<c017a732>] [<c017800d>] [<c017bf50>]
  [<c0136f5c>] [<c0107417>]

Code: 83 7a 18 8d 0f 84 18 01 00 00 8b 4d 08 8b 41 2c 8b 4d 0c 39 
---dmesg ends here---
---decoded oops begins here---
ksymoops 2.4.5 on i686 2.4.19-16mdksmp.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

cpu: 0, clocks: 666753, slice: 333376
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c01d7eb3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01d7eb3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000002c   ebx: 00000001   ecx: c133941c   edx: 00000000
esi: bffff5ab   edi: 00000001   ebp: cd94bec8   esp: cd94beac
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 111, stackpage=cd94b000)
Stack: c0254240 c0255670 00000000 00000001 c133941c c1339474 c1339400 cd94bef0 
       c01d5a4c c133941c 00000001 bffff5ab 00000001 ffffffea 00000001 bffff5ab 
       cd8cf000 cd94bf40 c017c138 cd8cf000 00000001 bffff5ab 00000001 cd94a000 
Call Trace:    [<c01d5a4c>] [<c017c138>] [<c017a732>] [<c017800d>] [<c017bf50>]
  [<c0136f5c>] [<c0107417>]
Code: 83 7a 18 8d 0f 84 18 01 00 00 8b 4d 08 8b 41 2c 8b 4d 0c 39 


>>EIP; c01d7eb3 <pl2303_write+23/1a0>   <=====

>>ecx; c133941c <END_OF_CODE+10553c4/????>
>>esi; bffff5ab Before first symbol
>>ebp; cd94bec8 <END_OF_CODE+d667e70/????>
>>esp; cd94beac <END_OF_CODE+d667e54/????>

Trace; c01d5a4c <serial_write+dc/140>
Trace; c017c138 <write_chan+1e8/210>
Trace; c017a732 <do_tty_write+d2/125>
Trace; c017800d <tty_write+ed/120>
Trace; c017bf50 <write_chan+0/210>
Trace; c0136f5c <sys_write+9c/130>
Trace; c0107417 <system_call+33/38>

Code;  c01d7eb3 <pl2303_write+23/1a0>
00000000 <_EIP>:
Code;  c01d7eb3 <pl2303_write+23/1a0>   <=====
   0:   83 7a 18 8d               cmpl   $0xffffff8d,0x18(%edx)   <=====
Code;  c01d7eb7 <pl2303_write+27/1a0>
   4:   0f 84 18 01 00 00         je     122 <_EIP+0x122> c01d7fd5 <pl2303_write+145/1a0>
Code;  c01d7ebd <pl2303_write+2d/1a0>
   a:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  c01d7ec0 <pl2303_write+30/1a0>
   d:   8b 41 2c                  mov    0x2c(%ecx),%eax
Code;  c01d7ec3 <pl2303_write+33/1a0>
  10:   8b 4d 0c                  mov    0xc(%ebp),%ecx
Code;  c01d7ec6 <pl2303_write+36/1a0>
  13:   39 00                     cmp    %eax,(%eax)
---decoded oops ends here---
