Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTIQF0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 01:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTIQF0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 01:26:53 -0400
Received: from ns.suse.de ([195.135.220.2]:62162 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262571AbTIQF0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 01:26:52 -0400
Date: Wed, 17 Sep 2003 07:26:50 +0200
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-Id: <20030917072650.78f10ebf.ak@suse.de>
In-Reply-To: <3F67E8D4.6010707@cyberone.com.au>
References: <20030917022256.GA17624@wotan.suse.de>
	<20030916194446.030d8e70.akpm@osdl.org>
	<3F67E8D4.6010707@cyberone.com.au>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003 14:53:40 +1000
Nick Piggin <piggin@cyberone.com.au> wrote:

> 
> The conditional compilation thing is a seperate issue. This patch may
> have just broken a few camels' backs.
> 
> What is intriguing to me is the "Its only a 2% slowdown of the page
> fault for every cpu other than K[78] for this single workaround. There

Erm. It helps to get your numbers right first when arguing. Why did I waste the
time on benchmarking and collecting data when people afterwards still argue with 
bogus numbers? @)

It is not 2%, but <1% [~0.6% to be exact]

(probably lower the statistical error for the test, LMBench results vary more
than that on multiple runs)

Then it is not for all page faults, but only for a very narrow special
case - a page fault that is not handled, but causes a signal. These are
not very common. Arguably there are some applications that use this
stuff (like generational garbage collectors), but these are not exactly
common.

In summary, it causes 0.6% slowdown in an quite obscure use case.

That's small enough that it is best to just always enable it, because
the cost of processing any support request when people forget to enable
etc. is much greater.

-Andi
