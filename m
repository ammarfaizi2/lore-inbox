Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTACGcf>; Fri, 3 Jan 2003 01:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbTACGce>; Fri, 3 Jan 2003 01:32:34 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:18890 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S267444AbTACGbv>; Fri, 3 Jan 2003 01:31:51 -0500
Date: Thu, 02 Jan 2003 22:46:43 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E1531D3.3070809@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200301022207.OAA00803@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> 	In practice, I think that if we just added one, maybe two,
> URB's by default for every endpoint when a device is added, that
> that would be enough to guarantee that would reduce the number of
> drivers that needed to reserve more URB's than that to few or none.

I seem to recall someone posted a patch to make non-iso URB allocation
use a mempool.


>>Hmm, I was unaware that anyone expected GFP_KERNEL (or rather,
>>__GFP_WAIT) to guarantee that memory was always returned.  It's
>>not called __GFP_NEVERFAIL, after all.
> 
> 
> 	mempool_alloc does.  That's the point of it.  You calculate
> how many objects you need in order to guarantee no deadlocks and
> reserve that number in advance (the initial reservation can fail).

To rephrase that so it illustrates my point:  the whole reason to
use mempool is to try adding __GFP_NEVERFAIL when __GFP_WAIT is
given ... because __GFP_WAIT doesn't otherwise mean NEVERFAIL.

- Dave


