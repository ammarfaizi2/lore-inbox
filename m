Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbUBFGWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 01:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUBFGWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 01:22:46 -0500
Received: from waste.org ([209.173.204.2]:18605 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266647AbUBFGWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 01:22:45 -0500
Date: Fri, 6 Feb 2004 00:22:35 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
Message-ID: <20040206062235.GK31138@waste.org>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel> <20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel> <p73isilkm4x.fsf@verdi.suse.de> <20040205190904.0cacd513.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205190904.0cacd513.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 07:09:04PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > Ken, I remain unhappy with this patch.  If a big box has 500 million
> > > dentries or inodes in cache (is possible), those hash chains will be more
> > > than 200 entries long on average.  It will be very slow.
> > 
> > How about limiting the global size of the dcache in this case ? 
> 
> But to what size?
> 
> The thing is, any workload which touches a huge number of dentries/inodes
> will, if it touches them again, touch them again in exactly the same order.
> This triggers the worst-case LRU behaviour.
> 
> So if you limit dcache to 100MB and you happen to have a workload which
> touches 101MB's worth, you get a 100% miss rate.  You suffer a 100000%
> slowdown on the second pass, which is unhappy.  It doesn't seem worth
> crippling such workloads just because of the updatedb thing.

A less strict approach to LRU might serve. Probabilistically dropping
something in the first half of the LRU rather than the head would go a
long way to gracefully degrading the "working set slightly larger than
cache" effect. There are a couple different ways to do this that are
reasonably efficient.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
