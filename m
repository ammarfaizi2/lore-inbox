Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTAVIOe>; Wed, 22 Jan 2003 03:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTAVIOe>; Wed, 22 Jan 2003 03:14:34 -0500
Received: from gate.perex.cz ([194.212.165.105]:53254 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267236AbTAVIOd>;
	Wed, 22 Jan 2003 03:14:33 -0500
Date: Wed, 22 Jan 2003 09:23:08 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Adam Belay <ambx1@neo.rr.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2
In-Reply-To: <Pine.LNX.4.44.0301212034340.1577-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0301220918470.1210-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Kai Germaschewski wrote:

> On Tue, 21 Jan 2003, Adam Belay wrote:
> 
> > How does this sound...
> > 1.) detach pnp card service matching from the driver model, the driver model is
> > what is imposing this one card per driver limit.
> > 2.) create a special pnp_driver that handles cards and forwards driver model calls
> > to the pnp card services, we can use attach_driver to avoid matching problems.
> > 
> > design goals for these changes should be as follows:
> > 1.) multiple drivers can bind to one card
> > 2.) pnp_attach, pnp_detach, and pnp status should be phased out and replaced with
> > the special card driver, in other words the driver model can take care of this.
> 
> First of all I admit that I haven't been following closely, so I maybe way 
> off.
> 
> Anyway, the old ISAPnP used, AFAIR, struct pci_bus for the card and struct
> pci_device for the devices. So what's wrong with using the basically the
> same abstraction with the driver model, which has buses and devices as
> well. That means each device can have its own driver, and I suppose that
> should be good enough (as opposed to only one driver per card).
> 
> But probably I'm missing something?

The structure is clear (devices & cards) but we need something like device
groups which contain subsets of devices per card. Actuall driver model
doesn't allow this directly, so we are looking for a way to implement
this.

Imagine:

card -+-> audio1
      |
      +-> audio2
      |
      +-> IDE

If we have two card drivers (one for audio1 & audio2 and second for IDE)  
then current code will fail, because only one PnP driver can be attached
to a card.


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

