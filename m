Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUJJKKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUJJKKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 06:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUJJKKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 06:10:24 -0400
Received: from [203.124.158.219] ([203.124.158.219]:42112 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S268214AbUJJKKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 06:10:15 -0400
Subject: Re: [RFC] [PATCH] Performance of del_single_shot_timer_sync
From: shobhit dayal <shobhit@calsoftinc.com>
Reply-To: shobhit@calsoftinc.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041008101949.49cda1a8.akpm@osdl.org>
References: <1097242659.11717.483.camel@kuber>
	 <20041008101949.49cda1a8.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097404176.11717.510.camel@kuber>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 10 Oct 2004 15:59:36 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2004-10-08 at 22:49, Andrew Morton wrote:
> shobhit dayal <shobhit@calsoftinc.com> wrote:
> > 
> > del_timer_sync was responsible for about 2% of all remote memory
> > accesses on the system and came up as part of the top 10 functions who
> > were doing this. On top was schedule(7.52%) followed by
> > default_wake_function(2.79%). Rest every one in the top 10 were
> > around the range of 2%.
> > 
> > After the patch it never came up in the logs again( so less than 0.5% of
> > all faulting eip's).
> > 
> 
> And what is the overall improvement from the del_timer_sync speedup patch? 
> I mean: overall runtime and CPU time improvements for a
> relatively-real-world benchmark?
> 

I have Geoff's figures 

Before:             32p     4p
     Warm cache   29,000    505
     Cold cache   37,800   1220

After:              32p     4p
     Warm cache       95     88
     Cold cache    1,800    140
[Measurements are CPU cycles spent in a call to del_timer_sync, the average
of 1000 calls. 32p is 16-node NUMA, 4p is SMP.]

These figures, would apply for the case for where del_timer_sync does get called from del_single_shot_timer_sync.
That is del_singe_shot_timer_sync gets called after timer has expired

For my profiling workload i used the standard pg_regress module from the postgres installation and noticed that
the ratio of calls to del_single_shot_timer_sync after expiry to before expiry was 10:1. over 11000 calls to
del_single_shot_timer_sync.

regards
shobhit

