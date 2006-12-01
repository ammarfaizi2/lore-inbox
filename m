Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759141AbWLAGXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759141AbWLAGXq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759145AbWLAGXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:23:46 -0500
Received: from woodstock.cruzers.com ([209.165.193.12]:50194 "EHLO
	woodstock.cruzers.com") by vger.kernel.org with ESMTP
	id S1759141AbWLAGXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:23:46 -0500
Message-ID: <456FCA68.9010502@cruzers.com>
Date: Thu, 30 Nov 2006 22:23:36 -0800
From: ron moncreiff <rmoncreiff@cruzers.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: trying pata_ali in 2.6.19
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// I have tried out the new pata options in the 2.6.19 kernel and had
some problems. //
// So here's the skinny. I am using the asrock 939dual - sataII mobo.
lspci -vxxx reports //
// the IDE interface thus: //

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a 
[Master SecP PriP])
         Subsystem: ASRock Incorporation ASRock 939Dual-SATA2 
Motherboard IDE (PATA)
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 20
         I/O ports at <ignored>
         I/O ports at <ignored>
         I/O ports at <ignored>
         I/O ports at <ignored>
         I/O ports at ff00 [size=16]
00: b9 10 29 52 05 00 a0 02 c7 8a 01 01 00 20 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
40: 80 00 00 7a 4d 10 00 c0 00 80 64 c9 00 00 ba 1a
50: 00 00 00 03 05 55 8f 44 01 31 31 31 00 00 00 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 01 00 01 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

// It works fine under the old regime //
// Here's what hdparm -i /dev/hda returns: //

/dev/hda:

Model=ST380011A, FwRev=8.01, SerialNo=5JVQHHJ9
Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes:  pio0 pio1 pio2 pio3 pio4
DMA modes:  mdma0 mdma1 mdma2
UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
AdvancedPM=no WriteCache=enabled
Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-1
ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6

* signifies the current active mode

// and /dev/hdb: //

/dev/hdb:

Model=PIONEER DVD-RW DVR-108, FwRev=1.10, SerialNo=
Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
BuffType=13395, BuffSize=64kB, MaxMultSect=0
(maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes:  pio0 pio1 pio2 pio3 pio4
DMA modes:  mdma0 mdma1 mdma2
UDMA modes: udma0 udma1 udma2 udma3 *udma4
AdvancedPM=no
Drive conforms to: Unspecified:  ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4
ATA/ATAPI-5

* signifies the current active mode

// Here's what happens on the command line when I modprobe the module
and then lsmod. //

frontman ata # modprobe -v pata_ali
insmod /lib/modules/2.6.19-gentoo/kernel/drivers/ata/pata_ali.ko
Segmentation fault
frontman ata # lsmod
Module                  Size  Used by
pata_ali                7714  1
snd_seq_midi            6048  0
rtc                     9972  0
snd_ens1371            18752  0
snd_rawmidi            17824  2 snd_seq_midi,snd_ens1371
snd_ac97_codec         90084  1 snd_ens1371
snd_ac97_bus            1856  1 snd_ac97_codec
k8temp                  4352  0

// here's the tail end of dmesg after the modprobe //

BUG: unable to handle kernel NULL pointer dereference at virtual address
00000020
printing eip:
f8ba0823
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: pata_ali snd_seq_midi rtc snd_ens1371 snd_rawmidi
snd_ac97_codec snd_ac97_bus k8temp
CPU:    0
EIP:    0060:[<f8ba0823>]    Not tainted VLI
EFLAGS: 00010246   (2.6.19-gentoo #5)
EIP is at ali_init_one+0x1ba/0x2f7 [pata_ali]
eax: ef47fe1a   ebx: 00000000   ecx: f7cb84b0   edx: 00000001
esi: f7cbcc00   edi: f7cb8400   ebp: f6f5f9a0   esp: ef47fe08
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4770, ti=ef47e000 task=f1a25a70 task.ti=ef47e000)
Stack: 000010b9 00001533 00000079 ef47fe1a c7c11734 f8ba1734 f8ba1700
f7cbcc00
       c024b556 f7cbcc00 f8ba09bc f7cbcc48 f7cbcc48 f8ba1734 c02a9dce
f7cbcc48
       c17df0c0 000000d0 c036d1de f7cbcc48 ef47fe84 c02a9fa1 f8ba1734
c02a9fef
Call Trace:
[<c024b556>] pci_device_probe+0x44/0x68
[<c02a9dce>] really_probe+0x3c/0xe4
[<c036d1de>] klist_next+0x57/0x95
[<c02a9fa1>] __driver_attach+0x0/0x81
[<c02a9fef>] __driver_attach+0x4e/0x81
[<c02a93b6>] bus_for_each_dev+0x51/0x78
[<c02a9cd8>] driver_attach+0x26/0x2a
[<c02a9fa1>] __driver_attach+0x0/0x81
[<c02a9739>] bus_add_driver+0x66/0x18d
[<c02aa1f3>] driver_register+0x80/0x8d
[<c024b6ec>] __pci_register_driver+0x63/0x86
[<f8ba3017>] ali_init+0x17/0x1a [pata_ali]
[<c012f670>] sys_init_module+0x1471/0x1628
[<c0102a69>] sysenter_past_esp+0x56/0x79
=======================
Code: 00 c7 04 24 b9 10 00 00 e8 06 b4 6a c7 85 ff 89 c3 74 64 66 81 7f
24 b9 10 75 5c 8d 44 24 12 c7 44 24 08 79 00 00 00 89 44 24 0c <8b> 43
20 89 44 24 04 8b 43 10 89 04 24 e8 b1 63 6a c7 80 7c 24
EIP: [<f8ba0823>] ali_init_one+0x1ba/0x2f7 [pata_ali] SS:ESP 0068:ef47fe08

// Just for yuks I took a look at the pata_ali.c code at //
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=1d695df5860a3ac44fc77476847d88f50927d7fb;f=drivers/ata/pata_ali.c 

//
// and noticed that starting at line 510 there are a bunch of "static
struct ata_port_info info_20" like structure //
// declarations (definitions ?) that seem to reference various revisions
of the chip. Mine is a c7 and there's no //
// structure for that one. Could this be the problem?

TIA, Ron
rmoncreiff@cruzers.com


