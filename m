Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUKBV5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUKBV5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKBV5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:57:24 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:27302 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261570AbUKBV5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:57:07 -0500
Date: Tue, 2 Nov 2004 22:56:51 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041102215651.GU3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102130910.3e779d32.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 01:09:10PM -0800, Andrew Morton wrote:
> The cold pages are mainly intended to be the pages which will be placed
> under DMA transfers.  We should never return hot pages in response for a
> request for a cold page.

after the DMA transfer often the cpu will touch the data contents
(all the pagein/reads do that) and the previously cold page will become
hotter than the other hot pages you left in the hot list. I doubt
there's any difference between a cache shoop or a recycle of some cache
entry because we run out of cache (in turn making some random hot cache
as cold). There's a window of time during the dma that may run faster by
allocating hot cache, but in the same window of time some other task may
as well free some hot data in turn avoiding to enter the buddy at all
and to take the zone lock.
