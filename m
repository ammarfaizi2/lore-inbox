Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTJJNbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJJNbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:31:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42635 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262794AbTJJNbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:31:49 -0400
Date: Fri, 10 Oct 2003 14:31:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Message-ID: <20031010133104.GE28224@mail.shareable.org>
References: <yw1xu16hbg75.fsf@users.sourceforge.net> <20031010144710.A1396@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031010144710.A1396@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Fri, Oct 10, 2003 at 11:22:06AM +0200, Måns Rullgård wrote:
> > Yesterday, I compiled 2.6.0-test7 for one of my Alpha boxes.  I have
> > an AX8817X based USB ethernet adaptor connected to it (it's short on
> > PCI slots), so I compiled the usbnet module.  When I loaded usbnet, I
> > got a BUG at include/asm-generic/dma-mapping.h:19.  Apparently, DMA
> > setup only works with PCI here.  How should this be fixed?  It worked
> > with -test4, albeit slowly, for other reasons.
> 
> Well, the usage of dma_supported() in usbnet.c is wrong even for i386.
> USB device doesn't do DMA, it's USB controller what does. The driver should
> check dma_mask of the parent device instead, something like this:
> 
> 	// possible with some EHCI controllers
> 	if (*udev->dev->parent->dma_mask == 0xffffffffffffffffULL)
> 		net->features |= NETIF_F_HIGHDMA;

Isn't the device's dma_mask set equal to the controller's dma_mask
automatically?

What happens if it's on a hub, or a hub on a hub?  Then the parent
isn't the controller, is it?

-- Jamie
