Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbRCAX7w>; Thu, 1 Mar 2001 18:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130115AbRCAX7n>; Thu, 1 Mar 2001 18:59:43 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:6929
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130111AbRCAX7b>; Thu, 1 Mar 2001 18:59:31 -0500
Date: Thu, 1 Mar 2001 15:58:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Hylke van der Schaaf <hylke@lx.student.wau.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: DMA on a AMD7409 controller with kernel 2.4.2
In-Reply-To: <20010301140158.A402@hylke.fakenet>
Message-ID: <Pine.LNX.4.10.10103011556310.10136-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Hylke van der Schaaf wrote:

> With kernet 2.2.18 DMA mode for my harddisks worked just fine, 
> getting IDE DMA working on an AMD7409 controller with kernel 2.4.2 is a problem.
> 
> questions:
> Why is DMA disabled on revision < C4?
> How can I gat DMA working again?


AMD7409: disabling single-word DMA support (revision < C4)

This is not Ultra DMA it is the class of orignal from ATA-1/2

> 
> The Information:
> 
> in 2.2.18 I get:
> --------- dmesg: ----------
> PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=1022, DID=7409
> PCI_IDE: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> PCI_IDE: simplex device:  DMA disabled
> ide1: PCI_IDE Bus-Master DMA disabled (BIOS)
> hda: IBM-DPTA-372050, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: IBM-DPTA-372050, 19574MB w/1961kB Cache, CHS=2495/255/63
> ---------------------------
> 
> hylke:/home/hylke# hdparm -v /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 2495/255/63, sectors = 40088160, start = 0
> hylke:/home/hylke# hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.89 seconds =143.82 MB/sec
>  Timing buffered disk reads:  64 MB in  2.85 seconds = 22.46 MB/sec
> ----------------------------
> 
> All was fine.
> I compiled 2.4.2, with:
> 
> 	CONFIG_BLK_DEV_IDEPCI=y
> 	CONFIG_IDEPCI_SHARE_IRQ=y
> 	CONFIG_BLK_DEV_IDEDMA_PCI=y
> 	CONFIG_IDEDMA_PCI_AUTO=y
> 	CONFIG_BLK_DEV_IDEDMA=y
> 	CONFIG_IDEDMA_PCI_WIP=y
> 	CONFIG_AMD7409_OVERRIDE=y
> 	CONFIG_IDEDMA_AUTO=y
> 	CONFIG_IDEDMA_IVB=y
> 
> and I get:
> 
> --------- dmesg: ----------
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> AMD7409: IDE controller on PCI bus 00 dev 39
> AMD7409: chipset revision 3
> AMD7409: not 100% native mode: will probe irqs later
> AMD7409: disabling single-word DMA support (revision < C4)
> AMD7409: simplex device: DMA forced
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: IBM-DPTA-372050, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63
> --------------------------
> hylke:/home/hylke# hdparm -v /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 2495/255/63, sectors = 40088160, start = 0
> hylke:/home/hylke# hdparm -d1 /dev/hda
> 
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
> hylke:/home/hylke# hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.90 seconds =142.22 MB/sec
>  Timing buffered disk reads:  64 MB in 12.59 seconds =  5.08 MB/sec
> -------------------------
> 
> My harddisk speed is down to 25%...
> 
> Greets,
> Hylke van der Schaaf
> 
> 
> -- 
> Hi, I'm a signature virus. plz set me as your signature and help me
> spread :)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

