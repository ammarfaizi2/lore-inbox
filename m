Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUJOLHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUJOLHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUJOLHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:07:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:3028 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267659AbUJOLHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:07:00 -0400
X-Authenticated: #4399952
Date: Fri, 15 Oct 2004 13:22:36 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041015132236.6b8bd16e@mango.fruits.de>
In-Reply-To: <20041014143131.GA20258@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 16:31:31 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i have released the -U1 PREEMPT_REALTIME patch:
>  
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1

Ok, 

with the help of Paul Davis i think i have found what's causing  the jackd
FP exception. It seems to be a bug in the kernel when PREEMPT_REALTIME is
enabled:

~$ cat /proc/cpuinfo|grep cpu
cpu family      : 6
cpu MHz         : 0.001
cpuid level     : 1

Mhz == 0.001? Hrmm. No wonder jackd was freaking out in its timing code..
The real cpu speed is 1.2ghz.

flo

P.S.: Will retry with U3, to see if this persists.

dmesg output:

Linux version 2.6.9-rc4-mm1-VP-U1-RT (root@mango.fruits.de) (gcc version 3.3.5 (Debian 1:3.3.5-1)) #3 Thu Oct 14 22:40:26 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000030000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
768MB LOWMEM available.
On node 0 totalpages: 196608
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192512 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.9-U0 ro root=1601
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1195.144 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 776332k/786432k available (1673k kernel code, 9644k reserved, 482k data, 340k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2367.48 BogoMIPS (lpj=1183744)
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0183f9ff c1c7f9ff 00000000 00000020
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ksoftirqd started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS18 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
PCI: Using IRQ router SIS [1039/0018] at 0000:00:02.0
PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try pci=usepirqmask
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Initializing Cryptographic API
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: IC35L060AVER07-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST340823A, ATA DISK drive
hdd: TDK CDRW121032, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdc: max request size: 128KiB
hdc: Host Protected Area detected.
	current capacity is 78165360 sectors (40020 MB)
	native  capacity is 78165361 sectors (40020 MB)
hdc: Host Protected Area disabled.
hdc: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63, UDMA(33)
hdc: cache flushes not supported
 hdc: hdc1 hdc2
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
input: PC Speaker
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 37449)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 340k freed
kjournald starting.  Commit interval 5 seconds
Adding 289160k swap on /dev/hda3.  Priority:-1 extents:1
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdc1, internal journal
PCI: Found IRQ 5 for device 0000:00:0f.0
sis900.c: v1.08.07 11/02/2003
PCI: Found IRQ 10 for device 0000:00:03.0
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 10, 00:d0:09:e9:c1:0f.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


complete /proc/cpuinfo

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 0.001
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 2367.48

