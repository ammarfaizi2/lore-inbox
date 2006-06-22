Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030643AbWFVQiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbWFVQiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWFVQiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:38:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41885 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030643AbWFVQiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:38:13 -0400
Date: Thu, 22 Jun 2006 09:37:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/6] mm: remove some update_mmu_cache() calls
In-Reply-To: <Pine.LNX.4.64.0606221646000.4977@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606220935130.28760@schroedinger.engr.sgi.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
 <20060619175347.24655.67680.sendpatchset@lappy>
 <Pine.LNX.4.64.0606221646000.4977@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Hugh Dickins wrote:

> The answer I expect is that update_mmu_cache is essential there in
> do_wp_page (reuse case) and handle_pte_fault, on at least some if
> not all of those arches which implement it.  That without those
> lines, they'll fault and refault endlessly, since the "MMU cache"
> has not been updated with the write permission.

Yes a likely scenario.
 
> But omitted from mprotect, since that's dealing with a batch of
> pages, perhaps none of which will be faulted in the near future:
> a waste of resources to update for all those entries.

So we intentially allow mprotect to be racy?

> But now I wonder, why does do_wp_page reuse case flush_cache_page?

Some arches may have virtual caches?
