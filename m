Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278887AbRKFJwp>; Tue, 6 Nov 2001 04:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278722AbRKFJwg>; Tue, 6 Nov 2001 04:52:36 -0500
Received: from [195.66.192.167] ([195.66.192.167]:41221 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278887AbRKFJwU>; Tue, 6 Nov 2001 04:52:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mike Maravillo <mike.maravillo@q-linux.com>,
        Ryan Hayle <hackel@walkingfish.com>
Subject: Re: Poor IDE performance with VIA MVP3
Date: Tue, 6 Nov 2001 11:50:12 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, mike.maravillo@q-linux.com
In-Reply-To: <20011105005033.A10060@isis.visi.com> <20011105114242.A8099@isis.visi.com> <20011106035452.A1221@maravillo.q-linux.com>
In-Reply-To: <20011106035452.A1221@maravillo.q-linux.com>
MIME-Version: 1.0
Message-Id: <01110611501200.00798@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 November 2001 19:54, Mike Maravillo wrote:

> > That's the thing--it claims to be in UDMA mode, and again I get no
> > errors.  Even when I do 'hdparm -d1 -X66 /dev/hda", everything works
> > fine, without errors, only the speed problems persist.  Oh, and I have
> > compiled my kernel with VIA IDE support, it makes no difference in the
> > performance.
> >
> > It's sounding more and more like this isn't a driver/chipset problem, but
> > something wrong with the HD itself.  Thanks for your insight.
>
> This has been a long-standing problem with my system as well.  I
> have an MS-5187 VIA MVP4 board and ST320413A UltraATA/100 drive.
>
>  Timing buffer-cache reads:   128 MB in  4.40 seconds = 29.09 MB/sec
>  Timing buffered disk reads:  64 MB in 13.06 seconds =  4.90 MB/sec
>
>  Model=ST320413A, FwRev=3.39, SerialNo=7ED05MNS
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39102336
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
>  AdvancedPM=no
>  Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4
>
> I remember trying out the drive on a Soltek 75KAV and got better
> buffered disk results, ~25.0 MB/sec.

In my experience, if kernel has no support for your particular IDE
chip compiled in, you will likely be unable to get [u]dma working.

However, I have one hd which refuses to do dma even with proper support 
compiled in (I have PIIX IDE). All I can do is
# hdparm -c1 -A1 -W1 /dev/hda
and get 8mb/s in
# hdparm -T -t /dev/hda
--
vda
