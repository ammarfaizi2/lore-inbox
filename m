Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWAEVWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWAEVWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWAEVWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:22:11 -0500
Received: from hera.kernel.org ([140.211.167.34]:33154 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932220AbWAEVWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:22:10 -0500
Date: Thu, 5 Jan 2006 17:21:56 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 09/16] mm: remove unnecessary variable and loop
Message-ID: <20060105192156.GA12589@dmt.cnet>
References: <20051207104755.177435000@localhost.localdomain> <20051207105106.887005000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051207105106.887005000@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 06:48:04PM +0800, Wu Fengguang wrote:
> shrink_cache() and refill_inactive_zone() do not need loops.
> 
> Simplify them to scan one chunk at a time.

Hi Wu,

What is the purpose of scanning large chunks at a time?

Some drawbacks that I can think of by doing that:

- zone->lru_lock will be held for much longer periods, resulting in
decreased responsiveness and possibly slowdowns.

- if the task doing the scan is uncapable of certain operations, for
instance IO, dirty pages will be moved back to the head of the inactive
list in much larger batches then they were before. This could hurt
reclaim in general.

What were the results of this change? Particularly contention on the
lru_lock on medium-large SMP systems.

Thanks!
