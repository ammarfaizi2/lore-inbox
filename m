Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUCYWu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUCYWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:50:01 -0500
Received: from waste.org ([209.173.204.2]:40849 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263698AbUCYWr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:47:59 -0500
Date: Thu, 25 Mar 2004 16:47:27 -0600
From: Matt Mackall <mpm@selenic.com>
To: David Mosberger <davidm@napali.hpl.hp.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040325224726.GB8366@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325141923.7080c6f0.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 02:19:23PM -0800, Andrew Morton wrote:
> 
> Matt, could you please review David's changes?
> 
> Begin forwarded message:
> 
> Date: Wed, 24 Mar 2004 22:06:57 -0800
> From: David Mosberger <davidm@napali.hpl.hp.com>
> To: akpm@osdl.org
> Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
> Subject: potential /dev/urandom scalability improvement
> 
> 
> Hi Andrew,
> 
> I'm addressing this patch to you because you seem to have been the
> person who most recently made some performance improvements to the
> random driver.

That was probably me, actually.

> Oh, and somebody who actually understands this code may want to
> double-check the patch for correctness.

Seems perfectly sane.

However, I've got a few pending patches that touch the same areas and
do some more critical cleanup that I've been sitting on since the
2.6.0 freeze. So perhaps I should start pushing those again and we can
queue this behind them. David, if you get a chance, grab the latest
copy of my linux-tiny tree from

 http://www.selenic.com/tiny/2.6.5-rc2-tiny1-broken-out.tar.bz2
 http://www.selenic.com/tiny/2.6.5-rc2-tiny1.patch.bz2

and see how I've tweaked the pool structure and the locking and how
your bits fit with it.

> +#ifdef ARCH_HAS_PREFETCH
> +	for (cp = (char *) r->pool; cp <= (char *) (r->pool + wordmask); cp += PREFETCH_STRIDE)
> +		prefetch(cp);
> +#endif

Can we avoid adding this ifdef in some fashion? What does the compiler
generate here when prefetch is a no-op? This seems to call for a
prefetch_range(start, len) function/macro in any case.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
