Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVHEVpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVHEVpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVHEVno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:43:44 -0400
Received: from waste.org ([216.27.176.166]:62956 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261798AbVHEVmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:42:43 -0400
Date: Fri, 5 Aug 2005 14:42:24 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>,
       davem@davemloft.net
Subject: Re: [PATCH] netpoll can lock up on low memory.
Message-ID: <20050805214224.GW8074@waste.org>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain> <20050805141426.GU8266@wotan.suse.de> <1123252591.18332.45.camel@localhost.localdomain> <20050805200156.GF7425@waste.org> <20050805212610.GA8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805212610.GA8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:26:10PM +0200, Andi Kleen wrote:
> On Fri, Aug 05, 2005 at 01:01:57PM -0700, Matt Mackall wrote:
> > The netpoll philosophy is to assume that its traffic is an absolute
> > priority - it is better to potentially hang trying to deliver a panic
> > message than to give up and crash silently.
> 
> That would be ok if netpoll was only used to deliver panics. But 
> it is not. It delivers all messages, and you cannot hang the 
> kernel during that. Actually even for panics it is wrong, because often
> it is more important to reboot in a panic than (with a panic timeout) 
> to actually deliver the panic. That's needed e.g. in a failover cluster.
> 
> If that was the policy it would be a quite dumb one and make netpoll
> totally unsuitable for production use. I hope it is not.

Suggest you rip __GFP_NOFAIL out of JBD before complaining about this.

> Dave, can you please apply the timeout patch anyways?

Yes, let's go right over the maintainer's objections almost
immediately after he chimes into the thread. I'll spare the list the
colorful language this inspires.

-- 
Mathematics is the supreme nostalgia of our time.
