Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281295AbRKETzU>; Mon, 5 Nov 2001 14:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281296AbRKETzK>; Mon, 5 Nov 2001 14:55:10 -0500
Received: from igateway01.ibmsd.com ([202.73.165.2]:4736 "EHLO
	maravillo.q-linux.com") by vger.kernel.org with ESMTP
	id <S281295AbRKETzE>; Mon, 5 Nov 2001 14:55:04 -0500
Date: Tue, 6 Nov 2001 03:54:52 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: Ryan Hayle <hackel@walkingfish.com>
Cc: linux-kernel@vger.kernel.org, mike.maravillo@q-linux.com
Subject: Re: Poor IDE performance with VIA MVP3
Message-ID: <20011106035452.A1221@maravillo.q-linux.com>
In-Reply-To: <20011105005033.A10060@isis.visi.com> <01110516120000.00794@nemo> <20011105114242.A8099@isis.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011105114242.A8099@isis.visi.com>; from hackel@walkingfish.com on Mon, Nov 05, 2001 at 11:42:43AM -0600
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 11:42:43AM -0600, Ryan Hayle wrote:
> On Mon, 05 Nov, 2001 at 04:12:00PM +0000, vda wrote:
> > Are you saying that hdparm -T -t is yielding wildly varying results?
> > Looks similar to failing hd symptoms or bug in IDE layer causing retries
> > after error/timeout. What's in the logs?
> 
> hdparm -T (buffer-cache reads) gives good numbers, 43v69 M/sec just
> now.  But that's only mesuring reading from the drive's 2M cache (I
> believe?).  It is the hdparm -t test (buffered disk reads) that is the
> problem.  As I said, I don't receive any errors or retries
> whatsoever.  Everything seems to be working perfectly, just very, very
> slow...
> 
> > Well, I had problems with drives refusing to do [u]dma.
> > On my home machine I found out that compiling kernel with support for VIA 
> > chipset allowed udma to work ok (hdparm -T -t = ~20mb/s). Without that 
> > support, my hd was stuck in pio, ~6mb/s.
> 
> That's the thing--it claims to be in UDMA mode, and again I get no
> errors.  Even when I do 'hdparm -d1 -X66 /dev/hda", everything works fine,
> without errors, only the speed problems persist.  Oh, and I have compiled
> my kernel with VIA IDE support, it makes no difference in the performance.
> 
> It's sounding more and more like this isn't a driver/chipset problem, but
> something wrong with the HD itself.  Thanks for your insight.

This has been a long-standing problem with my system as well.  I
have an MS-5187 VIA MVP4 board and ST320413A UltraATA/100 drive.

 Timing buffer-cache reads:   128 MB in  4.40 seconds = 29.09 MB/sec
 Timing buffered disk reads:  64 MB in 13.06 seconds =  4.90 MB/sec

 Model=ST320413A, FwRev=3.39, SerialNo=7ED05MNS
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=39102336
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4

I remember trying out the drive on a Soltek 75KAV and got better
buffered disk results, ~25.0 MB/sec.

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
