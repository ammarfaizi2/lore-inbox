Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbRLJRQR>; Mon, 10 Dec 2001 12:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286324AbRLJRP5>; Mon, 10 Dec 2001 12:15:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286323AbRLJRPu>; Mon, 10 Dec 2001 12:15:50 -0500
Subject: Re: mm question
To: volodya@mindspring.com
Date: Mon, 10 Dec 2001 17:25:09 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0112101041020.17406-100000@node2.localnet.net> from "volodya@mindspring.com" at Dec 10, 2001 11:05:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DUAv-0002hY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "AGP addressable" memory which is ~64meg less than the total amount on my
> machine. However, looking around in AGP driver or AGP specs does not seem
> to indicate any restriction of the sort and, moreover, I do not need AGP
> for this DMA transfer (it is PCI only).

Can the transfer go to pages mapped into the AGP gart, using their gart
side mapping ?

> Better than giving up.. Unfortunately looking around in
> linux/Documentation and drivers did not yield much in terms of
> explanation. I know I can use mem_map_reserve to reserve a page but I
> don't know how to get page struct from a physical address nor which lock
> to use when messing with this.

You have to grab them at boot time via bootmem to get them in a range of
your choice. Otherwise you can use

	get_free_page		-	grab a page
	virt_to_page		-	page struct of page
	virt_to_bus		-	bus addr of page

virt_to_bus isnt portable because real world pci bus mapping on non x86 is
deeply murky and mysterious. But you probably want to worry about that
after it works.

Alan
