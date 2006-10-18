Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWJRSJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWJRSJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWJRSJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:09:56 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:53590 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422746AbWJRSJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:09:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lmdLKau+6EaZskQ5binMzCXl53qvnN7hlB82LMYRBBnrqwNiZSE0oJm/NaDG8SEOkOlMd6ljU9lHBP+rnYAd6OmAVuqwJCgLpwMU9i5MmtqXY188WienScArSNSrJVy1Tb1w/YChqSKsdlvgjLOxvSwkZh0KuPV73J4YUYkKaLs=  ;
Message-ID: <45366DF0.6040702@yahoo.com.au>
Date: Thu, 19 Oct 2006 04:09:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com> <4536629C.4050807@yahoo.com.au> <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610181059570.28750@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>>After that, it might be acceptable to call rebalance_tick from a tasklet,
>>although it would be uneeded overhead on small systems. It might be better
> 
> 
> Here is a patch that only runs rebalance tick from a tasklet in the 
> scheduler. For UP there will be no tasklet.
> 
> [RFC] sched_rebalance_tick with interrupts enabled
> 
> scheduler_tick() has the potential of running for some time if f.e.
> sched_domains for a system with 1024 processors have to be balanced.
> We currently do all of that with interrupts disabled. So we may be unable
> to service interrupts for some time. Most of that time is potentially
> spend in rebalance_tick.
> 
> This patch splits off rebalance_tick from scheduler_tick and schedules
> it via a tasklet.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

wake_priority_sleeper should not be called from rebalance_tick. That
code was OK where it was before, I think.

And you need to now turn off interrupts when doing the locking in
load_balance.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
