Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbVD2VE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVD2VE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVD2VDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:03:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:30628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262407AbVD2VCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:02:41 -0400
Date: Fri, 29 Apr 2005 22:02:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 3/3] Page Fault Scalability V20: Avoid lock for anonymous write fault
Message-ID: <20050429210240.GA14774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-ia64@vger.kernel.org
References: <20050429195901.15694.28520.sendpatchset@schroedinger.engr.sgi.com> <20050429195917.15694.21053.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429195917.15694.21053.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 12:59:17PM -0700, Christoph Lameter wrote:
> Do not use the page_table_lock in do_anonymous_page. This will significantly
> increase the parallelism in the page fault handler for SMP systems. The patch
> also modifies the definitions of _mm_counter functions so that rss and anon_rss
> become atomic (and will use atomic64_t if available).

I thought we said all architectures should provide an atomic64_t (and
given that it's not actually 64bit on 32bit architecture we should
probably rename it to atomic_long_t)

