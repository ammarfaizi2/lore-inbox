Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUIQKWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUIQKWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUIQKWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:22:20 -0400
Received: from main.gmane.org ([80.91.229.2]:55707 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268663AbUIQKWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:22:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97       patch)
Date: Fri, 17 Sep 2004 12:22:05 +0200
Message-ID: <MPG.1bb4d933f584efee9896f0@news.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se> <20040912011128.031f804a@localhost> <Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net> <20040914175949.6b59a032@sashak.lan> <MPG.1bb164a85e6c9d459896e9@news.gmane.org> <20040915035820.1cdccaa5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Khapyorsky wrote:
> On Tue, 14 Sep 2004 23:04:41 +0200
> Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> 
> > Sasha Khapyorsky wrote:
> > > Such modems also exist (AC97 controller + MC97 codec + DAA), but
> > > less popular (especially with laptops there modem are mostly used).
> > 
> > I have one such built in in my Dell Inspiron 8200, which is why 
> > I'm following this thread with particular interest.
> > 
> > The strange thing is that under Windows the modem is configured 
> > as a Conexant thingie ... or is the problem that I have both 
> > and the Conexant thingie is the one connected to the actual 
> > modem plug? Is there a way to know this (other than having a 
> > look inside my laptop, that is)?
> 
> If it looks like this:
> 
> 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller
> 
> it is most likely on-board south bridge and MDC (or other riser)
> modem. This may work with ALSA.

That's it:

> 0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02) 


Very verbose lspci output for both the soundcard and modem give 
me:

> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio Controller (rev 02)
>       Subsystem: Cirrus Logic: Unknown device 5959
>       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>       Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>       Latency: 0
>       Interrupt: pin B routed to IRQ 7
>       Region 0: I/O ports at d800 [size=256]
>       Region 1: I/O ports at dc80 [size=64]
> 
> 0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02) (prog-if 00 [Generic])
>       Subsystem: Conexant MD56ORD V.92 MDC Modem
>       Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>       Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>       Interrupt: pin B routed to IRQ 7
>       Region 0: I/O ports at d400 [size=256]
>       Region 1: I/O ports at dc00 [size=128] 

OTOH, ALSA in 2.6.5 doesn't like the modem controller:

> PCI: Setting latency timer of device 0000:00:1f.5 to 64
> MC'97 1 converters and GPIO not ready (0xff00)
> intel8x0_measure_ac97_clock: measured 52287 usecs
> intel8x0: clocking to 48000
> PCI: Setting latency timer of device 0000:00:1f.6 to 64
> MC'97 1 converters and GPIO not ready (0xff00)

and 2.6.7 totally fails on both the audio and modem controller

> unable to grab IRQ 7
> Intel ICH: probe of 0000:00:1f.5 failed with error -16
> unable to grab IRQ 7
> Intel ICH Modem: probe of 0000:00:1f.6 failed with error -16 

I will try one of the 2.6.9 rcs one of these days and see if I 
can get things to work.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

