Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUFWWba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUFWWba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUFWWaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:30:17 -0400
Received: from holomorphy.com ([207.189.100.168]:48005 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263184AbUFWW2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:28:37 -0400
Date: Wed, 23 Jun 2004 15:28:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [3/4] track wired pages on a per-zone basis
Message-ID: <20040623222832.GF1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.Wa3a0aIbWaLbXaJbIb1a1aLbKb2aKb2a3aYaJbYa3a1a4aJbKbWa4a0a4a4aWaHb342@holomorphy.com> <0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com> <20040623151536.023404fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623151536.023404fc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  	struct per_cpu_pageset	pageset[NR_CPUS];
>> +	unsigned long		nr_wired[NR_CPUS];

On Wed, Jun 23, 2004 at 03:15:36PM -0700, Andrew Morton wrote:
> These will share cachelines of course, so the percpuification won't be very
> effective.  I wonder if there's some way in which the nr_wired accounting
> can be batched up and then dumped into a single per-zone counter when we
> have the zone->lru_lock.

It's difficult to anticipate the number of zones required for a per-cpu
data structure to be periodically resynched with the zones. The
counters, both global and per-zone are purely for reporting purposes
and have no impact on functionality in this series.


On Wed, Jun 23, 2004 at 03:15:36PM -0700, Andrew Morton wrote:
> How come there are all those PageWired() tests in the LRU manipulation
> functions?

Largely for the benefit of ramfs. As you pointed out, rd.c's blkdev
pagecache requires similar treatment. The net effect of these is that
wired pagecache pages don't appear on the LRU at all. This makes the
assumption that all wired pagecache is memory-backed and never needs
to be written to its backing store, which AFAICT is true in all cases.


-- wli
