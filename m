Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTJJRLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTJJRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:11:47 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:7571 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263014AbTJJRLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:11:45 -0400
Message-ID: <3F86E9D7.9020104@pacbell.net>
Date: Fri, 10 Oct 2003 10:18:15 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mru@users.sourceforge.net,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON at include/asm-generic/dma-mapping.h:19 is a
bug in that "generic DMA" code ... and I've seen the
same BUG reported from PPC folk too.

All implementations of dma_supported() should check
those DMA masks directly ... instead we have

  - A "generic" implementation that only works for PCI,
    even though that method (in particular!) was intended
    to really be generic enough to work with USB;

  - Some arch-specific implementations (x86) that don't
    handle the 64-bit DMA case correctly.

We might need arch-specific implementations of that
method, and maybe Alpha is even one of them.  But if
there's going to be a default implementation for that
method, the current scheme has portability problems.


Ivan Kokshaysky wrote:
> Anyway, as it is, usbnet driver won't work on i386 with
> more than 4G of RAM and 32-bit DMA USB controller.

Nope -- there's EHCI, which can handle 64-bit DMA when the
silicon allows ... which is why that test exists.

- Dave



