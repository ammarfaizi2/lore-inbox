Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVHFXLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVHFXLB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 19:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVHFXKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 19:10:51 -0400
Received: from waste.org ([216.27.176.166]:39366 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261337AbVHFXKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 19:10:49 -0400
Date: Sat, 6 Aug 2005 16:10:29 -0700
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "David S. Miller" <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050806231029.GD8074@waste.org>
References: <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <1123275420.18332.81.camel@localhost.localdomain> <20050805212808.GV8074@waste.org> <1123287835.18332.110.camel@localhost.localdomain> <20050806015310.GA8074@waste.org> <1123295548.18332.126.camel@localhost.localdomain> <20050806075827.GA6735@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806075827.GA6735@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 09:58:27AM +0200, Ingo Molnar wrote:
> 
> btw., the current NR_SKBS 32 in netpoll.c seems quite low, especially 
> e1000 can have a whole lot more skbs queued at once. Might be more 
> robust to increase it to 128 or 256?

Not sure that the card's queueing really makes a difference. It either
eventually releases the queued SKBs or it doesn't. What's more
important is that we be able to survive bursts like the output of
sysrq-t. This seems to work already.

-- 
Mathematics is the supreme nostalgia of our time.
