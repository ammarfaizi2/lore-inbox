Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932852AbWKNUaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbWKNUaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933462AbWKNUaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:30:13 -0500
Received: from dvhart.com ([64.146.134.43]:32390 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932852AbWKNUaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:30:11 -0500
Message-ID: <455A274F.4070604@mbligh.org>
Date: Tue, 14 Nov 2006 12:30:07 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Mel Gorman <mel@skynet.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie> <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> <455A174E.3070601@mbligh.org> <Pine.LNX.4.64.0611141959150.14484@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0611141959150.14484@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Never underestimate yourself, Martin ;)

Thanks ;-)

> Yes, those all looked like no-ops.  The guilty party is ext2_new_blocks:
> i386, x86_64 and ppc64 are now happily building on ext2s with this patch
> below (I've been lazy, could have deleted your "E2FSBLK" addition too).

Yup, we started throwing away the error return code ;-(

> But I haven't attempted to correlate it with the loops seen (with OOMs
> too on the x86_64, no idea why, but they've likewise melted away with
> this patch).  And I'm dubious whether it's the _right_ fix: the whole
> mess of ints, unsigned longs and __u32s looks tricky to me, not some-
> thing to sort out in a hurry - I'm only working with small filesystems
> here (looped on a tmpfs file).  (And if ret_block really should be an
> ext2_fsblk_t there, shouldn't ext2_new_blocks return an ext2_fsblk_t
> rather than an int?)

I was trying to harmonize it with what ext3 code does, but as Andrew
understands this code a thousand times better than I, hopefully it's
all fixed properly ;-)

> I see Andrew's sent me an alternative patch to try, I'll give that
> a whirl now; and see if just making ext2_new_blocks return an
> ext2_fsblk_t would do it too.


M.
