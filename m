Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315115AbSESULT>; Sun, 19 May 2002 16:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSESULS>; Sun, 19 May 2002 16:11:18 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:27914
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S315115AbSESULS>; Sun, 19 May 2002 16:11:18 -0400
Date: Sun, 19 May 2002 22:11:17 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardware, IDE or ext3 problem?
Message-ID: <20020519221117.A17385@bouton.inet6-interne.fr>
Mail-Followup-To: ULISSES FURQUIM FREIRE DA SILVA <ra993482@ic.unicamp.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020519201359.A17179@bouton.inet6-interne.fr> <Pine.GSO.4.10.10205191549330.16639-100000@tigre.dcc.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 04:03:25PM -0300, ULISSES FURQUIM FREIRE DA SILVA wrote:
> 
> > What's your exact chipset ?
> 
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 03)

You'll be the first that would report a SiS620 specific problem, so it's
very unlikely to be a driver problem.
 
If you didn't have CRC errors with previous distributions and they weren't
configured for UDMA your hardware is simply not capable of UDMA (bad cable
or bad drive). That's not a big problem as the kernel works around.
If you had reliable UDMA before and not now, e-mail me the details of your
last known working kernel/kernel config.

> 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
> 
> > The IDE code should lower the DMA mode by itself when it sees BadCRC, what's
> > the output of `hdparm -i /dev/hda` after these errors show up ?
> 
>  # hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=QUANTUM FIREBALLlct15 20, FwRev=A01.0F00, SerialNo=313061620944
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=418kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=39876480
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4 
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 
>  AdvancedPM=no WriteCache=enabled
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3
> ATA-4 ATA-5 

I was not expecting this. Isn't `hdparm -i` supposed to check the current dma
mode with an asterisk? It evens checks the last used dma mode (at least
here) when dma is turned off. Guess I shouldn't have `rm -rf`ed the hdparm
source...

LB.
