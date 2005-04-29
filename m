Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbVD2XHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVD2XHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVD2XHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:07:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:16029 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263040AbVD2XHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 19:07:12 -0400
Date: Fri, 29 Apr 2005 16:06:59 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 3/3] Page Fault Scalability V20: Avoid lock for anonymous
 write fault
In-Reply-To: <20050429210240.GA14774@infradead.org>
Message-ID: <Pine.LNX.4.58.0504291600500.16690@schroedinger.engr.sgi.com>
References: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com>
 <20050429195917.15694.21053.sendpatchset@schroedinger.engr.sgi.com>
 <20050429210240.GA14774@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Christoph Hellwig wrote:

> On Fri, Apr 29, 2005 at 12:59:17PM -0700, Christoph Lameter wrote:
> > Do not use the page_table_lock in do_anonymous_page. This will significantly
> > increase the parallelism in the page fault handler for SMP systems. The patch
> > also modifies the definitions of _mm_counter functions so that rss and anon_rss
> > become atomic (and will use atomic64_t if available).
>
> I thought we said all architectures should provide an atomic64_t (and
> given that it's not actually 64bit on 32bit architecture we should
> probably rename it to atomic_long_t)

Yes the way atomic types are provided may need a revision.
First of all we need atomic types that are size bound

	atomic8_t
	atomic16_t
	atomic32_t

and (if available)

	atomic64_t

and then some aliases

	atomic_t -> atomic type for int
	atomic_long_t -> atomic type for long

If these types are available then this patch could be cleaned up to
just use atomic_long_t.
