Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752684AbWKBWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbWKBWCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbWKBWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 17:02:44 -0500
Received: from pm-mx5.mgn.net ([195.46.220.209]:43722 "EHLO pm-mx5.mgn.net")
	by vger.kernel.org with ESMTP id S1752684AbWKBWCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 17:02:43 -0500
From: Damien Wyart <damien.wyart@free.fr>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       James@superbug.demon.co.uk, Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA message with 2.6.19-rc4-mm2 (not -mm1)
References: <20061102102607.GA2176@localhost.localdomain>
	<20061102192607.GA13635@kroah.com>
Date: Thu, 02 Nov 2006 23:02:41 +0100
In-Reply-To: <20061102192607.GA13635@kroah.com> (Greg KH's message of "Thu\,
	2 Nov 2006 11\:26\:07 -0800")
Message-ID: <878xitpkvy.fsf@brouette.noos.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.90
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > I notice these messages when 2.6.19-rc4-mm2 boots (also with
> > rc3-mm1) but 2.6.19-rc4-mm1 did NOT display them. Related to the
> > driver tree ?

* Greg KH <greg@kroah.com> [061102 20:26]:
> How many different sound cards do you have in your machine?

Only one, a Sound Blaster Live.

> Can you send me the output of 'ls /sys/class/sound/' with the
> 2.6.19-rc4 (or any other non-mm) kernel?

With 2.6.19-rc4-mm2, this gives:
admmidi  amidi  card0      dmmidi  hwC0D0  midi      midiC0D1  mixer    pcmC0D0p  pcmC0D2c  pcmC0D3p  sequencer   timer
adsp     audio  controlC0  dsp     hwC0D2  midiC0D0  midiC0D2  pcmC0D0c pcmC0D1c  pcmC0D2p  seq       sequencer2

While Vanilla 2.6.19-rc4 leads to:
admmidi  amidi  controlC0  dsp     hwC0D2  midiC0D0  midiC0D2  pcmC0D0c pcmC0D1c  pcmC0D2p  seq        sequencer2
adsp     audio  dmmidi     hwC0D0  midi    midiC0D1  mixer     pcmC0D0p pcmC0D2c  pcmC0D3p  sequencer  timer

Seems there is an additional 'card0' entry in the first case.


With Vanilla, the relevant part of the bootlog is:

Nov  2 22:49:03 brouette kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Sun Oct 22 08:56:16 2006 UTC).
Nov  2 22:49:03 brouette kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 21 (level, low) -> IRQ 21
Nov  2 22:49:03 brouette kernel: ALSA device list:
Nov  2 22:49:03 brouette kernel:   #0: SB Live [Unknown] (rev.10, serial:0x80671102) at 0xdf20, irq 21

so exactly the same as in mm2, without the error messages.

As rc4-mm1 doesn't show the problem (and so gives the very same output
as plain rc4), I still wonder if this is an interaction with the driver
tree ?

-- 
Damien Wyart
