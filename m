Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSELWEQ>; Sun, 12 May 2002 18:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSELWEP>; Sun, 12 May 2002 18:04:15 -0400
Received: from [128.195.36.171] ([128.195.36.171]:27890 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S315439AbSELWEO>; Sun, 12 May 2002 18:04:14 -0400
Subject: Re: UDMA Troubles and Possible Physical Damage?!
To: aeleblanc@olgc.on.ca
Date: Sun, 12 May 2002 15:06:45 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF3BBACEBD.3823AB14-ON85256BB7.0074FF80@LocalDomain> from "aeleblanc@olgc.on.ca" at May 12, 2002 05:27:20 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020512220645.973FA89546@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Duron 1GHz on an ACS Mobo with SiS Chipset. 100MHz FSB & 384 MB PC133 
> SDRAM.
> and a Fujitsu 30MB ATA100 Drive
> 
> 
> I Just finished installing Debian - Woody, which installs Kernel Version 
> 2.2.17 I Believe (I may be wrong there)

For anything recent, you really want the IDE support in 2.4.19-preX (latest
is -pre8).

> I installed and ran hdparm and after telling me that dma and all that 
> other good stuff was disabled it said "HDIO: Failed to check BUSSTATE"
> 
> i ran hdparm -c3 -d1 -X34 to try and get DMA Working... the command ran 

Usually -X## commands are just asking for trouble these days (the driver
should be doing it on its own, and in the newer kernels, it does). The
most that should be needed is "hdparm -d1" and that's only needed if the
"DMA enabled by default" config option wasn't enabled at kernel compile
time.  

> fine but as soon as I tried to run another command (just 'ls' in fact) the 
> system Locked up Solid.  upon rebooting my Bios didn't even Pick up the 
> Hard drive.. I did a Hard reset again and the Bios picked it up, then 
> reset again and it failed to pick it up again.. is it possible that I 
> Screwed up my motherboard or Hard drive somehow?

In this kind of situation you want to turn off the power to the machine
for a few minutes, ideally unplugging the machine from mains if you really
want to be sure. If the IDE controller somehow gets confused, a "hard
reset" alone isn't enough to fix things (speaking from personal
experience).

I doubt there is physical damage, but I don't know for sure. In any case,
try unplugging the thing for a few minutes, and see if you still have
problems. (Make sure you do *not* use that hdparm -X34 option.)

> the on a side note, before attempting to use hdparm under the above 
> mentioned kernel, I compiled a custom 2.4.18 kernel, however it caused 
> even more problems with ide, a bunch of:
> 
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> Flew by then it said ide0: reset: success, then locked up again.
> 
> if anyone can help it would be greatly appreciated.

I would start by trying 2.4.19-pre8. If that doesn't help, there are even
newer IDE driver patches on http://www.linuxdiskcert.org/ which might be
worth a try.

-Barry K. Nathan <barryn@pobox.com>
