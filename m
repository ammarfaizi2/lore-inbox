Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbREBPDa>; Wed, 2 May 2001 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbREBPDW>; Wed, 2 May 2001 11:03:22 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:16026 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135549AbREBPDG>; Wed, 2 May 2001 11:03:06 -0400
Date: Wed, 2 May 2001 17:03:03 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
Message-ID: <20010502170303.M706@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200105011653.f41Grwm12595@vindaloo.ras.ucalgary.ca> <E14ugpA-0002J3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14ugpA-0002J3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 01, 2001 at 09:32:41PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 09:32:41PM +0100, Alan Cox wrote:
> Having thought over the issues I plan to maintain a 32bit dev_t kernel with
> conventional mknod behaviour, even if Linus won't. One very interesting item
> that Peter Anvin noted is that its not clear in POSIX that
> 
> 	mknod /dev/ttyF00 c 100 100
> 
> 	open("/dev/ttyF00/speed=9600,clocal");
> 
> is illegal. That may be a nice way to get much of the desired
> behaviour without totally breaking compatibility

Ouch! 

How is that supposed to work with the dcache?

1. Does POSIX state, that "/" is the directory/entry[1] separator?
2. Can a device node be an directory?

If 1. and not 2., there is no way to implement it like that.

I don't know how people call this, if they call sth. like DevFS
"crappy", but I would be very surprised, if they call it "clean".

Just think of: 

test -r /dev/ttyF00/speed=9600,clocal && cat /dev/ttyF00/speed=9600,clocal

Or the equivalent in C in most of the programs, which read sth.

POSIX might not forbid this, because common sense already does ;-)

Regards

Ingo Oeser

[1] entry := directory | file
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
