Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271859AbRH0TC4>; Mon, 27 Aug 2001 15:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271855AbRH0TCq>; Mon, 27 Aug 2001 15:02:46 -0400
Received: from fungus.teststation.com ([212.32.186.211]:62481 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S271859AbRH0TCi>; Mon, 27 Aug 2001 15:02:38 -0400
Date: Mon, 27 Aug 2001 21:02:29 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: David Schmitt <david@heureka.co.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: DFE530-TX REV-A3-1 times out on transmit
In-Reply-To: <20010827102740.A9557@www.heureka.co.at>
Message-ID: <Pine.LNX.4.10.10108272025400.25944-100000@ada.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, David Schmitt wrote:

> > Reloading the module is to the hardware about the same as the watchdog
> > reset.
> 
> Good news: Under 2.2.19, reloading the module indeed reset the card,
> so that it worked again. 

Interesting ...

> > Rebooting obviously triggers something else too ... perhaps the BIOS talks
> > some sense to the card.
> 
> As mentioned above, it seems like the 2.2.19 version does the Right
> Thing (but doesn't recover autmatically).

The 2.2.19 version doesn't do anything on timeout (except print a message
that it is resetting, which it isn't :). The driver has a few changes
during the 2.4 series:

2.4.3 was patched to actually reset things on tx_timeout, but that also
changed the startup sequence.

2.4.6 got changes to reload certain things from eeprom when the driver is
loaded (fix a problem with booting from win98 that does a power down).

2.4.7 changes to the transmit code to use "singlecopy" for unaligned
buffers.

2.4.8-acX fixed a bug in the startup code from 2.4.3

Testing the 2.4.2 and 2.4.3 drivers could give something (should work to
simply copy the drivers/net/via-rhine.c from the different versions into a
2.4.9 source tree).


> but doing one or two parallel ping -f other.machine locks the NIC for
> good.

Good (that you have a reliable way to trigger this). For about how long do
you need to run this?

> The network where the DFE530TX (and the other.machine) are attached
> contains some 20-30 Windows PCs and some Novell Servers which all seem
> quite braodcast-happy. The network itself is (mostly) unswitched and
> 10Mbit halfduplex, so I guess this really is connected to the
> collisions.

Depending on the sort of access you have, you could test unplugging
everyone else and repeat the 'ping -f' test.

I don't have the hardware to test now, but when time permits ...

/Urban

