Return-Path: <linux-kernel-owner+willy=40w.ods.org-S508013AbUKBBwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S508013AbUKBBwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S507912AbUKBBu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 20:50:28 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:19369 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S278493AbUKBBrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 20:47:17 -0500
Message-ID: <4186E719.4020100@yahoo.com.au>
Date: Tue, 02 Nov 2004 12:47:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random>
In-Reply-To: <20041101223419.GG3571@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Nov 01, 2004 at 10:03:56AM -0800, Martin J. Bligh wrote:
> 
>>[..] it was to stop cold
>>allocations from eating into hot pages [..]
> 
> 
> exactly, and I believe that hurts. bouncing on the global lock is going to
> hurt more than preserving an hot page (at least on a 512-way). Plus the
> cold page may very soon become hot too.
> 

Well, the lock isn't global of course. You might be better off
benchmarking on an old Intel 8-way SMP rather than a 512-way Altix :)

But nevertheless I won't say the lock will never hurt.

> Plus you should at least allow an hot allocation to eat into the cold
> pages (which didn't happen IIRC).
> 
> I simply believe using the lru ordering is a more efficient way to
> implement hot/cold behaviour and it will save some minor ram too (with
> big lists the reservation might even confuse the oom conditions, if the
> allocation is hot, but the VM frees in the cold "stopped" list). I know
> the cold list was a lot smaller so this is probably only a theoretical
> issue.
> 

If you don't have cold allocations eating hot pages, nor cold frees
pushing out hot pages then it may be worthwhile.

If that helps a lot, then you couldn't you just have hot allocations
also check the cold list before falling back to the buddy?

I admit I didn't look closely at this - mainly the PG_zero stuff.
