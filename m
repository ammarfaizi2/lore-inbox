Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314031AbSDLObi>; Fri, 12 Apr 2002 10:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314038AbSDLObh>; Fri, 12 Apr 2002 10:31:37 -0400
Received: from 212-100-182-25.adsl.easynet.be ([212.100.182.25]:1478 "HELO
	sumax.dyndns.org") by vger.kernel.org with SMTP id <S314031AbSDLObb>;
	Fri, 12 Apr 2002 10:31:31 -0400
Date: Fri, 12 Apr 2002 16:31:22 +0200
From: Chris Pockele <chrisp@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4 sound crashes and oopses
Message-ID: <20020412163122.A490@freedaemon.home.lan>
Mail-Followup-To: Chris Pockele <chrisp@belgacom.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: FreeBSD 4.5-STABLE i386
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I still have this annoying problem of Linux crashing while playing audio.
I've compiled a 2.4.19-pre6 kernel.
I tried to gather as much info as possible on the crashes ...
thanks in advance for any help.

Short problem description:
Linux kernel 2.4 crashes while playing sound

Full description:
My system seems to crash "randomly" while playing sound (pcm, actually, i use
mpg123 to test). The system has an Avance Logic ALS007 based PnP sound card.
The crashes happen in different ways:
- spontaneous reboot
- hard hang (even SysRq doesn't work anymore)
- the message "spurious 8259A interrupt: IRQ7" followed by a hard hang
- or an Oops message (see further), followed by a DMA timeout error message.
After this, playing audio would always trigger this timeout error message, until
I rebooted.  Sound was broken too.

Oops message:

Unable to handle kernel paging request at virtual address 0521fa5a
 printing eip:
c010bc2a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[enable_8259A_irq+10/48]    Not tainted
EFLAGS: 00010047
eax: fffffffb   ebx: 000000a0   ecx: 00000282   edx: 00000047
esi: c023c9a0   edi: 00000005   ebp: c08effbc   esp: c08eff9c
ds: 0018   es: 0018   ss: 0018
Process sed (pid: 1178, stackpage=c08ef000)
Stack: c010bbd8 00000005 c0109d7c 00000005 400edcd8 400ec860 080587c0 c009ce3
       bffffb2c c01e3668 400edcd8 400ec860 080587c0 400ec860 080587c0 bffffb2
       400ec860 0000002b 0000002b ffffff05 40065a21 00000023 00000246 bffffb0
Call Trace: [end_8259A_irq+24/32] [do_IRQ+140/176]
l:
Code: c0 9c 5a fa 21 05 40 83 21 c0 f6 c1 08 74 09 a0 41 83 21 c0
 kernel:  <4>Sound: DMA (output) timed out - IRQ/DRQ config error?
 kernel: Sound: DMA (output) timed out - IRQ/DRQ config error?
 last message repeated 9 times
 last message repeated 16 times


ksymoops output:

ksymoops 2.4.5 on i486 2.4.19-pre6.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre6/ (default)
     -m /boot/System.map-2.4.19-pre6 (default)

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in vmlinux.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 0521fa5a
c010bc2a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[enable_8259A_irq+10/48]    Not tainted
EFLAGS: 00010047
eax: fffffffb   ebx: 000000a0   ecx: 00000282   edx: 00000047
esi: c023c9a0   edi: 00000005   ebp: c08effbc   esp: c08eff9c
ds: 0018   es: 0018   ss: 0018
Process sed (pid: 1178, stackpage=c08ef000)
Stack: c010bbd8 00000005 c0109d7c 00000005 400edcd8 400ec860 080587c0 c009ce3
       bffffb2c c01e3668 400edcd8 400ec860 080587c0 400ec860 080587c0 bffffb2
       400ec860 0000002b 0000002b ffffff05 40065a21 00000023 00000246 bffffb0
Call Trace: [end_8259A_irq+24/32] [do_IRQ+140/176]
Code: c0 9c 5a fa 21 05 40 83 21 c0 f6 c1 08 74 09 a0 41 83 21 c0
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; fffffffb <END_OF_CODE+3e7f4a3c/????>
>>esi; c023c9a0 <irq_desc+a0/200>
>>ebp; c08effbc <_end+689f44/15a2f88>
>>esp; c08eff9c <_end+689f24/15a2f88>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   c0 9c 5a fa 21 05 40      rcrb   $0x83,0x400521fa(%edx,%ebx,2)
Code;  00000007 Before first symbol
   7:   83 
Code;  00000008 Before first symbol
   8:   21 c0                     and    %eax,%eax
Code;  0000000a Before first symbol
   a:   f6 c1 08                  test   $0x8,%cl
Code;  0000000d Before first symbol
   d:   74 09                     je     18 <_EIP+0x18> 00000018 Before first symbol
Code;  0000000f Before first symbol
   f:   a0 41 83 21 c0            mov    0xc0218341,%al


1 warning issued.  Results may not be reliable.




Installed software:

Linux  2.4.19-pre6 #1 Fri Apr 12 09:00:10 CEST 2002 i486 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10s
mount                  2.10s
modutils               2.4.6
e2fsprogs              1.22
PPP                    2.4.1
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         eth16i


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 4
model		: 3
model name	: 486 DX/2
stepping	: 5
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme
bogomips	: 33.17

loaded modules:
eth16i                  9712   1

/proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0300-031f : eth0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write

/proc/iomem:

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-00ffffff : System RAM
  00100000-001e1a64 : Kernel code
  001e1a65-0022815f : Kernel data

/proc/dma:

 1: SoundBlaster8
 4: cascade

 /proc/interrupts:

           CPU0       
  0:     193015          XT-PIC  timer
  1:      10193          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         61          XT-PIC  serial
  4:       4062          XT-PIC  serial
  5:          0          XT-PIC  soundblaster
 10:      18380          XT-PIC  eth0
 14:      35193          XT-PIC  ide0
NMI:          0 
ERR:          0

Hardware info:
 Intel 486 DX/2 66MHz CPU
 16 MB of RAM
 EtherTeam 16i ISA Ethernet card
 Avance Logic ALS007 Sound card (PnP, the system does not have a PnP BIOS,
  I enabled ISA PnP support in the kernel configuration)

dmesg:

Linux version 2.4.19-pre6 (root@whitelodge) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 Fri Apr 12 09:00:10 CEST 2002
BIOS-provided physical RAM map:
 BIOS-88: 0000000000000000 - 000000000009f000 (usable)
 BIOS-88: 0000000000100000 - 0000000001000000 (usable)
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=306 BOOT_FILE=/boot/vmlinuz-2.4.19-pre6
Initializing CPU#0
Console: colour VGA+ 80x25
Calibrating delay loop... 33.17 BogoMIPS
Memory: 14348k/16384k available (902k kernel code, 1648k reserved, 281k data, 64k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 00000003 00000000 00000000, vendor = 0
CPU: After vendor init, caps: 00000003 00000000 00000000 00000000
CPU:     After generic, caps: 00000003 00000000 00000000 00000000
CPU:             Common caps: 00000003 00000000 00000000 00000000
CPU: Intel 486 DX/2 stepping 05
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
isapnp: Scanning for PnP cards...
isapnp: CMI8330 quirk - fixing interrupts and dma
isapnp: Card 'PnP Sound Chip'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: QUANTUM FIREBALL1080A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 2128896 sectors (1090 MB) w/83KiB Cache, CHS=2112/16/63
Partition check:
 hda: hda1 hda2 hda4 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M, fd1 is 1.44M
FDC 0 is an 8272A
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: PnP Sound Chip detected
sb: ISAPnP reports 'PnP Sound Chip' at i/o 0x220, irq 5, dma 1, -1
<Sound Blaster 16 (ALS-007) (4.02)> at 0x220 irq 5 dma 1
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 64k freed
Adding Swap: 32220k swap-space (priority -1)
eth16i.c: v0.35 01-Jul-1999 Mika Kuoppala (miku@iki.fi)
eth0: ICL EtherTeam 16i/32 at 0x300, IRQ 10, 00:00:4b:19:2c:76 BNC interface.
