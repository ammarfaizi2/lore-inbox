Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUHNMnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUHNMnU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUHNMnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:43:19 -0400
Received: from colin2.muc.de ([193.149.48.15]:32517 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261563AbUHNMlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:41:47 -0400
Date: 14 Aug 2004 14:41:45 +0200
Date: Sat, 14 Aug 2004 14:41:45 +0200
From: Andi Kleen <ak@muc.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040814124145.GA96097@muc.de>
References: <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it> <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it> <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org> <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de> <20040813135109.GA20638@elte.hu> <411D9A2A.1000202@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411D9A2A.1000202@grupopie.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The final algorithm pre-calculates markers on the compressed symbols so 
> that the search time is almost divided by the number of markers.

You could do that at compile time (in scripts/kallsyms.c) 

> 
> There are still a few issues with this approach. The biggest issue is 
> that this is clearly a speed/space trade-off, and maybe we don't want to 
> waste the space on a code path that is not supposed to be "hot". If this 
> is the case, I can make a smaller patch, that fixes just the name 
> "decompression" strcpy's.

I'm surprised that using 8 markers helps anything. There should 
be many many more 0 stems than that in a not so big kernel.
Did you actually measure the hit rate of the cache? I bet it is pretty low.

-Andi
