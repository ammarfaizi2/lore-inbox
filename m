Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRDBI3Q>; Mon, 2 Apr 2001 04:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRDBI3G>; Mon, 2 Apr 2001 04:29:06 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:29189
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132629AbRDBI27>; Mon, 2 Apr 2001 04:28:59 -0400
Date: Mon, 2 Apr 2001 00:27:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Chan <achan@achan.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20267 "working" but no UDMA
In-Reply-To: <00d601c0ba9c$d60cc700$3700a8c0@pluto>
Message-ID: <Pine.LNX.4.10.10104020024550.12531-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Andrew Chan wrote:

> Anybody manage to get UDMA 66/100 working with an on-board Promise 20267
> chip?
> 
> Hardware: Tyan Tiger LE (with ServerWorks OSB4 _and_ Promise 20267 on-board)
> 
> Kernel: 2.4.3 with ide.2.4.3-p8.all.03242001.patch by Andre Hedrick (or
> stock 2.4.3 with more or less same results)
> 
> FastTrack config: only 1 drive, configured as a SPAN volume consisting of 1
> drive

No RAIDing allowed in the FTTK Bios.

> I don't quite care about the Promise RAID features. I will use Linux
> software RAID. The problem is that I cannot seem to be able to get the
> controller into UDMA 4 (66 Mhz) mode!
> 
> I have enabled all the relevant DMA related kernel options. I have also
> checked using the Seagate disk utility to make sure that the drive is
> recognized (and configured) as UDMA 66 capable.
> 
> The following is from dmesg:
> 
> PCI: Found IRQ 10 for device 00:03.0
> PDC20267: chipset revision 2
> PDC20267: not 100% native mode: will probe irqs later
> PDC20267: ROM enabled at 0xfeae0000
> PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.

This is a RAID mode BIOS and that is specified to disable under linux
unless a 0x55AA valid signature is present

> PDC20267: neither IDE port enabled (BIOS)

And it does!

> I wonder what the last line meant by saying neither port is enabled?
> 
> # /sbin/hdparm -Tt /dev/hde
> 
> /dev/hde:
>  Timing buffer-cache reads:   128 MB in  0.74 seconds =172.97 MB/sec
>  Timing buffered disk reads:  64 MB in 12.82 seconds =  4.99 MB/sec [should
> be much much faster here]
> 
> # cat /proc/ide/pdc202xx
> 
>                                 PDC20267 Chipset.
> ------------------------------- General
> Status ---------------------------------
> Burst Mode                           : enabled
> Host Mode                            : Normal
> Bus Clocking                         : 33 PCI Internal
> IO pad select                        : 10 mA
> Status Polling Period                : 0
> Interrupt Check Status Polling Delay : 0
> --------------- Primary Channel ---------------- Secondary
> Channel -------------
>                 enabled                          enabled
> 66 Clocking     enabled                          disabled
>            Mode MASTER                      Mode MASTER
>                 FIFO Empty                       FIFO Empty
> --------------- drive0 --------- drive1 -------- drive0 ----------
> drive1 ------
> DMA enabled:    no               no              yes               no
> DMA Mode:       UDMA 4           NOTSET          NOTSET            NOTSET
> PIO Mode:       PIO 4            NOTSET           NOTSET            NOTSET
> 
> # hdparm -d1 /dev/hde
> 
> /dev/hde:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
> 
> # hdparm -X68 /dev/hde
> 
> [resulted in the following message in /var/log/messages]
> 
> Apr  1 19:03:21 promise kernel: ide2: Speed warnings UDMA 3/4/5 is not
> functional.
> 
> # hdparm -i /dev/hde
> 
> /dev/hde:
> 
>  Model=ST36421A, FwRev=6.01, SerialNo=5BE064AN
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=13330/15/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=256kB, MaxMultSect=16, MultSect=off
>  CurCHS=13330/15/63, CurSects=913440960, LBA=yes, LBAsects=12596850
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 *udma4
                          ^^^^^^                         ^^^^^^

You have not enable the chipset code properly

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

