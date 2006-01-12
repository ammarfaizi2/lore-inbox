Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWALR0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWALR0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWALR0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:26:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62131 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932199AbWALR0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:26:08 -0500
Subject: Re: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
From: Adam Litke <agl@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20060112010502.GG9091@holomorphy.com>
References: <1137018263.9672.10.camel@localhost.localdomain>
	 <200601120040.k0C0ebg02818@unix-os.sc.intel.com>
	 <20060112010502.GG9091@holomorphy.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 12 Jan 2006 11:26:05 -0600
Message-Id: <1137086766.9672.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 17:05 -0800, William Lee Irwin III wrote:
> On Wed, Jan 11, 2006 at 04:40:37PM -0800, Chen, Kenneth W wrote:
> > What if two processes fault on the same page and races with find_lock_page(),
> > both find page not in the page cache.  The process won the race proceed to
> > allocate last hugetlb page.  While the other will exit with SIGBUS.
> > In theory, both processes should be OK.
> 
> This is supposed to fix the incarnation of that as a preexisting
> problem, but you're right, there is no fallback or retry for the case
> of hugepage queue exhaustion. For some reason I saw a phantom page
> allocator fallback in the hugepage allocator changes.
> 
> Looks like back to the drawing board for this pair of patches, though
> I'd be more than happy to get a solution to this.

I still think patch 1 (delayed zeroing) is a good thing to have.  It
will definitely improve performance for multi-threaded hugetlb
applications by avoiding unnecessary hugetlb page zeroing.  It also
shrinks the race window we have been talking about to a tiny fraction of
what it was.  This should ease the problem while we figure out a way to
handle the "last free page" case.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

