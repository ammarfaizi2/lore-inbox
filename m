Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVLKTBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVLKTBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVLKTBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:01:47 -0500
Received: from hera.kernel.org ([140.211.167.34]:40932 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750767AbVLKTBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:01:47 -0500
Date: Sun, 11 Dec 2005 16:32:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [RFC 3/6] Make nr_pagecache a per zone counter
Message-ID: <20051211183241.GD4267@dmt.cnet>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005456.3887.94412.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051210005456.3887.94412.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 04:54:56PM -0800, Christoph Lameter wrote:
> Make nr_pagecache a per node variable
> 
> Currently a single atomic variable is used to establish the size of the page cache
> in the whole machine. The zoned VM counters have the same method of implementation
> as the nr_pagecache code. Remove the special implementation for nr_pagecache and make
> it a zoned counter. We will then be able to figure out how much of the memory in a
> zone is used by the pagecache.
> 
> Updates of the page cache counters are always performed with interrupts off.
> We can therefore use the __ variant here.

By the way, why does nr_pagecache needs to be an atomic variable on UP systems?

#ifdef CONFIG_SMP
...
#else

static inline void pagecache_acct(int count)
{
        atomic_add(count, &nr_pagecache);
}
#endif

