Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289100AbSA1Pub>; Mon, 28 Jan 2002 10:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289219AbSA1PuX>; Mon, 28 Jan 2002 10:50:23 -0500
Received: from gw.wmich.edu ([141.218.1.100]:41917 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S289100AbSA1PuO>;
	Mon, 28 Jan 2002 10:50:14 -0500
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: benh@kernel.crashing.org, Kristian <kristian.peters@korseby.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C551F18.873EA52E@zip.com.au>
In-Reply-To: <3C550BD4.E9CBE6A@zip.com.au> <3C550BD4.E9CBE6A@zip.com.au>
	<20020128095136.1298@mailhost.mipsys.com>  <3C551F18.873EA52E@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 10:50:01 -0500
Message-Id: <1012233006.951.2.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've always been able to get it back to dma for packet by forcing the
drive to sleep mode and then letting the kernel wake it.   I guess I'll
try this 3rd version patch when I get back from class today and see if
that still works.   

hdparm -Y /dev/cdrom    

then go and set dma again with hdparm.   

Although this could just be fickleness of my cdrom.  


On Mon, 2002-01-28 at 04:51, Andrew Morton wrote:
> benh@kernel.crashing.org wrote:
> > 
> > >At no stage does a packet-mode DMA error turn off drive-level
> > >DMA.  This is because some devices seem to perform ordinary
> > >ATA DMA OK, but screw up packet DMA.
> > >
> > >The kernel internally retries the requests when it performs fallback,
> > >so userspace shouldn't see any disruption as the kernel works
> > >out what to do.
> > >
> > >Once the drive has fallen back to single-frame (or PIO mode) for
> > >packet reads, the only way to get it back to a higher level is
> > >a reboot.
> > 
> > Doesn that mean that a bad media (typically a scratched CDROM) will
> > cause the drive to revert to PIO until next reboot ?
> > 
> 
> Nope.  This error handling is specifically for busmastering
> errors, not for media errors.
> 
> I've tested media errors (whiteboard marker scribblings on the
> CD do this nicely).  DMA errors (bad return value from
> HWIF->dmaproc) I can only simulate.
> 
> 
> -


