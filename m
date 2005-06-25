Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263350AbVFYGmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbVFYGmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 02:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbVFYGmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 02:42:11 -0400
Received: from dvhart.com ([64.146.134.43]:25778 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S263350AbVFYGmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 02:42:07 -0400
Date: Fri, 24 Jun 2005 23:42:12 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <44570000.1119681732@[10.10.2.4]>
In-Reply-To: <20050625040052.GB4800@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu> <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu> <344410000.1119646572@flay> <20050625040052.GB4800@elte.hu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Ingo Molnar <mingo@elte.hu> wrote (on Saturday, June 25, 2005 06:00:52 +0200):

> 
> * Martin J. Bligh <Martin.Bligh@us.ibm.com> wrote:
> 
>> > is the only problem the unsyncedness? That should be fine as far as the 
>> > scheduler is concerned. (we compensate for per-CPU drifts)
>> 
>> Well, I think so. But I don't see how you're going to compensate for 
>> large-scale unsynced-ness safely. I've always completely avoided the 
>> TSC altogether on NUMA-Q ... would prefer to keep it that way. We got 
>> lots of wierd random crashes, panics, hangs, and -ve time offsets 
>> returned from userspace time commands last time I tried it.
> 
> ok. Would be nice to check whether reverting that single change solves 
> the boot problem. If it does i'll switch the measurement method to be 
> do_gettimeoffset based, that way the measurement will still be accurate.  
> (which is needed for precise migration cost results) Right now the 
> calibration uses sched_clock() - which was the reason for the change.

OK, will test that.

> (btw., if the TSC is that unreliable on numaq boxes, shouldnt we disable 
> it for userspace apps too? Or are those hangs purely kernel bugs? In 
> which case it might make sense to debug those a bit more - large-scale 
> TSC unsyncedness is something that could slip in on other hardware too.)

Well it reads reliably. it just reliably reads utter random crap (well,
across CPUs). Not many things read tsc from userspace, and it won't hang
I guess .... depends what their expecations are. I do like gettimeofday
not to go backwards though - that tends to bugger things up ;-)

M.

