Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRCCStr>; Sat, 3 Mar 2001 13:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRCCSth>; Sat, 3 Mar 2001 13:49:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4113 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129660AbRCCStg>; Sat, 3 Mar 2001 13:49:36 -0500
Date: Sat, 3 Mar 2001 10:49:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Hinds <dhinds@sonic.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug in cardbus initialization, or am I missing something?
In-Reply-To: <20010303095819.A16963@sonic.net>
Message-ID: <Pine.LNX.4.10.10103031046460.17645-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Mar 2001, David Hinds wrote:
>
> In drivers/pcmcia/cardbus.c in cb_alloc(), PCI_INTERRUPT_LINE and
> dev->irq are not filled in until after calling pci_enable_device().
> The result is a cryptic message like:
> 
> > PCI: No IRQ known for interrupt pin A of device 01:00.0. Please try using pci=biosirq. 
> 
> Unless there is a less obvious reason for the ordering, I suggest the
> following one-liner.

Agreed.

In fact, we shouldn't need to enable the device at all: the drivers are
supposed to do the pci_enable_device() themselves. But let's do the
minimal "move it down a few lines" thing for now.

Thanks,

		Linus

