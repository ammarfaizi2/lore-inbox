Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266897AbSLDEPu>; Tue, 3 Dec 2002 23:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbSLDEPu>; Tue, 3 Dec 2002 23:15:50 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:13288 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S266897AbSLDEPs>; Tue, 3 Dec 2002 23:15:48 -0500
Date: Wed, 04 Dec 2002 16:43:07 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Adam Kessel <adam@bostoncoop.net>, linux-kernel@vger.kernel.org
Subject: Re: Widespread hda lost interrupt problem on laptops
Message-ID: <96450000.1038973387@localhost.localdomain>
In-Reply-To: <20021203203249.GA747@joehill>
References: <20021203203249.GA747@joehill>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect this is also related to the behaviour of many Dell laptops, where 
the clock runs very slow, especially if the machine is sporadically busy 
and the fans are cycling on and off frequently.  My machine also loses IDE 
and network interrupts, but only very rarely (probably because my use 
pattern doesn't generate much disc or net activity and the window for the 
problem is fairly small, I suspect about 1 or 2 ms).

Certainly one can create the problem by running something disc intensive 
and then entering the BIOS setup screen :-).  Linux loses any interrupts 
active at the time, and the clock stops for the whole time the BIOS has 
control.  I'm sure there's nothing to be done except handle this gracefully 
(i.e. without crashing), and somehow fix the clock.

Windows on this hardware also loses control for a couple of milliseconds 
during a fan control event (circumstantial evidence:  Cubasis needs a 
buffer size that would play out in about 5ms not to skip upon a fan speed 
change).

Andrew

--On Tuesday, December 03, 2002 15:32:50 -0500 Adam Kessel 
<adam@bostoncoop.net> wrote:

> Please cc: me on responses.
>
> The following problem has been discussed on many different mailing lists
> (including this one) over the past couple of years, although I believe
> there are many of us for whom none of the posted suggestions have worked.
> Hopefully I'm not out of line for venturing onto this list as a
> non-expert:
>
> When switching from power to battery on the HP OmniBook 500 laptop (and
> many other laptops, apparently) the following appears in syslog:
>
> kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
> kernel: hda: lost interrupt
>
> This also occurs when suspending/resuming,  sleeping/resuming, or
> switching from battery to power.
>
> Sometimes it results in severe hard disk corruption, and usually causes a
> system crash if the error occurred during intensive disk activity (no
> further disk access is possible).  It occurs equally when the drive is
> mounted read-only and/or in runlevel 1.
>
> My current hard drive is a Toshiba MK2016GAP[1], although the same problem
> occurs to varying degrees with other hard drives I have tried in the same
> laptop, and other OB500 laptops with different hard drives.
>
> The problem occurs in the 2.2 and 2.4 series, and I have a report that it
> also occurs in the latest of the 2.5 series.
>
> I have tried every possible combination of hdparm parameters that has
> been publicly suggested.  Turning off dma (hdparm -d0) does remove the
> "ide_dma" part, but the "lost interrupt" error and crash remain. Turning
> on or off interrupt-unmask flag (hdparm -u0/1) makes no difference in the
> error. Enabling PIO makes no difference either.
>
> I have tried all possible combinations of APM_ALLOW_INTS and
> IDEDISK_MULTI_MODE in compiling the kernel, with no apparent effect on
> this problem.
>
> I have tried changing the apm events on suspend/resume to include various
> hdparm switches suggested elsewhere, to no avail.
>
> Finally, these laptops all seem to perform fine when switching from power
> to battery or suspending/resuming under various versions of MS Windows.
>
> I have checked out nearly every hit on google for "hda lost interrupt"
> and have not found anything that worked.
>
> I have yet to find an OB500 on which this problem does *not* occur.
>
> I hope this is enough information! Thanks for any troubleshooting
> suggestions.
> ---
> Adam Kessel (adam@bostoncoop.net)
>
> [1] Here is the dmesg description of the drive:
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
> hda: TOSHIBA MK2016GAP, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 39070080 sectors (20004 MB), CHS=2584/240/63, UDMA(33))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


