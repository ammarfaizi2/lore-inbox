Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbVKXATm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbVKXATm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030536AbVKXATl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:19:41 -0500
Received: from kanga.kvack.org ([66.96.29.28]:13024 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030524AbVKXATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:19:40 -0500
Date: Wed, 23 Nov 2005 19:17:01 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Grover <andrew.grover@intel.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
Message-ID: <20051124001700.GC14246@kvack.org>
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384E7F2.2030508@pobox.com> <20051123223007.GA5921@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123223007.GA5921@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:30:08PM +0100, Andi Kleen wrote:
> The main problem I see is that it'll likely only pay off when you can keep 
> the queue of copies long (to amortize the cost of 
> talking to an external chip). At least for the standard recvmsg 
> skb->user space, user space-> skb cases these queues are 
> likely short in most cases. That's because most applications
> do relatively small recvmsg or sendmsgs. 

Don't forget that there are benefits of not polluting the cache with the 
traffic for the incoming skbs.

> Longer term the right way to handle this would be likely to use
> POSIX AIO on sockets. With that interface it would be easier
> to keep long queues of data in flight, which would be best for
> the DMA engine.

Yes, that's something I'd like to try soon.

> But it's not clear it's a good idea: a lot of these applications prefer to 
> have the target in cache. And IOAT will force it out of cache.

In the I/O AT case it might make sense to do a few prefetch()es of the 
userland data on the return-to-userspace code path.  Similarly, we should 
make sure that network drivers prefetch the header at the earliest possible 
time, too.

> I remember the registers in the Amiga Blitter for this and I'm
> still scared... Maybe it's better to keep it simple.

*grin*  but you could use it for such cool tasks as MFM en/decoding! =-)

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.
