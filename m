Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbULKGDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbULKGDd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 01:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbULKGDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 01:03:33 -0500
Received: from holomorphy.com ([207.189.100.168]:3223 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261832AbULKGD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 01:03:28 -0500
Date: Fri, 10 Dec 2004 22:03:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, clameter@sgi.com, torvalds@osdl.org,
       benh@kernel.crashing.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pfault V12 : correction to tasklist rss
Message-ID: <20041211060312.GV2714@holomorphy.com>
References: <Pine.LNX.4.58.0412101150490.9169@schroedinger.engr.sgi.com> <Pine.LNX.4.44.0412102054190.32422-100000@localhost.localdomain> <20041210133859.2443a856.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210133859.2443a856.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>>> We have no  real way of establishing the ownership of shared pages
>>> anyways. Its counted when allocated. But the page may live on afterwards
>>> in another process and then not be accounted for although its only user is
>>> the new process.

On Fri, Dec 10, 2004 at 01:38:59PM -0800, Andrew Morton wrote:
> We did lose some accounting accuracy when the pagetable walk and the big
> tasklist walks were removed.  Bill would probably have more details.  Given
> that the code as it stood was a complete showstopper, the tradeoff seemed
> reasonable.

There are several issues, not listed in order of importance here:
(1) Workload monitoring with high multiprogramming levels was infeasible.
(2) The long address space walks interfered with mmap() and page
	faults in the monitored processes, disturbing cluster membership
	and exceeding maximum response times in monitored workloads.
(3) There's a general long-running ongoing effort to take on various
	places tasklist_lock is abused one-by-one to incrementally
	resolve or otherwise mitigate the rwlock starvation issues.


-- wli
