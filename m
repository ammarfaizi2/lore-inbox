Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAKOmh>; Thu, 11 Jan 2001 09:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbRAKOmR>; Thu, 11 Jan 2001 09:42:17 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:24585 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S129983AbRAKOmO>; Thu, 11 Jan 2001 09:42:14 -0500
Date: Thu, 11 Jan 2001 09:41:55 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: James Brents <James@nistix.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA problems on 2.4.0 with vt82c686a driver
In-Reply-To: <3A5DB638.1050809@nistix.com>
Message-ID: <Pine.LNX.4.10.10101110923430.19906-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since this looks like either a chipset, drive, or driver problem, I am 

no: the only entities involved with udma crc's are the drive,
the controller (and the cable).  the kernel is not involved in any way
(except to configure udma, of course.)

> occasionally (not often/constant, but sometimes) get CRC errors:
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

nothing wrong here.  occasional crc retries cause no performance impact.

> After reading some archives in linux-kernel, I tried changing some 
> options. Then I changed out the 40 pin, 80 wire cable with a new one. 

great, since without the 80c cable, udma > 33 is illegal.
is it safe to assume your cable is also 18" or less, with both ends
plugged in (no stub)?  you might be able to minimize CRC retries
by changing where the cable runs.  it's also conceivable that CRC
errors would be caused by marginal power, bad trace layout on the 
motherboard, and definitely by overclocking (PCI other than 33 MHz).

> My main concern that I havnt beem able to find an answer for on any 
> archives or documentation, Can this cause file system corruption in any way?

abosolutely not.  udma checksums each transfer.  when checksums don't match,
the *hardware* retries the transfer (and incidentally reports the event,
which Linux obligingly passes on to you.)

regards, mark hahn.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
