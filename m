Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264951AbTIJOnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbTIJOnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:43:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1922 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264951AbTIJOnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:43:33 -0400
Date: Wed, 10 Sep 2003 10:45:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Takashi Iwai <tiwai@suse.de>
cc: Jaroslav Kysela <perex@suse.cz>, Russ Garrett <rg@tcslon.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Audio skipping with alsa
In-Reply-To: <s5hhe3kvjtc.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.53.0309101037120.12986@chaos>
References: <1063116861.852.50.camel@russell> <s5hk78gvkt7.wl@alsa2.suse.de>
 <Pine.LNX.4.53.0309101536080.1411@pnote.perex-int.cz> <s5hhe3kvjtc.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Takashi Iwai wrote:

> At Wed, 10 Sep 2003 15:38:46 +0200 (CEST),
> Jaroslav wrote:
> >
> > On Wed, 10 Sep 2003, Takashi Iwai wrote:
> >
> > > At Tue, 09 Sep 2003 15:14:21 +0100,
> > > Russ Garrett wrote:
> > > >
> > > > Hi, I've just installed an M-Audio Audiophile 2496 sound card (Envy24)
> > > > with the 2.6.0-test5 kernel (with the preemptible kernel option on),
> > > > using the ice1712 alsa driver (although this also happens in 2.4.21
> > > > without preemptible kernel).
> > > >
> > > > Music plays fine until I do *anything* - changing windows, scrolling,
> > > > pressing buttons, whatever - when it stutters badly. Scrolling in an
> > > > anti-aliased terminal is especially fun. However, if I play using XMMS
> > > > with the realtime priority option, everything's fine, although that has
> > > > the distinct disadvantage that I have to run it as root.
> > > >
> > > > I've tried enabling/disabling ACPI/APM/APIC. The card isn't sharing an
> > > > IRQ with anything.  It's not a hard drive/IDE related issue, although
> > > > that's all using DMA anyway.
> > > >
> > > > I do have both an AGP and a PCI graphics card installed and in use,
> > > > although the stuttering happens if I do anything on either. I've found a
> > > > few references to this problem on google, but no solutions. It works
> > > > fine on Windows ;).
> > > >
> > > > Here's what happens if I try to scroll in gnome-terminal whilst aplaying
> > > > something:
> > > >
> > > > rg@russell:~$ aplay < test
> > > > Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
> > > > xrun!!! (at least 869.990 ms long)
> > > > xrun!!! (at least 21.552 ms long)
> > > > xrun!!! (at least 17.686 ms long)
> > > > xrun!!! (at least 16.482 ms long)
> > > > xrun!!! (at least 17.194 ms long)
> > > > xrun!!! (at least 17.126 ms long)
> > > > xrun!!! (at least 14.123 ms long)
> > > > xrun!!! (at least 13.679 ms long)
> > > > xrun!!! (at least 12.928 ms long)
> > > > [...and so on, for another 20 or so lines]
> > >
> > > i guess it's a general scheduler issue.
> > >
> > > why you face this problem more severly than others:
> > > the timing on the ice1712 (envy24) chip is quite tight, because it
> > > always needs 32bit * 10 channels interleaved samples even if you want
> > > to play a two-channel mp3 file.  more badly, the maximum buffer size
> > > is limited to 64k byte.  hence, at most, you can get about 0.1 sec for
> >
> > It's limited to 256kB. And yes, it's only 0.14 sec for 44.1kHz playback.
>
> oh yes, thanks for correction :)
>
>
> Takashi
>

I don't see the driver in linux-2.4.22/drivers/sound, so I can't
look at it directly, but normally all you have to do is keep
a FIFO full (not empty) during play. There should not be any
scheduling issues with sound chips although I am seeing too
much of that lately. Maybe  somebody should look at the driver
before the scheduler is blamed. Perhaps the driver is not
designed properly so it assumes the user-mode code can do
something it can't possibly be expected to do with any
reliability. For instance, perhaps it's the user-mode's
responsibility to keep a FIFO full? And, you can never
guarantee that.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


