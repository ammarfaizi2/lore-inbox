Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVI2Xjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVI2Xjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVI2Xjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:39:37 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:59607 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751376AbVI2Xjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:39:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] vm - swap_prefetch v12
Date: Fri, 30 Sep 2005 09:42:28 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200509300115.33060.kernel@kolivas.org> <200509300912.58722.kernel@kolivas.org> <20050929162402.71eee9c2.akpm@osdl.org>
In-Reply-To: <20050929162402.71eee9c2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509300942.28843.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005 09:24 am, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > On Fri, 30 Sep 2005 07:54 am, Andrew Morton wrote:
> > > Con Kolivas <kernel@kolivas.org> wrote:
> > > > Once pages have been added to the swapped list, a timer is started,
> > > > testing for conditions suitable to prefetch swap pages every 5
> > > > seconds. Suitable conditions are defined as lack of swapping out or
> > > > in any pages, and no watermark tests failing. Significant amounts of
> > > > dirtied ram also prevent prefetching. It then checks that we have
> > > > spare ram looking for at least 3* pages_high free per zone and if it
> > > > succeeds that will prefetch pages from swap.
> > >
> > > Did you consider poking around in gendisk.disk_stats to determine
> > > whether the swap disk(s) are idleish?
> >
> > I didn't know where to look for that info. Thanks! I'm open to *any*
> > suggestions and I'll look into it as I can't take this code much further
> > without outside help.
>
> Might also be able to utilise CFQ's I/O priorities.  That should be more
> efective than a heuristic based on disk_stats, however you'd probably need
> to work out whether the swapdev actually supports IO priorities and I'm not
> sure how one would query that (cleanly).

Good idea. It should be easy to simply add the ioprio value to the kprefetchd 
thread and it either supports it or it doesn't depending on what iosched is 
being used. 

Further to your original suggestion, prefetching is already delayed when any 
non-prefetch related swap in or out is occurring already so checking 
diskstats is probably not going to add to that for swap activity. However I 
assume it (diskstats) could also be used for all disk i/o as well? Currently 
a lot of dirty data can tell me that lots of writing is happening but I have 
no way of checking that lots of reads are occurring.

Cheers,
Con
