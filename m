Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130508AbRAXQLK>; Wed, 24 Jan 2001 11:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRAXQLA>; Wed, 24 Jan 2001 11:11:00 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:3088 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130508AbRAXQKw>;
	Wed, 24 Jan 2001 11:10:52 -0500
Message-ID: <3A6EFF32.2090603@megapathdsl.net>
Date: Wed, 24 Jan 2001 08:13:38 -0800
From: Miles Lane <miles@megapathdsl.net>
Reply-To: miles@megapathdsl.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre9 i686; en-US; m18) Gecko/20010121
X-Accept-Language: en
MIME-Version: 1.0
To: Benson Chow <blc@q.dyndns.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 disk speed 66% slowdown...
In-Reply-To: <Pine.LNX.4.31.0101240841550.10119-100000@q.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benson Chow wrote:

> Just as a datapoint, my Via IDE chipset (on atb850/kt133) and Promise
> Ultra66 (on 2xpp200/82440FX/PIIX3) works fine with 2.4.0, getting speeds
> about correct:


<snip>

>  Model=QUANTUM FIREBALLP LM30, FwRev=A35.0700
>  [snip.  unused info cut]
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
>  UDMA modes: mode0 mode1 mode2 mode3 *mode4
> 
>  Timing buffered disk reads:  64 MB in  4.30 seconds = 14.88 MB/sec
>  Timing buffered disk reads:  64 MB in  4.34 seconds = 14.75 MB/sec

Hi,

I have the same drive, but "hdparm -i" gives different output:

  Model=QUANTUM FIREBALLP LM30, FwRev=A35.0700, SerialNo=186006831114
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
  BuffType=DualPortCache, BuffSize=1900kB, MaxMultSect=16, MultSect=off
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58633344
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4

There is no mention of "UDMA modes."

However, my throughput seems to be much faster than yours for some reason:

  Timing buffer-cache reads:   128 MB in  0.91 seconds =140.66 MB/sec
  Timing buffered disk reads:  64 MB in  2.49 seconds = 25.70 MB/sec

My machine is an Athlon (booting says "Detected 848.381 MHz processor").
I'm not sure what the system bus speed is, but I think it's ~100MHz.

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fca00000-feafffff
	Prefetchable memory behind bridge: e4800000-f48fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE 
(rev 03) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at cb00 [size=16]

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD7409=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

Cheers,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
