Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSIHR6M>; Sun, 8 Sep 2002 13:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSIHR6M>; Sun, 8 Sep 2002 13:58:12 -0400
Received: from pieck.student.uva.nl ([146.50.96.22]:8914 "EHLO
	pieck.student.uva.nl") by vger.kernel.org with ESMTP
	id <S293680AbSIHR6K>; Sun, 8 Sep 2002 13:58:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Alan Cox <alan@redhat.com>, alexh@ihatent.com (Alexander Hoogerhuis)
Subject: Re: Linux 2.4.20-pre5-ac4
Date: Sun, 8 Sep 2002 20:02:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: alan@redhat.com (Alan Cox), bunk@fs.tum.de (Adrian Bunk),
       hpj@urpla.net (Hans-Peter Jansen), linux-kernel@vger.kernel.org
References: <200209081710.g88HApt05576@devserv.devel.redhat.com>
In-Reply-To: <200209081710.g88HApt05576@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020908175810Z293680-685+44886@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 September 2002 19:10, Alan Cox wrote:
> > Bog standard (sic) rawhide, so here we go (still havent rebooted to
> > the untainted kernel yet):
> 
> Ok same compiler. So its something on the ide-cd/ide-scsi side I don't
> trip. Curiouser and curiouser

it happened to me, different compiler different system, different cause

after loading (using modprobe) sr_mod, ide-scsi and sg in that order I tried 
to mount a cdrom but this resulted in a Segmentation Fault and a kernel oops.

Oops and system info below

	Rudmer

ksymoops 2.4.3 on i686 2.4.20-pre5-ac3.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-pre5-ac3/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
kernel BUG at 
/home/rudmer/src/kernel/linux-2.4.20-pre5-ac4/include/linux/blkdev.h:153!
invalid operand: 0000
CPU:    0
EIP:    0010:[ide_build_sglist+76/400]    Not tainted
EFLAGS: 00010206
eax: 0000005a   ebx: c1363000   ecx: c02e04d4   edx: c9823840
esi: 00000000   edi: c9823840   ebp: c9820800   esp: c7aa7c34
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 499, stackpage=c7aa7000)
Stack: c1363000 c02e0584 c9823840 c9820800 d1b75a9d c02e0584 000000a0 c1360000
       c01c889b c02e04d4 c9823840 c02e04d4 c02e0584 c9823840 c9820800 00000000
       00000000 c02e04d4 c01c8d69 c02e0584 c9823840 c02e0584 c02e0584 c869e840
Call Trace:    [<d1b75a9d>] [ide_build_dmatable+91/416] 
[__ide_dma_read+41/288] [<d1b75963>] [<d1b75acb>]
  [<d1b666b0>] [<d1b67ed1>] [<d1b73400>] [generic_unplug_device+32/48] 
[__run_task_queue+76/96] [__wait_on_buffer+86/144]
  [<d1b940a8>] [do_add_mount+105/320] [do_mount+338/368] 
[copy_mount_options+77/160] [sys_mount+132/208] [system_call+51/56]
Code: 0f 0b 99 00 e0 75 24 c0 8b 44 24 24 c7 80 24 04 00 00 01 00
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d1b75a9c <END_OF_CODE+1188fcc8/????>
Trace; d1b666b0 <END_OF_CODE+118808dc/????>
Trace; d1b67ed0 <END_OF_CODE+118820fc/????>
Trace; d1b73400 <END_OF_CODE+1188d62c/????>
Trace; d1b940a8 <END_OF_CODE+118ae2d4/????>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   99                        cltd
Code;  00000002 Before first symbol
   3:   00 e0                     add    %ah,%al
Code;  00000004 Before first symbol
   5:   75 24                     jne    2b <_EIP+0x2b> 0000002a Before first 
symbol
Code;  00000006 Before first symbol
   7:   c0 8b 44 24 24 c7 80      rorb   $0x80,0xc7242444(%ebx)
Code;  0000000e Before first symbol
   e:   24 04                     and    $0x4,%al
Code;  00000010 Before first symbol
  10:   00 00                     add    %al,(%eax)
Code;  00000012 Before first symbol
  12:   01 00                     add    %eax,(%eax)

ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux gandalf 2.4.20-pre5-ac3 #1 Sun Sep 8 15:42:17 CEST 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11q
mount                  2.11q
modutils               2.4.16
e2fsprogs              1.27
reiserfsprogs          3.x.1b
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded

output after loading scsi modules:
  Vendor: IOMEGA    Model: ZIP 100           Rev: 23.D
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: HL-DT-ST  Model: CD-RW GCE-8240B   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 24x/40x writer cd/rw xa/form2 cdda tray

relevant part of dmesg:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS735    ATA 100 controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
blk: queue c02e0120, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-ST CD-RW GCE-8240B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdd: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 40132503 sectors (20548 MB) w/1902KiB Cache, CHS=2498/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >

lspci:
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 
(rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940
00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:11.0 Ethernet controller: Winbond Electronics Corp W89C940
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)
