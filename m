Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTIOFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 01:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbTIOFG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 01:06:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39672 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262436AbTIOFG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 01:06:27 -0400
Date: Mon, 15 Sep 2003 10:43:11 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       arjanv@redhat.com
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
Message-ID: <20030915051308.GA1159@llm08.in.ibm.com>
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com> <20030912085921.GB1128@llm08.in.ibm.com> <3F6378B0.8040606@colorfullife.com> <20030914080942.GA9302@in.ibm.com> <20030914130037.GA1781@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914130037.GA1781@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 06:30:37PM +0530, Dipankar Sarma wrote:
> 
> While we are at it, we should also probably look up the cache line
> size for a cpu family from a table, store it in some per-cpu data
> (cpuinfo_x86 ?) and provide an l1_cache_bytes() api to
> return it at run time.

If we are going to solve the cache line size mismatch due to compile 
time arch versus run time arch (compiling on a PIII and running on a P4), 
we might end up with kernel code which sometimes refer to the static line size 
and sometimes to the run time size, which might cause correctness issues.  
So maybe it is good idea to have just one macro for l1 size?  We can't
do away with the static one, so maybe we should keep it and expect users
to compile with the target cpu properly set (otherwise they lose out on
performance -- correctness won't be a problem).  I could be wrong...just
thinking out loud...

Thanks,
Kiran
