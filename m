Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTJJUJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbTJJUJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:09:23 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:18073 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262690AbTJJUJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:09:13 -0400
Message-ID: <3F87137A.5040807@pacbell.net>
Date: Fri, 10 Oct 2003 13:15:54 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: mru@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
References: <3F86E9D7.9020104@pacbell.net> <20031010221919.A650@den.park.msu.ru> <yw1x4qyhorsx.fsf@users.sourceforge.net> <20031010225957.A764@den.park.msu.ru>
In-Reply-To: <20031010225957.A764@den.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> 
> Sigh. The generic dma_* stuff wasn't a well thought-out idea,
> and it's too late to change it in 2.6. :-(

The API is more reasonable than the "all is PCI" assumption
from that "asm-generic" implementation.  I think it should be
reasonable to update any architecture's implementation there.


> Right now calling dma_* functions for non-busmaster devices
> just *doesn't work*.

See the patch I posted for dma_supported(), which should
make that one behave.  It's obvious how to generalize that
specific call with a platform_dma_supported().  USB won't
care about the other dma_* functions ... though it does suck
that all non-PCI ohci-hcd code still needs use the "fake PCI"
kluges.  (Proof that the implementation of those APIs is
still only usable with PCI.)

For other functions, it seems you're mostly saying that some
drivers are missing tests for non-null dma_mask pointers.


> David, do you mind applying that?

Yes, because that's nowhere near where the bugs are!
Also, it's good to get rid of BUG()s ... and better to
get rid of them when they're broken like that one is.

- Dave

