Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbUKBWqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUKBWqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKBWoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:44:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51329 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261733AbUKBWmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:42:04 -0500
Date: Tue, 02 Nov 2004 14:41:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>,
       Andrew Morton <akpm@digeo.com>
cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <235610000.1099435275@flay>
In-Reply-To: <20041102215651.GU3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org> <20041102215651.GU3571@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 02, 2004 at 01:09:10PM -0800, Andrew Morton wrote:
>> The cold pages are mainly intended to be the pages which will be placed
>> under DMA transfers.  We should never return hot pages in response for a
>> request for a cold page.
> 
> after the DMA transfer often the cpu will touch the data contents
> (all the pagein/reads do that) and the previously cold page will become
> hotter than the other hot pages you left in the hot list. I doubt

eh? I don't see how that matters at all. After the DMA transfer, all the 
cache lines will have to be invalidated in every CPUs cache anyway, so
it's guaranteed to be stone-dead zero-degrees-kelvin cold. I don't see how
however hot it becomes afterwards is relevant? 

> there's any difference between a cache shoop or a recycle of some cache
> entry because we run out of cache (in turn making some random hot cache
> as cold). There's a window of time during the dma that may run faster by
> allocating hot cache, but in the same window of time some other task may
> as well free some hot data in turn avoiding to enter the buddy at all
> and to take the zone lock.

If the DMA is to pages that are hot in the CPUs cache - it's WORSE ... we
have more work to do in terms of cacheline invalidates. Mmm ... in terms
of DMAs, we're talking about disk reads (ie a new page allocates) - we're
both on the same page there, right?

M.

