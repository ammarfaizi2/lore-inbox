Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTBCOGd>; Mon, 3 Feb 2003 09:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTBCOGc>; Mon, 3 Feb 2003 09:06:32 -0500
Received: from gate.perex.cz ([194.212.165.105]:16912 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S266368AbTBCOGb>;
	Mon, 3 Feb 2003 09:06:31 -0500
Date: Mon, 3 Feb 2003 15:15:59 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2 (fwd)
In-Reply-To: <20030130222401.GH2246@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302031457580.1116-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2003, Adam Belay wrote:

> Hi Jaroslav,
> 
> How does this sound...
> 
> What if we make pnp card services match against all pnp cards and allow more
> than one card driver to use the same card.  This can be accomplished if we detach
> the card portion from the driver model and use driver_attach.  If you feel it is

The question is probably another. I know that your solution will work, but 
do we need such hack against the driver model in our code? If you work 
with cards as buses, it allows us the same model as PCI code.

> necessary, we could also add an optional card id to the pnp_device_id structure.
> As for the pnpbios, I disagree with putting it under one card.  If the pnpbios
> contains two opl3sa2 sound cards then only one will be matched and therefore it

It's not true. The driver model calls probe for all instances.

> is a bad idea to represent the pnpbios as a card.  When ACPI is introduced, both

Note that if we make card as bus, then this problem will disapear.
The enumeration will be simple: devices on the one bus. And it's strong 
advantage over current implementation when bus == protocol.

What do you think about this model:

bus (PnP BIOS) -> devices
bus (ACPI) -> devices
bus (ISA PnP) -> bus (cards) -> devices

To allow grouping of card devices, we can use the driver_attach() function 
from the probe() callback.

Also, the current pnp_protocol should be detached from the driver model.
I think that it's internal thing for the PnP device management.

> pnpbios and ACPI will be cardless protocols.  Therefore I think it is best to 
> use the pnp_driver structure instead of the pnpc_driver structure in the
> opl3sa2 ALSA driver.

The opl3sa2 driver is an exception. All others will require groups of 
devices.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

