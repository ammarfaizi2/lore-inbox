Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268239AbTCFTUW>; Thu, 6 Mar 2003 14:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTCFTUW>; Thu, 6 Mar 2003 14:20:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42769 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268239AbTCFTUV>; Thu, 6 Mar 2003 14:20:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: HT and idle = poll
Date: Thu, 6 Mar 2003 19:30:42 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b487l2$1tn$1@penguin.transmeta.com>
References: <200303052318.04647.habanero@us.ibm.com>
X-Trace: palladium.transmeta.com 1046979049 4380 127.0.0.1 (6 Mar 2003 19:30:49 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Mar 2003 19:30:49 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200303052318.04647.habanero@us.ibm.com>,
Andrew Theurer  <habanero@us.ibm.com> wrote:
>The test:  kernbench (average of  kernel compiles5) with -j2 on a 2 physical/4 
>logical P4 system.  This is on 2.5.64-HTschedB3:
>
>idle != poll: Elapsed: 136.692s User: 249.846s System: 30.596s CPU: 204.8%
>idle  = poll: Elapsed: 161.868s User: 295.738s System: 32.966s CPU: 202.6%
>
>A 15.5% increase in compile times.
>
>So, don't use idle=poll with HT when you know your workload has idle time!  I 
>have not tried oprofile, but it stands to reason that this would be a 
>problem.  There's no point in using idle=poll with oprofile and HT anyway, as 
>the cpu utilization is totally wrong with HT to begin with (more on that 
>later).
>
>Presumably a logical cpu polling while idle uses too many cpu resources 
>unnecessarily and significantly affects the performance of its sibling. 

Btw, I think this is exactly what the new HT prescott instructions are
for: instead of having busy loops polling for a change in memory (be it
a spinlock or a "need_resched" flag), new HT CPU's will support a
"mwait" instruction. 

But yes, at least for now, I really don't think you should really _ever_
use "idle=poll" on HT-enabled hardware. The idle CPU's will just suck
cycles from the real work.

		Linus
