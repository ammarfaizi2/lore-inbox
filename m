Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbUJZAPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUJZAPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbUJYPFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:05:32 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:56229 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261898AbUJYOyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:54:03 -0400
Date: Mon, 25 Oct 2004 15:51:10 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041025135110.GX14325@dualathlon.random>
References: <20041022011057.GC14325@dualathlon.random> <41787840.3060807@yahoo.com.au> <20041022165809.GH14325@dualathlon.random> <4179DF23.4030402@yahoo.com.au> <20041023095955.GR14325@dualathlon.random> <417A30EE.1030205@yahoo.com.au> <20041023110334.GS14325@dualathlon.random> <417A86AC.2080505@yahoo.com.au> <20041025124443.GV14325@dualathlon.random> <417CF65C.4040008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417CF65C.4040008@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:49:32PM +1000, Nick Piggin wrote:
> The current stuff is pretty crufty. I think your changes are
> far better (aside from the minor fact they won't compile!).

;) yes, I still have to finish hooking the new code into the
page_alloc.c, this was just a preview.

dropping pages_xx would have been a bigger change so I'm avoiding it for
now since I agree I would need to add more fields than just min/low/high
for the realtime and GFP_HIGH features (and most important I couldn't
remove those 2 branches anywyas).  In 2.4 I was ignoring __GFP_HIGH. I
doubt it makes much difference in practice, but it makes sense in theory
so I'll keep those new features of course (especially the RT one could
help in practice too).

> Also, switching to a calculation that has seen some real-world
> use would be a good idea before we think about turning it on
> by default.

agreed. the value tuning is quite simple to understand this way, it is
tuned exactly to start to reserve the entire lowmem on a 32G x86 box.
31G/32 = 0.9G > 800m.
