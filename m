Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269534AbUIROjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269534AbUIROjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUIROi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:38:59 -0400
Received: from main.gmane.org ([80.91.229.2]:27848 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269534AbUIROfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:35:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97         patch)
Date: Sat, 18 Sep 2004 16:35:32 +0200
Message-ID: <MPG.1bb665cd5b40a4ed9896f1@news.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se> <20040912011128.031f804a@localhost> <Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net> <20040914175949.6b59a032@sashak.lan> <MPG.1bb164a85e6c9d459896e9@news.gmane.org> <20040915035820.1cdccaa5@localhost> <MPG.1bb4d933f584efee9896f0@news.gmane.org> <20040918142900.06a9ff96@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-219-130.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Khapyorsky wrote:
> On Fri, 17 Sep 2004 12:22:05 +0200
> Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> 
> > That's it:
> > 
> > > 0000:00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02) 
> 
> This is on-board controller.

Yes. And it is indeed the Conexant modem seen by Windows.

> > OTOH, ALSA in 2.6.5 doesn't like the modem controller:
> > 
> > > PCI: Setting latency timer of device 0000:00:1f.5 to 64
> > > MC'97 1 converters and GPIO not ready (0xff00)
> > > intel8x0_measure_ac97_clock: measured 52287 usecs
> > > intel8x0: clocking to 48000
> > > PCI: Setting latency timer of device 0000:00:1f.6 to 64
> > > MC'97 1 converters and GPIO not ready (0xff00)
> > 
> > and 2.6.7 totally fails on both the audio and modem controller
> > 
> > > unable to grab IRQ 7
> > > Intel ICH: probe of 0000:00:1f.5 failed with error -16
> > > unable to grab IRQ 7
> > > Intel ICH Modem: probe of 0000:00:1f.6 failed with error -16 
> 
> Not sure that last one is ALSA related. As noted in mesg 'request_irq' fails.

Ok, I found the reason of the latter failure: in 2.6.7 I have 
ISA-PnP enabled (not in 2.6.5) and this loads the parport 
driver before the sound driver. parport steals the IRQ.

Module loading order is important: if I load the i8x0 sound 
modules first, the messages are more or less the same as the 
ones in 2.6.5 (including the "MC'97 1 converters and GPIO not 
ready" message), and then parport accepts IRQ 7 to be taken by 
resorting to polled operation:

> parport: PnPBIOS parport detected.
> parport0: PC-style at 0x378 (0x778), irq 7, dma 1 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> parport0: irq 7 in use, resorting to polled operation

I wonder what this means, and if something can be done about it 
(like: can the i8x0 sound modules use some other IRQ?)

> > I will try one of the 2.6.9 rcs one of these days and see if I 
> > can get things to work.
> 
> If not please report a problem here https://bugtrack.alsa-project.org/alsa-bug/,
> Or let me know.

I will. Do you have any idea on the "not ready" issue?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

