Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVIUOj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVIUOj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVIUOj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:39:26 -0400
Received: from gold.veritas.com ([143.127.12.110]:41395 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750999AbVIUOj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:39:26 -0400
Date: Wed, 21 Sep 2005 15:38:57 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Frank van Maarseveen <frankvm@frankvm.com>
cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <20050921121915.GA14645@janus>
Message-ID: <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 14:39:21.0512 (UTC) FILETIME=[41169280:01C5BEBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Frank van Maarseveen wrote:
> This fixes a post 2.6.11 regression in maintaining the mm->hiwater_* counters.

It would be a good idea to CC Christoph Lameter, who I believe was the
one who very intentionally moved most of these updates out to timer tick.
Is that significantly missing updates?

If it turns out that your patch is appropriate:

1. The change from tsk to mm is good (but not urgent 2.6.14 material).

2. You've missed the instance Dave Miller recently added in fs/compat.c.

3. If these are to be peppered back all over, then the places where
   total_vm changes and the places where rss changes are almost completely
   disjoint, so it's lazy to be calling one function to do both all over.

4. If you've noticed a regression, you must be one of the elite that knows
   what these counters are used for: nothing in the kernel.org tree does.
   Please add a comment saying what it is that uses them and how, so
   developers can make better judgements about how best to maintain them.

5. Please add appropriate CONFIG, dummy macros etc., so that no time
   is wasted on these updates in all the vanilla systems which have no
   interest in them - but maybe Christoph already has that well in hand.

Sorry for the rifle fire, you did put your head above the parapet!

Hugh
