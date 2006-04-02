Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWDBJMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWDBJMz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDBJMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:12:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:34950 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932078AbWDBJMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:12:55 -0400
Date: Sun, 2 Apr 2006 14:44:37 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures dynamically
Message-ID: <20060402091437.GB13423@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060401185644.GC25971@in.ibm.com> <442F2B52.6000205@yahoo.com.au> <20060402050400.GA13423@in.ibm.com> <442F5F51.3030104@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442F5F51.3030104@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 03:21:21PM +1000, Nick Piggin wrote:
> Then after you have allocated sched_group_phys, subsequent cpus
> in cpu_map will have their sched_group_phys_bycpu[] entry
> uninitialised, by the looks?

Not all the CPUs in cpu_map need to have an entry in 
sched_group_phys_bycpu[]. sched_group_phys_bycpu[] is purely used to
"remember" the chunk of memory we allocated for sched_group array
for later freeing. Individual CPU's in cpu_map point to a suitable entry 
in the sched_group array (thr' their phys_domains structure), as in the 
following lines of code after memory allocation:

	sd = &per_cpu(phys_domains, i);

	...

	sd->groups = &sched_group_phys[group];


Hope this clarifies!

-- 
Regards,
vatsa
