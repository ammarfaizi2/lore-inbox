Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUL2VcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUL2VcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUL2VcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:32:24 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:47053 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261424AbUL2VcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:32:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=I1TuiNARKqRq2H9DnKEoTnuPZd8gg3x3P3eiR1upG1NdJTjX2ySD1RrCc1jkiHhVcJfOw/eZyJe4UB0KobG8wO07Z59Tka8dhwlM3wgDnFjrPeWG4RGNbNHlgAN+w0/7hFRWoCCdqWj6idXnX4c54TghQe2ZyqOyHvPSloNpZzs=
Message-ID: <58cb370e04122913323cdf05e8@mail.gmail.com>
Date: Wed, 29 Dec 2004 22:32:12 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10 - IT8212 IDE
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, linux-ide@vger.kernel.org
In-Reply-To: <1104351122.31052.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104246926.22366.97.camel@localhost.localdomain>
	 <58cb370e041229092919c1b4a8@mail.gmail.com>
	 <1104351122.31052.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 20:12:04 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-12-29 at 17:29, Bartlomiej Zolnierkiewicz wrote:
> > Let me complain once again :-), libata based driver would be better...
> 
> Eventually probably but libata's PATA support is pretty pathetic right
> now, it doesn't know anything about PATA drive errata. I did look at it
> and when it grows up into a real IDE layer for PATA I'm all for moving
> *every* IDE driver to it because some of the IDE error path corner cases

OK

> are almost rewrite level fixes (eg DMA changedown, timer/interrupt CD
> race oops)

fully agreed

> > > +                *      If we are in pass through mode then not much
> > > +                *      needs to be done, but we do bother to clear the
> > > +                *      IRQ mask in case the drives are PIO (eg rev 0x10)
> > > +                *      for now.
> > > +                */
> >
> > comment or code is wrong, unmask is turned on unconditionally
> 
> Disagree. It says "e.g."

"e.g." is okay, "in case the drives are PIO" is not,
unmask also affects DMA (I believe it is not needed for DMA but ...)
 
> > > +                       hwif->ide_dma_off_quietly(drive);
> > > +#ifdef CONFIG_IDEDMA_ONLYDISK
> > > +                       if (drive->media == ide_disk)
> > > +#endif
> > > +                               hwif->ide_dma_check(drive);
> >
> > hack, it looks like fixup code in ide-probe.c need to be moved to probe_hwif()
> 
> I'm not sure of the best way to do that cleanly. What do you have in
> mind ?

moving ->fixup() execution from probe_hwif_init_with_fixup() to probe_hwif()
(just before code which does PIO / DMA tuning)

>From what I see it shouldn't affect current ->fixup users
(and is saner because currently "undecoded slave" is also tuned).

> Thanks. I'll go and polish these up.

Thanks.
