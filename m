Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279146AbRJWA00>; Mon, 22 Oct 2001 20:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRJWA0Q>; Mon, 22 Oct 2001 20:26:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47378 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279142AbRJWA0F>; Mon, 22 Oct 2001 20:26:05 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: mochel@osdl.org (Patrick Mochel)
Date: Tue, 23 Oct 2001 01:31:52 +0100 (BST)
Cc: pavel@Elf.ucw.cz (Pavel Machek),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110221702260.25103-100000@osdlab.pdx.osdl.net> from "Patrick Mochel" at Oct 22, 2001 05:19:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vpU0-00045L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	/* Now tell them to stop I/O and save their state */
> 	device_suspend(3, SUSPEND_SAVE_STATE);

I'd very much like this one to be two pass, with the second pass occuring
after interrupts are disabled. There are some horrible cases to try and
handle otherwise (like devices that like to jam the irq line high).

Ditto on return from suspend where some devices also like to float the irq
high as you take them over (eg USB on my Palmax). From comments Ben made
ages back I believe ppc has similar issues if not worse


Alan
