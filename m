Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUJVRZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUJVRZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUJVRN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:13:28 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:13704 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S271419AbUJVRGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:06:11 -0400
Date: Fri, 22 Oct 2004 19:07:13 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041022170713.GJ14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <20041021182651.082e7f68.akpm@osdl.org> <417879FB.5030604@yahoo.com.au> <20041021202656.08788551.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021202656.08788551.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 08:26:56PM -0700, Andrew Morton wrote:
> Well yes, I spose the answer as always is "show me a testcase".  But the

I already gave you a testcase ages ago. Pretty simple. Get your hands on
a 2G box. boot, swapoff -a, load 1G in pagecache. malloc 1G, bzero 1G,
then open some dozen thousand files until the machine deadlocks despite
1G is perfcetly freeable in highmem.
 
> Any halfway setting will screw everyone.

this stuff run in production for 2 years at least, if anyone would be
screwed I'd already know. The only thing I know is that I've oom
deadlocks in my queue of bugs, and we'll see if this fixes them, it's
hard to tell since I don't know how much lowmem is pinned by highmem
capable allocs (like pagetables!).
