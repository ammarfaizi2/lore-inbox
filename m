Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284658AbRLDAVM>; Mon, 3 Dec 2001 19:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284642AbRLDAOc>; Mon, 3 Dec 2001 19:14:32 -0500
Received: from [213.96.224.204] ([213.96.224.204]:55301 "EHLO manty.net")
	by vger.kernel.org with ESMTP id <S284826AbRLCRQz>;
	Mon, 3 Dec 2001 12:16:55 -0500
Date: Mon, 3 Dec 2001 18:16:51 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE pnp interface on a SB16 not working
Message-ID: <20011203171651.GA2149@man.beta.es>
In-Reply-To: <20011203113944.GA1171@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011203113944.GA1171@man.beta.es>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Having seen that I thought of a problem on latest kernels, so I got my old
> IDE pnp device wich comes on a OPL3SA2 card that I have on another machine,
> and I have plugged it on one of the machines I had been using with the SB,
> the IDE port worked ok, so there is no problem with the IDE pnp.

Umm, well, now I'm not so sure about this, I got the card to work under
kernel 2.2.20, it seems to be a problem with 2.4.X. I was gonna test under
2.2 setting the parameters by hand on lilo and adding noprobes using then
isapnptools and then loading the cd driver module, this had resulted ok to
me with other card in non PNP BIOS. It resulted that this was not necesary
as the BIOS was setting up the IDE PNP interface.

So... setting all the IDE stuff on the kernel, not as modules, on 2.2 (no
PNP support at all) worked ok, while setting up a similar 2.4 kernel failed.

I'm including now output from 2.4 kernels and 2.2.20 one in case this puts
any light on this issue:

2.4 Kernel without PNP support with the SB IDE interface initialiced at BIOS:

kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
kernel: VP_IDE: chipset revision 16
kernel: VP_IDE: not 100%% native mode: will probe irqs later
kernel: VP_IDE: VIA vt82c596b IDE UDMA66 controller on pci0:7.1
kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
kernel: hda: SAMSUNG SV1022D, ATA DISK drive
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: hdh: probing with STATUS(0x10) instead of ALTSTATUS(0x90)
kernel: hdh: ATAPI 50X CDROM, ATAPI CDROM drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide3: unexpected interrupt, status=0xff, count=1
kernel: ide3 at 0x168-0x16f,0x36e on irq 10
kernel: hda: 19931184 sectors (10205 MB) w/472KiB Cache, CHS=1240/255/63, UDMA(66)
kernel: hdh: irq timeout: status=0x51 { DriveReady SeekComplete Error }
kernel: hdh: irq timeout: error=0x60
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
last message repeated 2 times
kernel: hdh: ATAPI reset complete
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: ide3: unexpected interrupt, status=0x51, count=2
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: ide3: unexpected interrupt, status=0x51, count=3
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hdh: ATAPI reset complete
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: end_request: I/O error, dev 22:40 (hdh), sector 0
kernel: hdh: ATAPIide3: unexpected interrupt, status=0x51, count=4
kernel:  CD-ROM drive, 0kB Cache
kernel: Uniform CD-ROM driver Revision: 3.12


2.4 Kernel with PNP support and IDE PNP support:

kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
kernel: VP_IDE: chipset revision 16
kernel: VP_IDE: not 100%% native mode: will probe irqs later
kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kernel: VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
kernel: ide3: Creative SB16 PnP IDE interface
kernel: hda: SAMSUNG SV1022D, ATA DISK drive
kernel: hdh: probing with STATUS(0x00) instead of ALTSTATUS(0x80)
kernel: hdh: ATAPI 50X CDROM, ATAPI CD/DVD-ROM drive
kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
kernel: ide3: unexpected interrupt, status=0xff, count=1
kernel: ide3 at 0x168-0x16f,0x36e on irq 10
kernel: hda: 19931184 sectors (10205 MB) w/472KiB Cache, CHS=1240/255/63, UDMA(66)
kernel: hdh: irq timeout: status=0x51 { DriveReady SeekComplete Error }
kernel: hdh: irq timeout: error=0x60
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
last message repeated 2 times
kernel: hdh: ATAPI reset complete
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: ide3: unexpected interrupt, status=0x51, count=2
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: ide3: unexpected interrupt, status=0x51, count=3
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hdh: ATAPI reset complete
kernel: hdh: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: end_request: I/O error, dev 22:40 (hdh), sector 0
kernel: hdh: ATAPI CD-ROMide3: unexpected interrupt, status=0x51, count=4
kernel:  drive, 0kB Cache
kernel: Uniform CD-ROM driver Revision: 3.12


Kernel 2.2.20 without any PNP code:

Dec  3 15:18:49 pul kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
Dec  3 15:18:49 pul kernel: VP_IDE: not 100%% native mode: will probe irqs later
Dec  3 15:18:49 pul kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
Dec  3 15:18:49 pul kernel: ide0: VIA Bus-Master (U)DMA Timing Config Success
Dec  3 15:18:49 pul kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Dec  3 15:18:49 pul kernel: ide1: VIA Bus-Master (U)DMA Timing Config Success
Dec  3 15:18:49 pul kernel: hda: SAMSUNG SV1022D, ATA DISK drive
Dec  3 15:18:49 pul kernel: hdh: probing with STATUS(0x10) instead of ALTSTATUS(0x90)
Dec  3 15:18:49 pul kernel: hdh: ATAPI 50X CDROM, ATAPI CDROM drive
Dec  3 15:18:49 pul kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec  3 15:18:49 pul kernel: ide3 at 0x168-0x16f,0x36e on irq 10
Dec  3 15:18:49 pul kernel: hda: SAMSUNG SV1022D, 9732MB w/472kB Cache, CHS=1240/255/63
Dec  3 15:18:49 pul kernel: hdh: ATAPI 50X CD-ROM drive, 128kB Cache
Dec  3 15:18:49 pul kernel: Uniform CD-ROM driver Revision: 3.11

Well, guess this is all I can offer right now, if you need any tests done,
don't hesitate to contact me.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
