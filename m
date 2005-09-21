Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbVIUUG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbVIUUG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIUUG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:06:59 -0400
Received: from gold.veritas.com ([143.127.12.110]:11840 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751408AbVIUUG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:06:58 -0400
Date: Wed, 21 Sep 2005 21:06:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>, Jay Lan <jlan@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <Pine.LNX.4.62.0509211246490.11619@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0509212053050.11309@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0509211246490.11619@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 20:06:54.0006 (UTC) FILETIME=[02E32D60:01C5BEE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Christoph Lameter wrote:
> On Wed, 21 Sep 2005, Hugh Dickins wrote:
> 
> Looks like this is staying off the critical code paths. So ok.

Great, thanks.

> > I'm also rearranging the rss,anon_rss accounting.  Maybe come back
> > to the hiwaters later on?
> 
> I'd be very interested to see the rearrangement.

Sorry, you'll be imagining something much grander than I meant.
And sorry, I have to work my way through splitting it out from
the total and then posting, can't cut it out for you right now.

But all I was meaning was, as part of the preparatory patches for
the narrowed and split page_table_lock, not included in last month's
prototype, I'm (a) switching to file_rss plus anon_rss rather than rss
including anon_rss, as we discussed earlier (you believe the SGI boxes
won't need that, but in general it seems silly to be doing two atomic
updates instead of one); and (b) moving the "freed" rss updating up
from inside the "tlb" operations (the prototype patch had the wrong
locking for that); and (c) batching the updates (i.e. one add or sub
instead of many incs or decs) per-page_table-page in copy_pte_range
as in zap_pte_range.

I don't expect you to disagree with it; but nor do I expect you
to be anything but disappointed, realizing that's all I meant.

Hugh
