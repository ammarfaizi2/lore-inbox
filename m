Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265026AbUEYSIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbUEYSIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbUEYSIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:08:40 -0400
Received: from mail.skule.net ([216.235.14.165]:43217 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S265026AbUEYSIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:08:16 -0400
Date: Tue, 25 May 2004 14:08:14 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] scatter-gather ops within host memory on a PC
Message-ID: <20040525180814.GF10775@mjfrazer.org>
References: <20040525170931.GE10775@mjfrazer.org> <Pine.LNX.4.53.0405251337210.1989@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0405251337210.1989@chaos>
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry: Where's Captain Bender? Off catastrophizing some other planet?
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> [04/05/25 13:52]:
> Scatter-lists with DMA operations are quite common. Many Ethernet
> controllers that perform bus-master DMA use a chip that is either
> a (PLX) PCI 9080 or pretty-much a clone.

Yup, you're talking about PCI adapter to host scatter gather.  I was
staying within the host memory.  I was wanting to use the standard
ethernet drivers to do the transfer from the cards to the host.  Then
peek at the headers of the rx'd skbufs to set up another scatter-gather
operation to unmix the possibly out-of-order and certainly discontiguous
in host memory packets.

> The problem is that DMA does data-transfer to physical locations.
> If you only have one physical location (a page in DMA-able memory)
> its virtual to physical translation needs to be done only once.
> But, if you expect to write to/from user-mode buffers, the translation
> needs to be done every time the scatter-list is built. This is not
> some simple operation since user's pages are assembled from anywhere
> into what looks like contiguous space to the user, but physically
> can be anywhere. So somebody has got to scan a bunch of page-tables
> looking for the user's pages every time you build the scatter-list,
> i.e., every DMA transfer. This will surely take much more time than
> the current scheme.

You're getting at DIO: get_user_pages, pci_map_sg, sg_dma_address,
sg_dma_len and friends.  I can't quite do that for this application as I
want to reorder the data in the driver and present the application with
the in-order reassembled image.  The destination buffer for the
un-mixing SG operation will be the result of get_user_pages and friends
though.

cheers
-mark
-- 
They're great! They're like sex except I'm having them. - Fry
