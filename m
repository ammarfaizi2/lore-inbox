Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWCIFi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWCIFi5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWCIFi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:38:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932666AbWCIFi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:38:56 -0500
Date: Wed, 8 Mar 2006 21:38:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603082127110.32577@g5.osdl.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
 <20060308184500.GA17716@devserv.devel.redhat.com>
 <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com>
 <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com>
 <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com>
 <14275.1141844922@warthog.cambridge.redhat.com> <19984.1141846302@warthog.cambridge.redhat.com>
 <17423.30789.214209.462657@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org>
 <17423.32792.500628.226831@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
 <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, Paul Mackerras wrote:
> 
> A spin_lock does show up on the bus, doesn't it?

Nope.

If the lock entity is in a exclusive cache-line, a spinlock does not show 
up on the bus at _all_. It's all purely in the core. In fact, I think AMD 
does a spinlock in ~15 CPU cycles (that's the serialization overhead in 
the core). I think a P-M core is ~25, while the NetBurst (P4) core is much 
more because they have horrible serialization issues (I think it's on the 
order of 100 cycles there).

Anyway, try doing a spinlock in 15 CPU cycles and going out on the bus for 
it..

(Couple that with spin_unlock basically being free).

Now, if the spinlocks end up _bouncing_ between CPU's, they'll obviously 
be a lot more expensive.

		Linus
