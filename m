Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135731AbRDXTxn>; Tue, 24 Apr 2001 15:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135730AbRDXTxd>; Tue, 24 Apr 2001 15:53:33 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:4614 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S135728AbRDXTx2>; Tue, 24 Apr 2001 15:53:28 -0400
X-Server-Uuid: 7edb479a-fd89-11d2-9a77-0090273cd58c
Message-ID: <3AE5D9AA.4A743730@sandia.gov>
Date: Tue, 24 Apr 2001 13:53:14 -0600
From: "Jim Schutt" <jaschut@sandia.gov>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Spurious interrupts for UP w/ IO-APIC on ServerWorks
X-Filter-Version: 1.3 (sass165)
X-WSS-ID: 16FB0626771381-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've got a dual-processor system built around the Intel SBT2 motherboard,
which uses the ServerWorks LE chipset.  2.4.3 SMP works fine.  When I 
build a UP kernel with IO-APIC support, I get this during boot:

[... everything seems ok until ...]
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0840-0x0847, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x0848-0x084f, BIOS settings: hdc:DMA, hdd:DMA
spurious APIC interrupt on CPU#0, should never happen.
spurious APIC interrupt on CPU#0, should never happen.
hda: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
spurious APIC interrupt on CPU#0, should never happen.
spurious APIC interrupt on CPU#0, should never happen.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
spurious APIC interrupt on CPU#0, should never happen.
spurious APIC interrupt on CPU#0, should never happen.
hda: lost interrupt
spurious APIC interrupt on CPU#0, should never happen.
hda: lost interrupt
hda: ATAPI 52X CD-ROM drive, 192kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
spurious APIC interrupt on CPU#0, should never happen.
spurious APIC interrupt on CPU#0, should never happen.
floppy0: no floppy controllers found
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/4/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/4/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0
Inquiry 00 00 00 ff 00 
spurious APIC interrupt on CPU#0, should never happen.
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
spurious APIC interrupt on CPU#0, should never happen.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
[... repeat above 6 lines until I reset hw ...]


2.4.3 has this behavior, 2.4.3-ac9 works fine. I found this in the -ac
changelog; perhaps it's relevant:

> 2.4.2-ac12 
[...]
> o Remove serverworks handling. The BIOS is our (me) 
>         best (and right now only) hope for that chip 

Here's the pertinent (I think) part of 2.4.3 .config:

CONFIG_MPENTIUMIII=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_SMP is not set
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

Details available on request.

Thanks -- Jim

-- 
Jim Schutt  <jaschut@sandia.gov>
Sandia National Laboratories, Albuquerque, New Mexico USA

