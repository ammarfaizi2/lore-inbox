Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTJJLi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTJJLi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:38:56 -0400
Received: from mx1.kth.se ([130.237.32.140]:21418 "EHLO mx1.kth.se")
	by vger.kernel.org with ESMTP id S262061AbTJJLiz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:38:55 -0400
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
References: <yw1xu16hbg75.fsf@users.sourceforge.net>
	<20031010144710.A1396@jurassic.park.msu.ru>
From: e99_mru@e.kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 10 Oct 2003 13:38:42 +0200
In-Reply-To: Ivan Kokshaysky's message of "Fri, 10 Oct 2003 14:47:10 +0400"
Message-ID: <yw1xwubd2ugt.fsf@quetzalcoatlite.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

> > Yesterday, I compiled 2.6.0-test7 for one of my Alpha boxes.  I have
> > an AX8817X based USB ethernet adaptor connected to it (it's short on
> > PCI slots), so I compiled the usbnet module.  When I loaded usbnet, I
> > got a BUG at include/asm-generic/dma-mapping.h:19.  Apparently, DMA
> > setup only works with PCI here.  How should this be fixed?  It worked
> > with -test4, albeit slowly, for other reasons.
> 
> Well, the usage of dma_supported() in usbnet.c is wrong even for i386.
> USB device doesn't do DMA, it's USB controller what does. The driver should

That's what I thought.

> check dma_mask of the parent device instead, something like this:
> 
> 	// possible with some EHCI controllers
> 	if (*udev->dev->parent->dma_mask == 0xffffffffffffffffULL)
> 		net->features |= NETIF_F_HIGHDMA;

Is that all there is to it?

-- 
Måns Rullgård
mru@users.sf.net
