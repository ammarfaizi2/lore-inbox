Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280299AbRKIXra>; Fri, 9 Nov 2001 18:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280320AbRKIXrV>; Fri, 9 Nov 2001 18:47:21 -0500
Received: from pdbn-3e36a8eb.pool.mediaWays.net ([62.54.168.235]:25100 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S280299AbRKIXrJ>;
	Fri, 9 Nov 2001 18:47:09 -0500
Date: Sat, 10 Nov 2001 00:45:59 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Erik Andersen <andersen@codepoet.org>,
        Rik van Riel <riel@conectiva.com.br>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
Message-ID: <20011110004559.A30789@citd.de>
In-Reply-To: <20011109155309.A14308@codepoet.org> <Pine.LNX.4.33L.0111092056160.2963-100000@imladris.surriel.com> <20011109162028.A14567@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20011109162028.A14567@codepoet.org>; from andersen@codepoet.org on Fri, Nov 09, 2001 at 04:20:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:20:28PM -0700, Erik Andersen wrote:
> On Fri Nov 09, 2001 at 08:57:07PM -0200, Rik van Riel wrote:
> > >
> > > But wouldn't it make more sense to enable DMA by default, except
> > > for a set of blacklisted chipsets, rather then disabling it for
> > > everybody just because some older chipsets are crap?
> > 
> > The kernel does this, but only if CONFIG_IDEDMA_AUTO
> > is enabled ...
> 
> That seems to be the theory.  In practice every system in my house has 
> that option enabled and yet only some controllers boot up with DMA enabled...
> 
> For example lets look at the following case.  This system has
> an intel chipset builtin and a Promise PCI card.
> 
>     Uniform Multi-Platform E-IDE driver Revision: 6.31
>     ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>     PIIX4: IDE controller on PCI bus 00 dev 39
>     PIIX4: chipset revision 1
>     PIIX4: not 100% native mode: will probe irqs later
> 	ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> 	ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>     PDC20267: IDE controller on PCI bus 00 dev 68
>     PCI: Found IRQ 5 for device 00:0d.0
>     PDC20267: chipset revision 2
>     PDC20267: not 100% native mode: will probe irqs later
> 	ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:DMA
> 	ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA
>     hda: IBM-DPTA-373420, ATA DISK drive
>     hdd: PCRW804, ATAPI CD/DVD-ROM drive
>     hde: IBM-DTLA-307045, ATA DISK drive
>     hdg: IBM-DTLA-307045, ATA DISK drive
>     ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>     ide1 at 0x170-0x177,0x376 on irq 15
>     ide2 at 0xac00-0xac07,0xb002 on irq 5
>     ide3 at 0xb400-0xb407,0xb802 on irq 5
>     hda: 66055248 sectors (33820 MB) w/1961KiB Cache, CHS=4111/255/63, UDMA(33)
>     hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
>     hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
>     Partition check:
>      hda: hda1 hda2
>      hde: hde1
>      hdg: hdg1
> 
> So the Intel one came up with DMA enabled,  No problem there.
> 
> The Promise controller has two identical 46.1GB IBM-DTLA-307045 7200
> rpm hard drives on it.  The controller is capable of ATA100.  The hard
> drives are capable of ATA100.  And yet even with CONFIG_IDEDMA_AUTO
> set, these drives both come up running 3.39 MB/s.  

Here all drives "default" to UDMA:
(Kernel is 2.4.9 vanilla)
Second Controller is an Promise Ultra 100 TX2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
PDC20268: IDE controller on PCI bus 02 dev 08
PDC20268: chipset revision 1
PDC20268: not 100%% native mode: will probe irqs later
PDC20268: ROM enabled at 0xfebf8000
PDC20268: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary MASTER Mode.
    ide2: BM-DMA at 0xef90-0xef97, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xef98-0xef9f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTTA-351010, ATA DISK drive
hde: IBM-DTLA-307045, ATA DISK drive
hdf: IBM-DTLA-307045, ATA DISK drive
hdg: WDC WD1000BB-32CCB0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xefe0-0xefe7,0xefae on irq 24
ide3 at 0xefa0-0xefa7,0xefaa on irq 24
hda: 19807200 sectors (10141 MB) w/466KiB Cache, CHS=1232/255/63, UDMA(33)
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdf: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hdg: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=193821/16/63, UDMA(100)








Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

