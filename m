Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbRGKPMO>; Wed, 11 Jul 2001 11:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267330AbRGKPMF>; Wed, 11 Jul 2001 11:12:05 -0400
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:57355 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S267329AbRGKPLz>;
	Wed, 11 Jul 2001 11:11:55 -0400
Message-ID: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com>
From: "Richard Purdie" <rpurdie@cableinet.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Date: Wed, 11 Jul 2001 16:11:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

BUG Report: kernel BUG at slab.c:1062!

[2.] Full description of the problem/report:

I'm posting this here as it seems to be a triggering a bug in the VM system
which I believe shouldn't happen in an ideal world. If this isn't the case
(my programming knowledge is limited) then please tell me where the real
problem is. If more info/clarifiation is needed I'm happy to try and debug
this but someone will have to guide me. I'm new to this :)

NOTE: Please cc my mail address (rpurdie@cableinet.co.uk) in any reply.
Thanks.

I'm trying to get Linux to work with an Alcatel Speedtouch ADSL USB modem.
By executing the following script after boot up I get the BUG message after
running pppd.

insmod uhci
/rpsys/etc/dialups/adsl/speedmgmt &
insmod speedtch
insmod pppoatm
/rpsys/etc/dialups/adsl/pppd

I originally tried this under 2.4.5 and the system locked with a opps and
the dreaded interupt handler error usually in swapperd but in other progs
such as syslog-ng as well. While trying to isolate and trace the problem I
was gradually destroying my filesystem from the crashes so I fear some of my
libraries may be broken. I've reinstalled and recomplied some of the system
and the linux sources are intact.

The VM changes in 2.4.6 seem to have stabalised it a bit - the process just
dies instead of the system...

At the end of this message is the complete output from the kernel from
startup in case it helps.

pppd is ppp-2.4.0b2 patched for pppoatm.
The kernel is patched for pppoatm and the speedtouch driver.
System is an Intel Pentium 200 with 64MB ram and 240MB of swapspace. two IDE
drives, no scsi, ISA 3c509 network card and not much else.

I'm also getting errors from pppd:

Jul 12 01:34:40 tim pppd[466]: tdb_store failed: Corrupt database
Jul 12 01:34:40 tim pppd[466]: tdb_store failed: Corrupt database
Jul 12 01:34:44 tim pppd[466]: tdb_store failed: Corrupt database
Jul 12 01:34:44 tim pppd[466]: tdb_store key failed: Corrupt database
Jul 12 01:34:44 tim pppd[466]: tdb_store failed: Corrupt database

I also don't know what's causing these so suggestions are welcome. I suspect
it's a corrupt library but which one?

Other comments I have are:

I've taken out hotplugging support as I thought it may be the porblem as it
used to crash the system.

I was able to lock 2.4.5 up in an infinite loop running gnome and gimp far
too easily. Problems in the VM system again I suspect. No oops message
though. Just a slowdown of the system to an unusable level and continual
harddisk activity. I haven't dared try with 2.4.6 yet...

I'm using syslog-ng and after a few hours of uptime it turns it's output to
some of it's files and /dev/tty12 where it logs everything to complete
garbage. syslogd does the same. Any Ideas?

I'm also not getting logs of kernel oops messages and logged packets on
iptables. They never show up. (But the oops did under dmesg. No idea about
iptables). Any Ideas?


[4.] Kernel version (from /proc/version):

Linux version 2.4.6 (root@tim) (gcc version 2.95.3 20010315 (release)) #1
Wed Ju
l 11 13:12:27 BST 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c0202fd0, System.map says c014af30.  Ignoring ksyms_base entry
Intel Pentium with F0 0F bug - workaround enabled.
kernel BUG at slab.c:1062!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0124d87>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001b   ebx: c11131ec   ecx: c39da000   edx: c02cbf84
esi: 00000202   edi: c11131ec   ebp: 00000007   esp: c0aadd8c
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 264, stackpage=c0aad000)
Stack: c026e4ac c026e548 00000426 c11131ec 00000202 00000007 00000000
00000000
       c0125029 c11131ec 00000007 c15b8800 00000000 00000000 c4857201
00000034
       00000007 c3246000 c3246000 c1f1afc0 c15b8800 00000000 00000000
00000005
Call Trace: [<c0125029>] [<c014e32c>] [<c026089a>] [<c02557e4>] [<c025584a>]
[<c0255909>] [<c02559ae>]
       [<c0253e76>] [<c0253e90>] [<c020e837>] [<c025731a>] [<c020ebe1>]
[<c020ebf0>] [<c020f154>] [<c0106ce3>]
Code: 0f 0b 83 c4 0c 8d 74 26 00 f7 c5 00 10 00 00 0f 85 c4 01 00

>>EIP; c0124d87 <kmem_cache_grow+2b/20c>   <=====
Trace; c0125029 <kmalloc+6d/88>
Trace; c014e32c <ext2_alloc_block+78/80>
Trace; c026089a <vsprintf+31e/34c>
Trace; c02557e4 <atm_do_connect_dev+140/178>
Trace; c025584a <atm_do_connect+2e/34>
Trace; c0255909 <atm_connect_vcc+b9/114>
Trace; c02559ae <atm_connect+4a/70>
Trace; c0253e76 <pvc_bind+82/88>
Trace; c0253e90 <pvc_connect+14/18>
Trace; c020e837 <sys_connect+5b/78>
Trace; c025731a <atm_setsockopt+42/48>
Trace; c020ebe1 <sys_setsockopt+65/80>
Trace; c020ebf0 <sys_setsockopt+74/80>
Trace; c020f154 <sys_socketcall+8c/200>
Trace; c0106ce3 <system_call+33/40>
Code;  c0124d87 <kmem_cache_grow+2b/20c>
0000000000000000 <_EIP>:
Code;  c0124d87 <kmem_cache_grow+2b/20c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0124d89 <kmem_cache_grow+2d/20c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0124d8c <kmem_cache_grow+30/20c>
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c0124d90 <kmem_cache_grow+34/20c>
   9:   f7 c5 00 10 00 00         test   $0x1000,%ebp
Code;  c0124d96 <kmem_cache_grow+3a/20c>
   f:   0f 85 c4 01 00 00         jne    1d9 <_EIP+0x1d9> c0124f60
<kmem_cache_grow+204/20c>

2 warnings issued.  Results may not be reliable.

[7.1.] Software (add the output of the ver_linux script here)

Output of the ver_linux:

Linux tim 2.4.6 #1 Wed Jul 11 13:12:27 BST 2001 i586 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.22
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules  pppoatm speedtch uhci nfsd ppp_deflate ppp_async ppp_generic

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 200.457
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76

[7.3.] Module information (from /proc/modules):

pppoatm                 2704   0 (unused)
speedtch               11056   3
uhci                   22800   0 (unused)
nfsd                   67984   8
ppp_deflate            39648   0
ppp_async               6480   1
ppp_generic            18544   3 [pppoatm ppp_deflate ppp_async]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
02e8-02ef : serial(auto)
02f8-02ff : serial(auto)
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5f00-5f1f : Intel Corporation 82371AB PIIX4 ACPI
6100-613f : Intel Corporation 82371AB PIIX4 ACPI
6400-641f : Intel Corporation 82371AB PIIX4 USB
  6400-641f : usb-uhci
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-00265cfd : Kernel code
  00265cfe-002e481f : Kernel data
e0000000-e3ffffff : S3 Inc. ViRGE/DX or /GX
ffff0000-ffffffff : reserved

Total kernel messages from startup:

Linux version 2.4.6 (root@tim) (gcc version 2.95.3 20010315 (release)) #1
Wed Jul 11 13:12:27 BST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Lin ro root=302
Initializing CPU#0
Detected 200.457 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 399.76 BogoMIPS
Memory: 61596k/65536k available (1431k kernel code, 3552k reserved, 506k
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xfb410, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.106 (20010617) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 512 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with HUB-6 MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
block: queued sectors max/low 40813kB/13604kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 7777K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 84320D4, ATA DISK drive
hdc: FUJITSU MPA3052AT, ATA DISK drive
hdd: F HO P.1 0, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 8439184 sectors (4321 MB) w/256KiB Cache, CHS=525/255/63, UDMA(33)
hdc: 10253928 sectors (5250 MB), CHS=10850/15/63, DMA
hdd: ATAPI 2X CD-ROM drive, 240kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p4
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [638/255/63] p1 p2 p3 p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
eth0: 3c5x9 at 0x300, 10baseT port, address  00 a0 24 27 f3 15, IRQ 10.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
loop: loaded (max 8 devices)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver acm
acm.c: v0.18:USB Abstract Control Model driver for USB modems and ISDN
adapters
md: linear personality registered
md: raid0 personality registered
md: raid1 personality registered
md: raid5 personality registered
raid5: measuring checksumming speed
   8regs     :   221.600 MB/sec
   32regs    :   218.800 MB/sec
   pII_mmx   :   308.400 MB/sec
   p5_mmx    :   366.000 MB/sec
raid5: using function: p5_mmx (366.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
lec.c: Jul 11 2001 13:31:34 initialized
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
eth0: Setting Rx mode to 1 addresses.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Adding Swap: 88352k swap-space (priority -1)
Adding Swap: 160640k swap-space (priority -2)
uhci.c: USB UHCI at I/O 0x6400, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: :USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x6b9/0x4061) is not claimed by any active
driver.
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 512 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 2 rqt 192 rq 18 len 0 ret -110
usb.c: registered new driver Alcatel SpeedTouch USB
atm_connect (TX: cl 1,bw 0-0,sdu 16386; RX: cl 1,bw 0-0,sdu 1502,AAL 5)
kernel BUG at slab.c:1062!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0124d87>]
EFLAGS: 00010286
eax: 0000001b   ebx: c11131ec   ecx: c39da000   edx: c02cbf84
esi: 00000202   edi: c11131ec   ebp: 00000007   esp: c0aadd8c
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 264, stackpage=c0aad000)
Stack: c026e4ac c026e548 00000426 c11131ec 00000202 00000007 00000000
00000000
       c0125029 c11131ec 00000007 c15b8800 00000000 00000000 c4857201
00000034
       00000007 c3246000 c3246000 c1f1afc0 c15b8800 00000000 00000000
00000005
Call Trace: [<c0125029>] [<c014e32c>] [<c026089a>] [<c02557e4>] [<c025584a>]
[<c0255909>] [<c02559ae>]
       [<c0253e76>] [<c0253e90>] [<c020e837>] [<c025731a>] [<c020ebe1>]
[<c020ebf0>] [<c020f154>] [<c0106ce3>]

Code: 0f 0b 83 c4 0c 8d 74 26 00 f7 c5 00 10 00 00 0f 85 c4 01 00


