Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUFPQ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUFPQ1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264117AbUFPQ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:27:54 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32015 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264124AbUFPQ1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:27:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Date: Wed, 16 Jun 2004 12:25:11 -0400
User-Agent: KMail/1.6.2
Cc: Dimitri Sivanich <sivanich@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20040616142413.GA5588@sgi.com> <20040616160355.GA5963@sgi.com> <20040616160714.GA14413@infradead.org>
In-Reply-To: <20040616160714.GA14413@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406161225.11946.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 16, 2004 12:07 pm, Christoph Hellwig wrote:
> Well, if you want deterministic interrupt latencies you should go for a
> realtime OS.

Although I don't want to see another kernel thread added as much as the next 
guy, I think that minimizing the amount of time that irqs are turned off is 
probably a good thing in general.  For example, the patch to allow interrupts 
in spin_lock_irq if the lock is already taken is generally a really good 
thing, because even though reducing lock contention should be a goal, locks 
by their very nature are taken sometimes, and allowing other CPUs to get 
useful work done while they're waiting for it is obviously desirable.

> I know Linux is the big thing in the industry, but you're 
> really better off looking for a small Hard RT OS. 

Sure, for some applications, an RTOS is necessary.  But it seems like keeping 
latencies down in Linux is a good thing to do nonetheless.

Can you think of other ways to reduce the length of time that interrupts are 
disabled during cache reaping?  It seems like the cache_reap loop might be a 
candidate for reorganization (though that would probably imply other 
changes).

Thanks,
Jesse
