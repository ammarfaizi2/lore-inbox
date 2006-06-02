Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWFBNRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWFBNRD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFBNRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:17:03 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:64719 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751398AbWFBNRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:17:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] smt nice introduces significant lock contention
Date: Fri, 2 Jun 2006 23:16:39 +1000
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Chris Mason'" <mason@suse.com>, Ingo Molnar <mingo@elte.hu>
References: <000201c6861f$6a2d4e20$0b4ce984@amr.corp.intel.com> <447FFD35.9020909@yahoo.com.au> <200606022030.11481.kernel@kolivas.org>
In-Reply-To: <200606022030.11481.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606022316.41139.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 20:30, Con Kolivas wrote:
> On Friday 02 June 2006 18:56, Nick Piggin wrote:
> > And why do we lock all siblings in the other case, for that matter? (not
> > that it makes much difference except on niagara today).
>
> If we spinlock (and don't trylock as you're proposing) we'd have to do a
> double rq lock for each sibling. I guess half the time double_rq_lock will
> only be locking one runqueue... with 32 runqueues we either try to lock all
> 32 or lock 1.5 runqueues 32 times... ugh both are ugly.

Thinking some more on this it is also clear that the concept of per_cpu_gain  
for smt is basically wrong once we get beyond straight forward 2 thread 
hyperthreading. If we have more than 2 thread units per physical core, the 
per cpu gain per logical core will decrease the more threads are running on 
it. While it's always been obvious the gain per logical core is entirely 
dependant on the type of workload and wont be a simple 25% increase in cpu 
power, it is clear that even if we assume an "overall" increase in cpu for 
each logical core added, there will be some non linear function relating 
power increase to thread units used. :-|

-- 
-ck
