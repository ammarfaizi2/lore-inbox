Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVIWLmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVIWLmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 07:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIWLmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 07:42:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6042 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750887AbVIWLmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 07:42:25 -0400
Date: Fri, 23 Sep 2005 17:06:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org, kiran@scalex86.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
Message-ID: <20050923113636.GB5006@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050923062529.GA4209@localhost.localdomain> <20050923001013.28b7f032.akpm@osdl.org> <20050923.001729.101033164.davem@davemloft.net> <1127463090.796.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127463090.796.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 06:11:30PM +1000, Rusty Russell wrote:
> On Fri, 2005-09-23 at 00:17 -0700, David S. Miller wrote:
> > I'm still against expanding these networking datastructures with
> > bigrefs just for this stuff.  Some people have per-cpu and per-node on
> > the brain, and it's starting to bloat things up a little bit too much.
> 
> I think for net devices it actually makes sense; most of the time we are
> not trying to remove them, so the refcounting is simply overhead.  We
> also don't alloc and free them very often.  The size issue is not really
> an issue since we only map for each CPU, and even better: if a bigref
> allocation can't get per-cpu data it just degrades beautifully into a
> test and an atomic.

I agree, given that it is for a much smaller number of refcounted
objects.

> 
> Now, that said, I wanted (and wrote, way back when) a far simpler
> allocator which only worked for GFP_KERNEL and used the same
> __per_cpu_offset[] to fixup dynamic per-cpu ptrs as static ones.  Maybe
> not as "complete" as this one, but maybe less offensive.

The GFP_ATOMIC support stuff is needed only for dst entries. However
using per-cpu refcounters in such objects like dentries and dst entries
are problematic and that is why I hadn't tried changing those.
Some of the earlier versions of the allocator were simpler and I think
we need to roll this back and do some more analysis. No GFP_ATOMIC
support, no early use. I haven't got around to look at this 
for a while, but I will try.

Thanks
Dipankar
