Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156519AbPLTDAm>; Sun, 19 Dec 1999 22:00:42 -0500
Received: by vger.rutgers.edu id <S156675AbPLTC5g>; Sun, 19 Dec 1999 21:57:36 -0500
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:13355 "EHLO the-village.bc.nu") by vger.rutgers.edu with ESMTP id <S156519AbPLTC5Q>; Sun, 19 Dec 1999 21:57:16 -0500
Subject: Re: Thread-private mappings and graphics (was Re: Per-Processor Data
To: jsimmons@edgeglobal.com (James Simmons)
Date: Mon, 20 Dec 1999 02:56:04 +0000 (GMT)
Cc: daryll@precisioninsight.com, moth@magenta.com, linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.LNX.4.20.9912192135280.31030-100000@imperial.edgeglobal.com> from "James Simmons" at Dec 19, 99 09:47:07 pm
Content-Type: text
Message-Id: <E11zszW-00000B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

> processes memory space. For older ISA cards that use page flipping you
> could use a page fault trick to make it seem that the framebuffer is
> linear when it isn't. Since the framebuffer window is 64K when the page

This doesnt work. The DMA is direct, PCI DMA doesnt take page faults, 
only CPU's do that. For sane cards do overlay mode, for stupid cards you
have to bounce the entire thing, you end up doing a two buffer

	grab1		write2 to fb with CPU
	grab2		write1 to fb with CPU
	repeat

loop.

With ISA cards don't bother. You'll get 5-10fps at best even at low resolution.
You'd be better off reverse engineering an old DOS era cards drivers and
writing a feature connector mode card driver for something like the original
full length hauppauge card

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
