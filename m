Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVHEV16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVHEV16 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbVHEV1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:27:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50130 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261887AbVHEV0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:26:20 -0400
Date: Fri, 5 Aug 2005 23:26:10 +0200
From: Andi Kleen <ak@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>, davem@davemloft.net
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050805212610.GA8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805200156.GF7425@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 01:01:57PM -0700, Matt Mackall wrote:
> The netpoll philosophy is to assume that its traffic is an absolute
> priority - it is better to potentially hang trying to deliver a panic
> message than to give up and crash silently.

That would be ok if netpoll was only used to deliver panics. But 
it is not. It delivers all messages, and you cannot hang the 
kernel during that. Actually even for panics it is wrong, because often
it is more important to reboot in a panic than (with a panic timeout) 
to actually deliver the panic. That's needed e.g. in a failover cluster.

If that was the policy it would be a quite dumb one and make netpoll
totally unsuitable for production use. I hope it is not.


> 
> > Also, as Andi told me, the printk here would probably not show up
> > anyway if this happens with netconsole.
> 
> That's fine. But in fact, it does show up occassionally - I've seen
> it.
> 
> NAK'ed.

Too bad. This would mean that all serious non toy users of netpoll
would have to carry this patch on their own. But that wouldn't be good.

Dave, can you please apply the timeout patch anyways?

I suspect Steven's patch for the e1000 is needed in addition to
handle different cases too.


-Andi
