Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRALIMn>; Fri, 12 Jan 2001 03:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRALIMY>; Fri, 12 Jan 2001 03:12:24 -0500
Received: from styx.suse.cz ([195.70.145.226]:46582 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129562AbRALIMS>;
	Fri, 12 Jan 2001 03:12:18 -0500
Date: Fri, 12 Jan 2001 09:12:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: James Brents <James@nistix.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
Message-ID: <20010112091214.B812@suse.cz>
In-Reply-To: <3A5DB638.1050809@nistix.com> <Pine.LNX.4.10.10101110923430.19906-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101110923430.19906-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Thu, Jan 11, 2001 at 09:41:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 09:41:55AM -0500, Mark Hahn wrote:
> > Since this looks like either a chipset, drive, or driver problem, I am 
> 
> no: the only entities involved with udma crc's are the drive,
> the controller (and the cable).  the kernel is not involved in any way
> (except to configure udma, of course.)

Well, that's the part where it is really easy to cause crc errors. But I
believe I got that right in the driver. Tested successfully on many VIA
chipsets.

> > occasionally (not often/constant, but sometimes) get CRC errors:
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> nothing wrong here.  occasional crc retries cause no performance impact.

Also it should be noted that they don't cause any corruption (*). The worst
thing they can do is disabling DMA if they happen many times in a short
period of time. 

(*) - UDMA modes only. CRC errors are a big problem in PIO and
      MWDMA/SWDMA modes.

> > After reading some archives in linux-kernel, I tried changing some 
> > options. Then I changed out the 40 pin, 80 wire cable with a new one. 
> 
> great, since without the 80c cable, udma > 33 is illegal.

... note that he says 40pin, 80wire. That's the correct UDMA66 cable, it
has just 40 pins.

> is it safe to assume your cable is also 18" or less, with both ends
> plugged in (no stub)?  you might be able to minimize CRC retries
> by changing where the cable runs.  it's also conceivable that CRC
> errors would be caused by marginal power, bad trace layout on the 
> motherboard,

Bad trace on the motherboard is what I suspect on KT7's. It could be
designed a little longer or shorter than the others and a marginal clock
skew can cause the crc errors. Or the trace can lead too close to some
source of e/m noise.

> and definitely by overclocking (PCI other than 33 MHz).
> 
> > My main concern that I havnt beem able to find an answer for on any 
> > archives or documentation, Can this cause file system corruption in any way?
> 
> abosolutely not.  udma checksums each transfer.  when checksums don't match,
> the *hardware* retries the transfer (and incidentally reports the event,
> which Linux obligingly passes on to you.)

The software retries the transfer, the hardware just aborts. But it's
safe, anyways.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
