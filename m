Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbREVXTE>; Tue, 22 May 2001 19:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262889AbREVXSz>; Tue, 22 May 2001 19:18:55 -0400
Received: from c122070.upc-c.chello.nl ([212.187.122.70]:9476 "EHLO
	c122070.upc-c.chello.nl") by vger.kernel.org with ESMTP
	id <S262888AbREVXSn>; Tue, 22 May 2001 19:18:43 -0400
Message-ID: <3B0B104C.D211EC22@chello.nl>
Date: Wed, 23 May 2001 03:20:12 +0200
From: Harm Verhagen <h.verhagen@chello.nl>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops on booting 2.4.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,                    (cc me, as i'm not on the list)

[1.] One line summary of the problem:
Kernel 2.4.4 oopses during boot

[2.] Full description of the problem/report:
Kernel 2.4.4 oopses during boot on RH 7.1 system, seems when it's
running kudzu or something (maybe I saw it wrong)
After first oops, some more appears and system hangs.
on RH 6.2 2.4.4 with same .config worked fine.
I tried both:  CC  = $(CROSS_COMPILE)kgcc   and CC = $(CROSS_COMPILE)gcc

[3.] Keywords (i.e., modules, networking, kernel):
kernel, oops, boot

[4.] Kernel version:
Linux version 2.4.4

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.4.0 on i686 2.4.2-2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4 (specified)
     -m /boot/System.map-2.4.4 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
May 23 02:46:24 localhost kernel: Unable to handle kernel paging request
at virtual address c88fbb28
May 23 02:46:24 localhost kernel: c02071ad
May 23 02:46:24 localhost kernel: *pde = 01240067
May 23 02:46:24 localhost kernel: Oops: 0000
May 23 02:46:24 localhost kernel: CPU:    0
May 23 02:46:24 localhost kernel: EIP:
0010:[get_pci_dev_info+269/432]
May 23 02:46:24 localhost kernel: EIP:    0010:[<c02071ad>]
Using defaults from ksymoops -t elf32-i386 -a i386
May 23 02:46:24 localhost kernel: EFLAGS: 00010282
May 23 02:46:24 localhost kernel: eax: 00000009   ebx: 0000008e   ecx:
c88fbb20   edx: c02b27e1
May 23 02:46:24 localhost kernel: esi: 000000c4   edi: 00000007   ebp:
c122a000   esp: c7845f40
May 23 02:46:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
May 23 02:46:24 localhost kernel: Process kudzu (pid: 219,
stackpage=c7845000)
May 23 02:46:24 localhost kernel: Stack: c12607e0 00000400 00000400
c73aa000 c122a060 c122a05c c122a058 c88fbb20
May 23 02:46:24 localhost kernel:        000003f1 000003f1 c014ab80
c73aa3f1 c7845f9c 00000000 00000400 ffffffea
May 23 02:46:24 localhost kernel:        c7f43f60 00000400 bffff4b8
c7f2e220 c12607e0 00000000 00000000 c73aa000
May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>]
[proc_file_read+184/464] [sys_read+142/196] [system_call+51/56]
May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>] [<c014ab80>]
[<c012e83e>] [<c0106aeb>]
May 23 02:46:24 localhost kernel: Code: 8b 41 08 50 68 e3 27 2b c0 8b 44
24 34 01 d8 50 e8 02 d3 05

>>EIP; c02071ad <get_pci_dev_info+10d/1b0>   <=====
Trace; c88fbb20 <END_OF_CODE+8598cc8/????>
Trace; c88fbb20 <END_OF_CODE+8598cc8/????>
Trace; c014ab80 <proc_file_read+b8/1d0>
Trace; c012e83e <sys_read+8e/c4>
Trace; c0106aeb <system_call+33/38>
Code;  c02071ad <get_pci_dev_info+10d/1b0>
00000000 <_EIP>:
Code;  c02071ad <get_pci_dev_info+10d/1b0>   <=====
   0:   8b 41 08                  mov    0x8(%ecx),%eax   <=====
Code;  c02071b0 <get_pci_dev_info+110/1b0>
   3:   50                        push   %eax
Code;  c02071b1 <get_pci_dev_info+111/1b0>
   4:   68 e3 27 2b c0            push   $0xc02b27e3
Code;  c02071b6 <get_pci_dev_info+116/1b0>
   9:   8b 44 24 34               mov    0x34(%esp,1),%eax
Code;  c02071ba <get_pci_dev_info+11a/1b0>
   d:   01 d8                     add    %ebx,%eax
Code;  c02071bc <get_pci_dev_info+11c/1b0>
   f:   50                        push   %eax
Code;  c02071bd <get_pci_dev_info+11d/1b0>
  10:   e8 02 d3 05 00            call   5d317 <_EIP+0x5d317> c02644c4
<sprintf+0/1c>


[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux c122070.upc-c.chello.nl 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001
i686 unknow
n

Gnu C                  2.96                                (kgcc
egcs-2.91.66)
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0f
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ppa parport_pc parport autofs 3c59x nls_iso8859-1
nls_cp4
37 vfat fat reiserfs usb-uhci usbcore aic7xxx sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model  : 7
model name : Pentium III (Katmai)
stepping : 3
cpu MHz  : 451.031
cache size : 512 KB
fdiv_bug : no
hlt_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
flags  : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips : 897.84

[8] Bootmessages
May 23 02:46:23 localhost syslogd 1.4-0: restart.
May 23 02:46:23 localhost syslog: syslogd startup succeeded
May 23 02:46:23 localhost kernel: klogd 1.4-0, log source = /proc/kmsg
started.
May 23 02:46:23 localhost kernel: Inspecting /boot/System.map-2.4.4
May 23 02:46:23 localhost syslog: klogd startup succeeded
May 23 02:46:23 localhost modprobe: modprobe: Can't locate module autofs

May 23 02:46:23 localhost identd: identd startup succeeded
May 23 02:46:23 localhost kernel: Loaded 16874 symbols from
/boot/System.map-2.4.4.
May 23 02:46:23 localhost kernel: Symbols match kernel version 2.4.4.
May 23 02:46:23 localhost kernel: Loaded 48 symbols from 3 modules.
May 23 02:46:23 localhost kernel: Linux version 2.4.4
(root@c122070.upc-c.chello.nl) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #5 Wed May 23 02:39:31 CEST 2001
May 23 02:46:23 localhost kernel: BIOS-provided physical RAM map:
May 23 02:46:23 localhost kernel:  BIOS-e820: 0000000000000000 -
000000000009fc00 (usable)
May 23 02:46:23 localhost kernel:  BIOS-e820: 000000000009fc00 -
00000000000a0000 (reserved)
May 23 02:46:23 localhost kernel:  BIOS-e820: 00000000000f0000 -
0000000000100000 (reserved)
May 23 02:46:23 localhost kernel:  BIOS-e820: 0000000000100000 -
0000000007ffc000 (usable)
May 23 02:46:23 localhost kernel:  BIOS-e820: 0000000007ffc000 -
0000000007fff000 (ACPI data)
May 23 02:46:23 localhost kernel:  BIOS-e820: 0000000007fff000 -
0000000008000000 (ACPI NVS)
May 23 02:46:23 localhost kernel:  BIOS-e820: 00000000ffff0000 -
0000000100000000 (reserved)
May 23 02:46:23 localhost kernel: Scan SMP from c0000000 for 1024 bytes.

May 23 02:46:23 localhost kernel: Scan SMP from c009fc00 for 1024 bytes.

May 23 02:46:23 localhost kernel: Scan SMP from c00f0000 for 65536
bytes.
May 23 02:46:23 localhost kernel: Scan SMP from c009fc00 for 4096 bytes.

May 23 02:46:23 localhost kernel: On node 0 totalpages: 32764
May 23 02:46:23 localhost kernel: zone(0): 4096 pages.
May 23 02:46:23 localhost kernel: zone(1): 28668 pages.
May 23 02:46:23 localhost atd: atd startup succeeded
May 23 02:46:23 localhost kernel: zone(2): 0 pages.
May 23 02:46:23 localhost kernel: mapped APIC to ffffe000 (01222000)
May 23 02:46:23 localhost kernel: Kernel command line:
BOOT_IMAGE=linux-2.4.4 ro root=347 BOOT_FILE=/boot/vmlinuz-2.4.4
May 23 02:46:23 localhost kernel: Initializing CPU#0
May 23 02:46:23 localhost kernel: Detected 451.029 MHz processor.
May 23 02:46:23 localhost kernel: Console: colour VGA+ 80x25
May 23 02:46:23 localhost kernel: Calibrating delay loop... 897.84
BogoMIPS
May 23 02:46:23 localhost crond[516]: (CRON) STARTUP (fork ok)
May 23 02:46:23 localhost kernel: Memory: 126012k/131056k available
(1441k kernel code, 4656k reserved, 552k data, 220k init, 0k highmem)
May 23 02:46:23 localhost kernel: Dentry-cache hash table entries: 16384
(order: 5, 131072 bytes)
May 23 02:46:24 localhost kernel: Buffer-cache hash table entries: 4096
(order: 2, 16384 bytes)
May 23 02:46:24 localhost kernel: Page-cache hash table entries: 32768
(order: 5, 131072 bytes)
May 23 02:46:24 localhost kernel: Inode-cache hash table entries: 8192
(order: 4, 65536 bytes)
May 23 02:46:24 localhost kernel: VFS: Diskquotas version dquot_6.4.0
initialized
May 23 02:46:24 localhost kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 23 02:46:24 localhost kernel: CPU: L2 cache: 512K
May 23 02:46:24 localhost kernel: Intel machine check architecture
supported.
May 23 02:46:24 localhost kernel: Intel machine check reporting enabled
on CPU#0.
May 23 02:46:24 localhost kernel: CPU: Intel Pentium III (Katmai)
stepping 03
May 23 02:46:24 localhost kernel: Enabling fast FPU save and restore...
done.
May 23 02:46:24 localhost kernel: Enabling unmasked SIMD FPU exception
support... done.
May 23 02:46:24 localhost kernel: Checking 'hlt' instruction... OK.
May 23 02:46:24 localhost kernel: POSIX conformance testing by UNIFIX
May 23 02:46:24 localhost kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
May 23 02:46:24 localhost kernel: mtrr: detected mtrr type: Intel
May 23 02:46:24 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xf08b0, last bus=1
May 23 02:46:24 localhost kernel: PCI: Using configuration type 1
May 23 02:46:24 localhost kernel: PCI: Probing PCI hardware
May 23 02:46:24 localhost kernel: Unknown bridge resource 0: assuming
transparent
May 23 02:46:24 localhost kernel: PCI: Using IRQ router PIIX [8086/7110]
at 00:04.0
May 23 02:46:24 localhost kernel: Limiting direct PCI/PCI transfers.
May 23 02:46:24 localhost kernel: isapnp: Scanning for PnP cards...
May 23 02:46:24 localhost kernel: isapnp: No Plug & Play device found
May 23 02:46:24 localhost kernel: Linux NET4.0 for Linux 2.4
May 23 02:46:24 localhost kernel: Based upon Swansea University Computer
Society NET3.039
May 23 02:46:24 localhost kernel: Initializing RT netlink socket
May 23 02:46:24 localhost kernel: Starting kswapd v1.8
May 23 02:46:24 localhost kernel: pty: 256 Unix98 ptys configured
May 23 02:46:24 localhost kernel: block: queued sectors max/low
83688kB/27896kB, 256 slots per queue
May 23 02:46:24 localhost kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
May 23 02:46:24 localhost kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
May 23 02:46:24 localhost kernel: PIIX4: IDE controller on PCI bus 00
dev 21
May 23 02:46:24 localhost kernel: PIIX4: chipset revision 1
May 23 02:46:24 localhost kernel: PIIX4: not 100%% native mode: will
probe irqs later
May 23 02:46:24 localhost kernel:     ide0: BM-DMA at 0xd800-0xd807,
BIOS settings: hda:DMA, hdb:DMA
May 23 02:46:24 localhost kernel:     ide1: BM-DMA at 0xd808-0xd80f,
BIOS settings: hdc:DMA, hdd:DMA
May 23 02:46:24 localhost kernel: hda: ST38641A, ATA DISK drive
May 23 02:46:24 localhost kernel: hdb: Maxtor 91741U4, ATA DISK drive
May 23 02:46:24 localhost kernel: hdc: Maxtor 34098H4, ATA DISK drive
May 23 02:46:24 localhost kernel: hdd: CD-ROM 36X/AKU, ATAPI CD/DVD-ROM
drive
May 23 02:46:24 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 23 02:46:24 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
May 23 02:46:24 localhost kernel: hda: 16809660 sectors (8607 MB)
w/128KiB Cache, CHS=1046/255/63, UDMA(33)
May 23 02:46:24 localhost kernel: hdb: 34004880 sectors (17410 MB)
w/512KiB Cache, CHS=2116/255/63, UDMA(33)
May 23 02:46:24 localhost kernel: hdc: 80043264 sectors (40982 MB)
w/2048KiB Cache, CHS=79408/16/63, UDMA(33)
May 23 02:46:24 localhost kernel: hdd: ATAPI 32X CD-ROM drive, 128kB
Cache, UDMA(33)
May 23 02:46:24 localhost kernel: Uniform CD-ROM driver Revision: 3.12
May 23 02:46:24 localhost kernel: Partition check:
May 23 02:46:24 localhost kernel:  hda: hda1 hda2 < hda5 hda6 >
May 23 02:46:24 localhost kernel:  hdb: hdb1 hdb2 hdb4 < hdb5 hdb6 hdb7
hdb8 hdb9 >
May 23 02:46:24 localhost kernel:  hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6
hdc7 >
May 23 02:46:24 localhost kernel: Floppy drive(s): fd0 is 1.44M
May 23 02:46:24 localhost kernel: FDC 0 is a post-1991 82077
May 23 02:46:24 localhost kernel: loop: loaded (max 8 devices)
May 23 02:46:24 localhost kernel: Serial driver version 5.05a
(2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
May 23 02:46:24 localhost kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A

May 23 02:46:24 localhost kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A

May 23 02:46:24 localhost kernel: ttyS03 at 0x02e8 (irq = 3) is a 16550A

May 23 02:46:24 localhost kernel: PPP generic driver version 2.4.1
May 23 02:46:24 localhost kernel: PPP Deflate Compression module
registered
May 23 02:46:24 localhost kernel: Linux agpgart interface v0.99 (c) Jeff
Hartmann
May 23 02:46:24 localhost kernel: agpgart: Maximum main memory to use
for agp memory: 94M
May 23 02:46:24 localhost kernel: [drm] Initialized tdfx 1.0.0 20000928
on minor 63
May 23 02:46:24 localhost kernel: SCSI subsystem driver Revision: 1.00
May 23 02:46:24 localhost kernel: scsi0 : SCSI host adapter emulation
for IDE ATAPI devices
May 23 02:46:24 localhost kernel: usb.c: registered new driver usbdevfs
May 23 02:46:24 localhost kernel: usb.c: registered new driver hub
May 23 02:46:24 localhost kernel: usb-uhci.c: $Revision: 1.259 $ time
01:33:42 May 16 2001
May 23 02:46:24 localhost kernel: usb-uhci.c: High bandwidth mode
enabled
May 23 02:46:24 localhost kernel: PCI: Found IRQ 9 for device 00:04.2
May 23 02:46:24 localhost kernel: PCI: The same IRQ used for device
00:09.0
May 23 02:46:24 localhost kernel: PCI: The same IRQ used for device
00:0d.0
May 23 02:46:24 localhost kernel: usb-uhci.c: USB UHCI at I/O 0xd400,
IRQ 9
May 23 02:46:24 localhost kernel: usb-uhci.c: Detected 2 ports
May 23 02:46:24 localhost kernel: usb.c: new USB bus registered,
assigned bus number 1
May 23 02:46:24 localhost kernel: hub.c: USB hub found
May 23 02:46:24 localhost kernel: hub.c: 2 ports detected
May 23 02:46:24 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May 23 02:46:24 localhost kernel: IP Protocols: ICMP, UDP, TCP
May 23 02:46:24 localhost kernel: IP: routing cache hash table of 512
buckets, 4Kbytes
May 23 02:46:24 localhost kernel: TCP: Hash tables configured
(established 8192 bind 8192)
May 23 02:46:24 localhost kernel: ip_conntrack (1023 buckets, 8184 max)
May 23 02:46:24 localhost kernel: ip_tables: (c)2000 Netfilter core team

May 23 02:46:24 localhost kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
May 23 02:46:24 localhost kernel: VFS: Mounted root (ext2 filesystem)
readonly.
May 23 02:46:24 localhost kernel: Freeing unused kernel memory: 220k
freed
May 23 02:46:24 localhost kernel: hub.c: USB new device connect on
bus1/2, assigned device number 2
May 23 02:46:24 localhost kernel: usb.c: USB device 2 (vend/prod
0x4a9/0x2204) is not claimed by any active driver.
May 23 02:46:24 localhost kernel: Adding Swap: 208804k swap-space
(priority -1)
May 23 02:46:24 localhost kernel: reiserfs: checking transaction log
(device 03:42) ...
May 23 02:46:24 localhost kernel: Using tea hash to sort names
May 23 02:46:24 localhost kernel: reiserfs: using 3.5.x disk format
May 23 02:46:24 localhost kernel: ReiserFS version 3.6.25
May 23 02:46:24 localhost kernel: PCI: Found IRQ 5 for device 00:0a.0
May 23 02:46:24 localhost kernel: ahc_pci:0:10:0: Host Adapter Bios
disabled.  Using default SCSI device parameters
May 23 02:46:24 localhost kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI
SCSI HBA DRIVER, Rev 6.1.5
May 23 02:46:24 localhost kernel:         <Adaptec 2902/04/10/15/20/30C
SCSI adapter>
May 23 02:46:24 localhost kernel:         aic7850: Single Channel A,
SCSI Id=7, 3/255 SCBs
May 23 02:46:24 localhost kernel:
May 23 02:46:24 localhost kernel:   Vendor: PLEXTOR   Model: CD-R
PX-W4220T  Rev: 1.04
May 23 02:46:24 localhost kernel:   Type:
CD-ROM                             ANSI SCSI revision: 02
May 23 02:46:24 localhost kernel: (scsi1:A:4): 10.000MB/s transfers
(10.000MHz, offset 8)
May 23 02:46:24 localhost kernel: scsi : 1 host left.
May 23 02:46:24 localhost kernel: Unable to handle kernel paging request
at virtual address c88fbb28
May 23 02:46:24 localhost kernel:  printing eip:
May 23 02:46:24 localhost kernel: c02071ad
May 23 02:46:24 localhost kernel: *pde = 01240067
May 23 02:46:24 localhost kernel: *pte = 00000000
May 23 02:46:24 localhost kernel: Oops: 0000
May 23 02:46:24 localhost kernel: CPU:    0
May 23 02:46:24 localhost kernel: EIP:
0010:[get_pci_dev_info+269/432]
May 23 02:46:24 localhost kernel: EIP:    0010:[<c02071ad>]
May 23 02:46:24 localhost kernel: EFLAGS: 00010282
May 23 02:46:24 localhost kernel: eax: 00000009   ebx: 0000008e   ecx:
c88fbb20   edx: c02b27e1
May 23 02:46:24 localhost kernel: esi: 000000c4   edi: 00000007   ebp:
c122a000   esp: c7845f40
May 23 02:46:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
May 23 02:46:24 localhost kernel: Process kudzu (pid: 219,
stackpage=c7845000)
May 23 02:46:24 localhost kernel: Stack: c12607e0 00000400 00000400
c73aa000 c122a060 c122a05c c122a058 c88fbb20
May 23 02:46:24 localhost kernel:        000003f1 000003f1 c014ab80
c73aa3f1 c7845f9c 00000000 00000400 ffffffea
May 23 02:46:24 localhost kernel:        c7f43f60 00000400 bffff4b8
c7f2e220 c12607e0 00000000 00000000 c73aa000
May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>]
[proc_file_read+184/464] [sys_read+142/196] [system_call+51/56]
May 23 02:46:24 localhost kernel: Call Trace: [<c88fbb20>] [<c014ab80>]
[<c012e83e>] [<c0106aeb>]
May 23 02:46:24 localhost kernel:
May 23 02:46:24 localhost kernel: Code: 8b 41 08 50 68 e3 27 2b c0 8b 44
24 34 01 d8 50 e8 02 d3 05


Kind regards,
Harm




