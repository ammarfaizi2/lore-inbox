Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUFXRx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUFXRx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 13:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUFXRx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 13:53:57 -0400
Received: from holomorphy.com ([207.189.100.168]:21899 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266813AbUFXRxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 13:53:54 -0400
Date: Thu, 24 Jun 2004 10:53:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624175331.GI21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
	Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20040623213643.GB32456@hygelac> <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624173927.GQ30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624173927.GQ30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 07:39:27PM +0200, Andrea Arcangeli wrote:
> I looked more into it and you can leave it turned off since it's not
> going to work.
> it's all in functions of z->pages_* and those are _global_ for all the
> zones, and in turn they're absolutely meaningless.
> the algorithm has nothing in common with lowmem_reverse_ratio, the
> effect has a tinybit of similarity but the incremntal min thing is so
> weak and so bad that it will either not help or it'll waste tons of
> memory. Furthemore you cannot set a sysctl value that works for all
> machines. The whole thing should be dropped and replaced with the fine
> production quality lowmem_reserve_ratio in 2.4.26+
> (the only broken thing of lowmem_reserve_ratio is that it cannot be
> tuned, not even at boottime, a recompile is needed, but that's fixable
> to tune it at boot time, and in theory at runtime too, but the point is
> that no dyanmic tuning is required with it)
> Please focus on this code of 2.4:

There is mention of discrimination between pinned and unpinned
allocations not being possible; I can arrange this for more
comprehensive coverage if desired. Would you like this to be arranged,
and if so, how would you like that to interact with the fallback
heuristics?


-- wli
