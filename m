Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJWKAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJWKAp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUJWKAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:00:45 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:17634 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266236AbUJWJ7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:59:03 -0400
Date: Sat, 23 Oct 2004 11:59:55 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041023095955.GR14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4179DF23.4030402@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 02:33:39PM +1000, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> >I don't see any benefit in limiting the high order, infact it seems a
> >bad bug. If something you should limit the _small_ order, so that the
> >high order will have a slight chance to succeed. You're basically doing
> >the opposite.
> >
> 
> You need the order there so someone can't allocate a huge amount
> of memory and deplete all your reserves and crash the system.

what? the point of alloc_pages is to allow people to allocate memory,
what's the difference of 1 2M allocation and 512 4k allocations? No
difference at all. Infact if something the 512 4k allocations hurts a
lot more since they can fragment the memory, while the single 2M
allocation will not fragment the memory. So if you really want to limit
something you should do the exact opposite of what the allocator is
doing.

> For day to day running, it should barely make a difference because
> the watermarks will be an order of magnitude larger.

yes, it makes little difference, this is why it doesn't hurt that much.

> AFAIKS, pages_min, pages_low and pages_high are all required for
> what we want to be doing. I don't see you you could remove any one
> of them and still have everything functioning properly....
> 
> I haven't really looked at 2.4 or your patches though. Maybe I
> misunderstood you.

2.4 has everything functionally properly but it has no
pages_min/low/high, it only has the watermarks. Infact the watermarks
_are_ low/min/high. That's what I'm forward porting to 2.6 (besides
fixing minor mostly not noticeable but harmful bits like the order
nosense described above).
