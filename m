Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQLUEgd>; Wed, 20 Dec 2000 23:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbQLUEgY>; Wed, 20 Dec 2000 23:36:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:16653 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130645AbQLUEgH>; Wed, 20 Dec 2000 23:36:07 -0500
Date: Wed, 20 Dec 2000 23:06:02 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Julian Anastasov <ja@ssi.bg>
cc: Robert Högberg <robho956@student.liu.se>,
        Andre Hedrick <andre@linux-ide.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Extreme IDE slowdown with 2.2.18
In-Reply-To: <Pine.LNX.4.21.0012202246510.6151-100000@u>
Message-ID: <Pine.LNX.4.31.0012202253530.748-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2000, Julian Anastasov wrote:

>> hda: QUANTUM FIREBALL ST6.4A, 6149MB w/81kB Cache, CHS=784/255/63
>> hdb: QUANTUM FIREBALL SE4.3A, 4110MB w/80kB Cache, CHS=524/255/63
>> hdc: IBM-DJNA-352030, 19470MB w/1966kB Cache, CHS=39560/16/63
>>
>> When I performed the tests I used similiar .17 and .18 kernels with a
>> minimum components included. No network, SCSI, sound and such things.
>> .config files can be supplied if needed.
>>
>> Does anyone know what could be wrong? Have I forgot something? Is this a
>> known problem with the 2.2.18 kernel?
>
>	Yes, 2.2.18 is not friendly to all MVP3 users. The autodma
>detection was disabled for the all *VP3 users in drivers/block/ide-pci.c.
>
>	If you don't experience any problems with the DMA you can:
>
>1. Add append="ide0=dma ide1=dma" in lilo.conf
>
>2. Use ide patches:
>
>http://www.kernel.org/pub/linux/kernel/people/hedrick/ide-2.2.18/ide.2.2.18.1209.patch.bz2

Using an MVP3 board (DFI), 2.2.18 + the above patch, with the
above mentioned config changes, DMA by default, and word93
invalidate enabled, I just enabled UDMA66 on my 2 drives and got
disk corruption.

Both drives are UDMA66 or better, and I'm using the 80 pin cable.

2 root@asdf:~# hdparm -i /dev/hd[ab]

/dev/hda:

 Model=IBM-DTLA-307030, FwRev=TX4OA50C, SerialNo=YKDYKGF1437
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16,
MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes,
LBAsects=60036480
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
udma5

/dev/hdb:

 Model=QUANTUM FIREBALL EL7.6A, FwRev=A08.1100,
SerialNo=347816714615
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=15907/15/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16,
MultSect=16
 CurCHS=15907/15/63, CurSects=1597178085, LBA=yes,
LBAsects=15032115
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1
*udma2


Using "hdparm -d1X66" on these drives results in errors to syslog
followed by disk corruption.  With word93 thingie NOT built into
the kernel, the corruption doesn't occur, but instead I get a
message saying UDMA 3/4/5 is not supported.  It also claims the
MVP3 chipset is UDMA-33 only, whereas all relevant docs I can
muster including the mobo manual state the board is UDMA-66
capable.  Mental note to myself: Do not enable WORD93 invalidate.
;o)

I've never seen UDMA66 work at all on any mobo/disk combo yet
that I've tried.  My belief has been that the mobo/chipsets are
broken, and Andre's code just disables stuff known to be crap
hardware.  Forcing it as I did, resulted in corruption, so I'll
tend to believe the driver next time and not push the issue.  ;o)

Andre, is MVP3 capable of UDMA66 in any way shape or form, or
should I just drop the thought of ever getting it to work and buy
an add-in board?  If the latter, what recommendation of hardware
would you give?

I'm getting 11 - 12Mb/s out of my disks now with the IDE patches,
which is a MAJOR improvement over the stock kernel.  I'd like to
push this up closer to the drive's rated capacities though.

I'd also like to be able to use whatever kernel I want without
using vendor supplied binary-only modules for IDE support.

Is there a totally open-source solution for me?  ;o)

Would I get better results at all with 2.4.0testXX, with or
without any patches, and what value of XX?

TIA

----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Red Hat FAQ tip: Having trouble upgrading RPM 3.0.x to RPM 4.0.x?  Upgrade 
first to version 3.0.5, and then to 4.0.x.  All packages are available on 
Red Hat's ftp sites:       ftp://ftp.redhat.com  ftp://rawhide.redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
