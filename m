Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279142AbRJWA3G>; Mon, 22 Oct 2001 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279143AbRJWA25>; Mon, 22 Oct 2001 20:28:57 -0400
Received: from air-1.osdl.org ([65.201.151.5]:33548 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S279142AbRJWA2k>;
	Mon, 22 Oct 2001 20:28:40 -0400
Date: Mon, 22 Oct 2001 17:29:04 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@Elf.ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15vpU0-00045L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110221726140.25103-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 23 Oct 2001, Alan Cox wrote:

> > 	/* Now tell them to stop I/O and save their state */
> > 	device_suspend(3, SUSPEND_SAVE_STATE);
>
> I'd very much like this one to be two pass, with the second pass occuring
> after interrupts are disabled. There are some horrible cases to try and
> handle otherwise (like devices that like to jam the irq line high).

I forgot to mention to disable interrupts after the SUSPEND_NOTIFY call.
The idea is to allocate all memory in the first pass, disable interrupts,
then save state. Would that work? Or, should some of the state saving take
place with interrupts enabled?


> Ditto on return from suspend where some devices also like to float the irq
> high as you take them over (eg USB on my Palmax). From comments Ben made
> ages back I believe ppc has similar issues if not worse

Yes, the resume sequence is broken into two stages:

	device_resume(RESUME_POWER_ON);

	/* enable interrupts */

	device_resume(RESUME_RESTORE_STATE);

Do you see a need to break it up further?

	-pat


