Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261588AbSJAL6Z>; Tue, 1 Oct 2002 07:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261589AbSJAL6Z>; Tue, 1 Oct 2002 07:58:25 -0400
Received: from mail.internet-factory.de ([62.134.147.34]:32414 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S261588AbSJAL6X>; Tue, 1 Oct 2002 07:58:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <holger@lubitz.org>
Newsgroups: lists.linux.kernel
Subject: PIIX4 problem
Date: Tue, 01 Oct 2002 14:03:51 +0200
Organization: Internet Factory AG
Message-ID: <3D998F27.2090403@lubitz.org>
NNTP-Posting-Host: gatekeeper.webserv-it.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1033473829 24538 62.134.144.10 (1 Oct 2002 12:03:49 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 1 Oct 2002 12:03:49 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the following weird problem with a BX-based Board (Asus P3B-F, P3 
500 MHz (Katmai) Intel BX with PIIX4, latest BIOS 1008-004):

Kernel 2.2 (Debian Woody) works.
Kernel 2.4 (Redhat 7.3, 8.0) doesn't work.
Selfcompiled 2.4.19, 2.4.20-pre8: only work if I do _not_ compile PIIX4 
support in.

dmesg on successful boot with selfcompiled 2.4.20-pre8 without PIIX support:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: detected chipset, but driver not compiled in!
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: LTN526, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c02d69e4, I/O limit 4095Mb (mask 0xffffffff)
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=4866/255/63, (U)DMA
hdb: ATAPI 52X CD-ROM drive, 120kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >

Apart from the warning about the driver not being compiled in everything 
runs fine. hdparm -I even tells me that both drives are running in UDMA 
mode.

This is the dmesg output for an unsuccessful boot with RedHat 8.0 
(written down by hand, excuse the errors). Unsuccessful boots with 
selfcompiled kernels with PIIX support look nearly identical except for 
the blk: lines.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: detected chipset, but driver not compiled in!
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: LTN526, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
blk: queue c02e7ce4, I/O limit 4095Mb (mask 0xffffffff)
hda: set_drive_speed_status: status = 0xff { Busy }
blk: queue c02e7ce4, I/O limit 4095Mb (mask 0xffffffff)
hda: status timeout
hda: drive not ready for command
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=4866/255/63, (U)DMA
hda: status timeout: status = 0xff { Busy }
hda: drive not ready for command
hdb: status timeout: status = 0xff { Busy }
hdb: drive not ready for command
hdb: ATAPI reset timed-out, status: 0xff
hda: DMA disabled
ide0: reset timed-out, status = 0xff
hdb: status timeout: status = 0xff { Busy }
hdb: drive not ready for command
hdb: ATAPI reset timed-out, status = 0xff
ide0: reset timed-out, status = 0xff
end_request: I/O-error dev 0b:40 (hdb) sector 0
hdb: ATAPI CD-ROM drive, 0kB Cache

I tried all combinations of nodma,notune,noautotune (is it notune or 
noautotune? conflicting documentation there...) for both ide0 and ide1 
and even for individual drives (hdb=nodma etc.), the kernel ignored me. 
Even disabling DMA in the BIOS still gave me

PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio

Again - the strange thing is that it works just fine if I leave out 
PIIX4 support and select only generic PCI busmaster DMA support. 
However, I cannot use distribution kernels which have PIIX compiled in.

Is there a boot option to disable PIIX support?

Thanks for any help,
Holger

