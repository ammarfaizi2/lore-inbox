Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbULIV3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbULIV3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbULIV3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:29:43 -0500
Received: from waste.org ([209.173.204.2]:55987 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261626AbULIV3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:29:41 -0500
Date: Thu, 9 Dec 2004 13:29:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041209212936.GO8876@waste.org>
References: <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209015705.GB6978@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 08:57:05PM -0500, Theodore Ts'o wrote:
> On Wed, Dec 08, 2004 at 01:56:14PM -0800, Matt Mackall wrote:
> > 
> > Ted, I think this is a bit more straightforward than your patch, and
> > safer as it protects get_random_bytes() and internal extract_entropy()
> > users. And I'd be leery of your get_cpu() trick due to preempt
> > issues.
> > 
> 
> I'm concerned that turning off interrupts during even a single SHA-1
> transform will put us above the radar with respect to the preempt
> latency statistics again.  We could use a separate spinlock that only
> pretects the mix_ptr and mixing access to the pool, so we're at least
> not disabling interrupts, but we still are holding a spinlock across a
> cryptographic operation.

It's been suggested to me that a sequence lock might be the right
approach to this, which I'll try to take a look at this evening. Also,
I'm going to time the lock hold time in my previous more conventional
patch and see what kind of neighborhood we're in.

-- 
Mathematics is the supreme nostalgia of our time.
