Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293465AbSCOXKZ>; Fri, 15 Mar 2002 18:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293466AbSCOXKQ>; Fri, 15 Mar 2002 18:10:16 -0500
Received: from mazu.mazunetworks.com ([4.19.249.110]:15018 "EHLO
	mail.mazunetworks.com") by vger.kernel.org with ESMTP
	id <S293465AbSCOXJ5>; Fri, 15 Mar 2002 18:09:57 -0500
Message-ID: <3C927F3E.7C7FB075@world.std.com>
Date: Fri, 15 Mar 2002 18:09:50 -0500
From: Gordon J Lee <gordonl@world.std.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.18-m1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IBM x360 2.2.x boot failure, 2.4.9 works fine
Content-Type: multipart/mixed;
 boundary="------------68DD9ED1252710408FF951DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------68DD9ED1252710408FF951DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

IBM has a brand new xSeries PC server called the x360.
It has 1-4 Xeon MP's, DDR SDRAM, PCI-X backplane, IBM Summit chipset.
Full specs are here:

http://www.pc.ibm.com/us/eserver/xseries/x360.html

Has anyone tried running Linux on one of these ?
I have tried a few versions and found:

2.2.18    fails in boot
2.2.20    fails in boot
2.2.21rc2 fails in boot
2.4.9     works fine!

I know the hardware is in good shape because a 2.4.9 kernel works
fine on this machine.  I have scoured the IBM site, linux-kernel,
and Google for clues, but to no avail.

The boot sequence failure under the 2.2.x versions that I tried is
always the same, it fails to recognize the IDE and SCSI devices.  From
the messages, the system appears to be deaf to interrupts and so it
cannot recognize its devices.  Notable messages from the boot sequence
that support this idea are:

hda: IRQ probe failed (0)
hda: lost interrupt
floppy0: no floppy controllers found
keyboard: Timeout - AT keyboard not present?
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
lun 0 Test Unit Ready 00 00 00 00 00

Below is the full boot sequence output as best I could reconstruct it.
It is a bit fuzzy because the x360 lacks a serial port (maybe it has
one accessible through the USB, but I don't have a cable).  I pulled
this output together through their ASM remote console redirect feature,
which is less than convenient, leaving me with an error-probe cut and
paste exercise.

Unfortunately I have this machine for a limited eval and must return
it on Monday.  I do hope to get it back ASAP to continue debugging,
but that is at IBM's discretion.

Any suggestions welcome, I will post more as I learn it.

-=-=-=-=-=-=-

LILO boot:
Loading linux-2220...............
Uncompressing Linux... Ok, booting the kernel.

per-CPU timeslice cutoff: 0.00 usecs.
CPU0: Intel                   Intel(R) Xeon(TM) CPU 1.60GHz stepping 01
calibrating APIC timer ...
..... CPU clock speed is 1600.2578 MHz.
..... system bus clock speed is 100.0160 MHz.
Booting processor 4 eip 2000
Calibrating delay loop... 3198.15 BogoMIPS
Intel machine check reporting enabled on CPU#4.
8K L1 data cache
1024K L3 cache
12K L1 instruction cache
8192K L1 instruction cache
CPU: L1 I Cache: 8204K  L1 D Cache: 8K
CPU: L3 Cache: 1024K
CPU:                   Intel(R) Xeon(TM) CPU 1.60GHz
OK.
CPU4: Intel                   Intel(R) Xeon(TM) CPU 1.60GHz stepping 01
Total of 2 processors activated (6389.76 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-0, 14-3, 14-5, 14-11, 14-13, 14-15,
14-18WARNING: ASSIGN_IRQ_VECTOR wrapped back to 52


Linux version 2.2.20 (root@x360-gw.mazunetworks.com) (gcc version
egcs-2.91.66 1
9990314/Linux (egcs-1.1.2 release)) #1 SMP Fri Mar 15 14:12:38 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0009d000 @ 00000000 (usable)
 BIOS-e820: 7efea400 @ 00100000 (usable)
Warning only 960MB will be used.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: NF 6000R SMP APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:1] APIC version 20
Processor #4 Unknown CPU [15:1] APIC version 20
I/O APIC #14 Version 17 at 0xFEC00000.
Processors: 2
WARNING: MP table in the EBDA can be UNSAFE, contact
linux-smp@vger.kernel.org if you experience SMP problems!
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 1600371 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop...

PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01
PCI->APIC IRQ transform: (B0,I2,P0) -> 17
PCI->APIC IRQ transform: (B0,I3,P0) -> 42
PCI->APIC IRQ transform: (B0,I4,P0) -> 41
PCI->APIC IRQ transform: (B0,I15,P0) -> 16
PCI->APIC IRQ transform: (B1,I1,P0) -> 43
PCI->APIC IRQ transform: (B1,I2,P0) -> 24
PCI: BIOS reporting unknown device 0a:00
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Linux IP multicast router 0.06 plus PIM-SM
Initializing RT netlink socket
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
PCI_IDE: unknown IDE controller on PCI bus 00 device 79, VID=1166,
DID=0211
PCI_IDE: not 100% native mode: will probe irqs later
keyboard: Timeout - AT keyboard not present?
ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
ide1: BM-DMA at 0x0708-0x070f, BIOS settings: hdc:pio, hdd:pio
hda: IRQ probe failed (0)
hda: IRQ probe failed (0)
hda: LG CD-ROM CRN-8245B, ATAPI CDROM drive
hda: IRQ probe failed (0)
hdb: IRQ probe failed (0)
hdb: IRQ probe failed (0)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: lost interrupt
hda: lost interrupt
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
sim710: No NCR53C710 adapter found.
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI
0/4/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
NCR53c406a: no available ports found
sym53c416.c: Version 1.0.0
DC390: 0 adapters found
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
scsi : 1 host.
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
lun 0 Test Unit Ready 00 00 00 00 00
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
scsi : 1 host.
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0,
lun 0 Test Unit Ready 00 00 00 00 00





--------------68DD9ED1252710408FF951DB
Content-Type: text/x-vcard; charset=us-ascii;
 name="gordonl.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Gordon J Lee
Content-Disposition: attachment;
 filename="gordonl.vcf"

begin:vcard 
n:Lee;Gordon
tel;fax:(617) 354-9272
tel;home:(617) 576-1779
tel;work:(617) 354-9292 x108
x-mozilla-html:TRUE
url:http://www.mazunetworks.com
org:Mazu Networks
adr:;;50 Cushing Street;Cambridge;MA;02138;USA
version:2.1
email;internet:gordonl@world.std.com
title:Principal Software Engineer
note;quoted-printable:125 Cambridge Park Drive=0D=0ACambridge, MA  02140=0D=0A=0D=0A
x-mozilla-cpt:;0
fn:Gordon Lee
end:vcard

--------------68DD9ED1252710408FF951DB--

