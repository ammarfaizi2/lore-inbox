Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752654AbWKBWYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbWKBWYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbWKBWYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:24:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:47848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752654AbWKBWYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:24:38 -0500
Date: Thu, 2 Nov 2006 14:22:42 -0800
From: Greg KH <greg@kroah.com>
To: Damien Wyart <damien.wyart@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
Message-ID: <20061102222242.GA17744@kroah.com>
References: <20061102102607.GA2176@localhost.localdomain> <20061102192607.GA13635@kroah.com> <878xitpkvy.fsf@brouette.noos.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878xitpkvy.fsf@brouette.noos.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 11:02:41PM +0100, Damien Wyart wrote:
> Hello,
> 
> > > I notice these messages when 2.6.19-rc4-mm2 boots (also with
> > > rc3-mm1) but 2.6.19-rc4-mm1 did NOT display them. Related to the
> > > driver tree ?
> 
> * Greg KH <greg@kroah.com> [061102 20:26]:
> > How many different sound cards do you have in your machine?
> 
> Only one, a Sound Blaster Live.
> 
> > Can you send me the output of 'ls /sys/class/sound/' with the
> > 2.6.19-rc4 (or any other non-mm) kernel?
> 
> With 2.6.19-rc4-mm2, this gives:
> admmidi  amidi  card0      dmmidi  hwC0D0  midi      midiC0D1  mixer    pcmC0D0p  pcmC0D2c  pcmC0D3p  sequencer   timer
> adsp     audio  controlC0  dsp     hwC0D2  midiC0D0  midiC0D2  pcmC0D0c pcmC0D1c  pcmC0D2p  seq       sequencer2
> 
> While Vanilla 2.6.19-rc4 leads to:
> admmidi  amidi  controlC0  dsp     hwC0D2  midiC0D0  midiC0D2  pcmC0D0c pcmC0D1c  pcmC0D2p  seq        sequencer2
> adsp     audio  dmmidi     hwC0D0  midi    midiC0D1  mixer     pcmC0D0p pcmC0D2c  pcmC0D3p  sequencer  timer
> 
> Seems there is an additional 'card0' entry in the first case.

That should be a symlink right?  Well it will be if you have
CONFIG_SYSFS_DEPRECATED disabled.  What is the setting of that config
option?

> With Vanilla, the relevant part of the bootlog is:
> 
> Nov  2 22:49:03 brouette kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
> Nov  2 22:49:03 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
> Nov  2 22:49:03 brouette kernel: ALSA device list:
> Nov  2 22:49:03 brouette kernel:   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0xdf20, irq 21
> 
> so exactly the same as in mm2, without the error messages.
> 
> As rc4-mm1 doesn't show the problem (and so gives the very same output
> as plain rc4), I still wonder if this is an interaction with the driver
> tree ?

I do have an alsa patch in my tree that adds the "card0" stuff, but it
looks like it is working for you.  I wonder why we are trying to
register the same card twice.

Maybe we always did that and never noticed the failure?

Takashi, any thoughts?

thanks,

greg k-h
