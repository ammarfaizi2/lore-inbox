Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbULJRud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbULJRud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbULJRud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:50:33 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61921 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261775AbULJRuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:50:15 -0500
Date: Fri, 10 Dec 2004 18:49:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210174938.GX16322@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041210163247.GM2714@holomorphy.com> <1102697553.3306.91.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102697553.3306.91.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 05:52:33PM +0100, Thomas Gleixner wrote:
> I'm wondering why he did not post the final version. Andrea ???

I already posted the final version since it had no bugs and I asked to
get it merged twice. The only bugs are obviously in the drivers (or the
callers) and they needs urgent fixing and additionally the
might_sleep_if must stop checking if the system is running so these bugs
can see the light of the day. Not being allowed to schedule in
alloc_pages with __GFP_WAIT set is a mistake.

Your patch was orthogonal to mine, so I didn't merge it. Go figure that
every time I post something it gets splitted into trivial pieces, so
it's a waste of time to try to merge any additional patch and post a
final one since it'll never be final anyway.

I am about to merge the things together for some other tree (not
mainline), that is a worthwhile effort but with the split behaviour of
mainline, for mainline it'd be a waste of time.

One last thing worth discussing on my side is if we should worry about
the tiny race between the watermark checks and the entering of the oom
killing. In theory we could wrap the thing around a semaphore and close
the race completely, though current code is simpler and as you find
it works fine in practice.
