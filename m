Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWALBF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWALBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWALBF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:05:28 -0500
Received: from holomorphy.com ([66.93.40.71]:52688 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S964915AbWALBF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:05:27 -0500
Date: Wed, 11 Jan 2006 17:05:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Adam Litke'" <agl@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
Message-ID: <20060112010502.GG9091@holomorphy.com>
References: <1137018263.9672.10.camel@localhost.localdomain> <200601120040.k0C0ebg02818@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601120040.k0C0ebg02818@unix-os.sc.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:40:37PM -0800, Chen, Kenneth W wrote:
> What if two processes fault on the same page and races with find_lock_page(),
> both find page not in the page cache.  The process won the race proceed to
> allocate last hugetlb page.  While the other will exit with SIGBUS.
> In theory, both processes should be OK.

This is supposed to fix the incarnation of that as a preexisting
problem, but you're right, there is no fallback or retry for the case
of hugepage queue exhaustion. For some reason I saw a phantom page
allocator fallback in the hugepage allocator changes.

Looks like back to the drawing board for this pair of patches, though
I'd be more than happy to get a solution to this.


-- wli
