Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTJJKrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTJJKrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:47:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3082 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262009AbTJJKrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:47:35 -0400
Date: Fri, 10 Oct 2003 14:47:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Message-ID: <20031010144710.A1396@jurassic.park.msu.ru>
References: <yw1xu16hbg75.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1xu16hbg75.fsf@users.sourceforge.net>; from mru@users.sourceforge.net on Fri, Oct 10, 2003 at 11:22:06AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 11:22:06AM +0200, Måns Rullgård wrote:
> Yesterday, I compiled 2.6.0-test7 for one of my Alpha boxes.  I have
> an AX8817X based USB ethernet adaptor connected to it (it's short on
> PCI slots), so I compiled the usbnet module.  When I loaded usbnet, I
> got a BUG at include/asm-generic/dma-mapping.h:19.  Apparently, DMA
> setup only works with PCI here.  How should this be fixed?  It worked
> with -test4, albeit slowly, for other reasons.

Well, the usage of dma_supported() in usbnet.c is wrong even for i386.
USB device doesn't do DMA, it's USB controller what does. The driver should
check dma_mask of the parent device instead, something like this:

	// possible with some EHCI controllers
	if (*udev->dev->parent->dma_mask == 0xffffffffffffffffULL)
		net->features |= NETIF_F_HIGHDMA;

Ivan.
