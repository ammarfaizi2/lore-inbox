Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268314AbTAMVPW>; Mon, 13 Jan 2003 16:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268338AbTAMVPW>; Mon, 13 Jan 2003 16:15:22 -0500
Received: from havoc.daloft.com ([64.213.145.173]:20962 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268314AbTAMVPV>;
	Mon, 13 Jan 2003 16:15:21 -0500
Date: Mon, 13 Jan 2003 16:24:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ross Biro <rossb@google.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
Message-ID: <20030113212406.GA13531@gtf.org>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com> <1042399796.525.215.camel@zion.wanadoo.fr> <1042403235.16288.14.camel@irongate.swansea.linux.org.uk> <1042401074.525.219.camel@zion.wanadoo.fr> <3E230A4D.6020706@google.com> <1042484609.30837.31.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042484609.30837.31.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 08:03:29PM +0100, Benjamin Herrenschmidt wrote:
> Exactly. My problem right now is with enforcing that 400ns delay on
> non-DMA path as with PCI write posting on one side, and other fancy bus
> store queues etc... you are really not sure when your outb for the
> command byte will really reach the disk.

As a slight tangent, PCI write posting is quite annoying because on some
hardware one simply cannot perform a read immediately after a write,
without pausing for a hardware-specified amount of time.

...but, at the same time, who knows how long the write posting may take,
so one doesn't know how long the delay really needs to be.

It would be nice if there was an arch-specific flush-posted-writes hook
[wmb_mmio() ?], if that was possible on write-posting CPUs.  Currently
right now the canonical solution ("MMIO read") doesn't work in some
situations, and I do think we have a solution at all for those "some
situations."

	Jeff




