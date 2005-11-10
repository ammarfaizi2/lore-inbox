Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVKJJR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVKJJR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVKJJR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:17:57 -0500
Received: from smtp.nedstat.nl ([194.109.98.184]:19141 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S1750715AbVKJJR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:17:56 -0500
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
Subject: Re: [PATCH 01/16] mm: delayed page activation
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, riel@redhat.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051109141432.393114000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
	 <20051109141432.393114000@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:17:44 +0100
Message-Id: <1131614264.14052.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 21:49 +0800, Wu Fengguang wrote:
> plain text document attachment (mm-delayed-activation.patch)
> When a page is referenced the second time in inactive_list, mark it with
> PG_activate instead of moving it into active_list immediately. The actual
> moving work is delayed to vmscan time.
> 
> This implies two essential changes:
> - keeps the adjecency of pages in lru;
> - lifts the page reference counter max from 1 to 3.
> 
> And leads to the following improvements:
> - read-ahead for a leading reader will not be disturbed by a following reader;
> - enables the thrashing protection logic to save pages for following readers;
> - keeping relavant pages together helps improve I/O efficiency;
> - and also helps decrease vm fragmantation;
> - increased refcnt space might help page replacement algorithms.

I'm working on a clockpro implementation that essentialy keeps all
resident pages on 1 clock. In this case readahead pages will also not
fragment over the active/inactive lists but stay in order. Would that
also satisfy your requirements?

Code can be found at:
  http://programming.kicks-ass.net/kernel-patches/clockpro-2/

Note however that this is work in progress and rather unstable, there
are some livelock scenarios in there.

Kind regards,

Peter Zijlstra


