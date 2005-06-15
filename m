Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVFOFZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVFOFZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVFOFZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:25:41 -0400
Received: from holomorphy.com ([66.93.40.71]:36264 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261494AbVFOFZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:25:34 -0400
Date: Tue, 14 Jun 2005 22:25:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "liyu@WAN" <liyu@ccoss.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: one question about LRU mechanism
Message-ID: <20050615052530.GA3913@holomorphy.com>
References: <1118812376.32766.4.camel@liyu.ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118812376.32766.4.camel@liyu.ccoss.com.cn>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 01:12:56PM +0800, liyu@WAN wrote:
> 	I am reading memory managment code of kernel 2.6.11.11.
> I found LRU is implement as linked-stack in linux, include two important
> data structure linked-list :
> zone->active_list and zone->inactive_list. when kernel need reclaim some
> pages, it will call function refiil_inactive_list() ultimately to move
> some page from active_list to inactive_list.

The "LRU" bits there don't actually describe the homebrew algorithm.


On Wed, Jun 15, 2005 at 01:12:56PM +0800, liyu@WAN wrote:
> 	It's OK, but I have one question in my mind:
> I found all function that append page to active_list, it just append
> page to head of active_list (use inline function list_add() ), but
> refill_inactive_list() also start scanning from head of active_list, I
> think the better way scan active_list is start from rear of active_list
> and scan though prev member of list_head at reclaim pages. Scanning
> start from head of active_list may make thrashing more possibly, I
> think. and, in my view, "head of active_list" is zone->active_list,
> "rear of active_list" is zone->active_list.prev .
> 	May be, I am failed understand mm? or what's wrong?

I'm looking at 2.6.12-rc6-mm1.

As far as I can tell new active pages are added to the ->next component
of the head of the active list in lru_cache_add_active() and the ->next
component of the head of the inactive list in lru_cache_add(). Then
isolate_lru_pages() dequeues from ->prev of the head of the inactive
list in shrink_cache() and isolate_lru_pages() dequeues from the ->prev
of the active list in refill_inactive_zone().


-- wli
