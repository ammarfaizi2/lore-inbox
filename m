Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVIWIL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVIWIL2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVIWIL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:11:27 -0400
Received: from ozlabs.org ([203.10.76.45]:19658 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750802AbVIWIL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:11:26 -0400
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, kiran@scalex86.org, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050923.001729.101033164.davem@davemloft.net>
References: <20050923062529.GA4209@localhost.localdomain>
	 <20050923001013.28b7f032.akpm@osdl.org>
	 <20050923.001729.101033164.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 18:11:30 +1000
Message-Id: <1127463090.796.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-23 at 00:17 -0700, David S. Miller wrote:
> I'm still against expanding these networking datastructures with
> bigrefs just for this stuff.  Some people have per-cpu and per-node on
> the brain, and it's starting to bloat things up a little bit too much.

I think for net devices it actually makes sense; most of the time we are
not trying to remove them, so the refcounting is simply overhead.  We
also don't alloc and free them very often.  The size issue is not really
an issue since we only map for each CPU, and even better: if a bigref
allocation can't get per-cpu data it just degrades beautifully into a
test and an atomic.

Now, that said, I wanted (and wrote, way back when) a far simpler
allocator which only worked for GFP_KERNEL and used the same
__per_cpu_offset[] to fixup dynamic per-cpu ptrs as static ones.  Maybe
not as "complete" as this one, but maybe less offensive.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

