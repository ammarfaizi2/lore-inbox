Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280290AbRKIXU5>; Fri, 9 Nov 2001 18:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280289AbRKIXUi>; Fri, 9 Nov 2001 18:20:38 -0500
Received: from codepoet.org ([166.70.14.212]:43309 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280288AbRKIXU1>;
	Fri, 9 Nov 2001 18:20:27 -0500
Date: Fri, 9 Nov 2001 16:20:28 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
Message-ID: <20011109162028.A14567@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011109155309.A14308@codepoet.org> <Pine.LNX.4.33L.0111092056160.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111092056160.2963-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 09, 2001 at 08:57:07PM -0200, Rik van Riel wrote:
> >
> > But wouldn't it make more sense to enable DMA by default, except
> > for a set of blacklisted chipsets, rather then disabling it for
> > everybody just because some older chipsets are crap?
> 
> The kernel does this, but only if CONFIG_IDEDMA_AUTO
> is enabled ...

That seems to be the theory.  In practice every system in my house has 
that option enabled and yet only some controllers boot up with DMA enabled...

For example lets look at the following case.  This system has
an intel chipset builtin and a Promise PCI card.

    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    PIIX4: IDE controller on PCI bus 00 dev 39
    PIIX4: chipset revision 1
    PIIX4: not 100% native mode: will probe irqs later
	ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
	ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
    PDC20267: IDE controller on PCI bus 00 dev 68
    PCI: Found IRQ 5 for device 00:0d.0
    PDC20267: chipset revision 2
    PDC20267: not 100% native mode: will probe irqs later
	ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:DMA
	ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:DMA
    hda: IBM-DPTA-373420, ATA DISK drive
    hdd: PCRW804, ATAPI CD/DVD-ROM drive
    hde: IBM-DTLA-307045, ATA DISK drive
    hdg: IBM-DTLA-307045, ATA DISK drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    ide2 at 0xac00-0xac07,0xb002 on irq 5
    ide3 at 0xb400-0xb407,0xb802 on irq 5
    hda: 66055248 sectors (33820 MB) w/1961KiB Cache, CHS=4111/255/63, UDMA(33)
    hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
    hdg: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
    Partition check:
     hda: hda1 hda2
     hde: hde1
     hdg: hdg1

So the Intel one came up with DMA enabled,  No problem there.

The Promise controller has two identical 46.1GB IBM-DTLA-307045 7200
rpm hard drives on it.  The controller is capable of ATA100.  The hard
drives are capable of ATA100.  And yet even with CONFIG_IDEDMA_AUTO
set, these drives both come up running 3.39 MB/s.  

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
