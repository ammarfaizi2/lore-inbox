Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTHTCw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 22:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbTHTCw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 22:52:58 -0400
Received: from dyn-ctb-210-9-246-104.webone.com.au ([210.9.246.104]:9989 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261566AbTHTCw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 22:52:56 -0400
Message-ID: <3F42E275.5010005@cyberone.com.au>
Date: Wed, 20 Aug 2003 12:52:37 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
References: <1061261666.2094.15.camel@orbiter> <3F419449.4070104@cyberone.com.au> <1061266033.2900.43.camel@orbiter> <3F41B43D.6000706@cyberone.com.au> <bhts76$8bm$1@gatekeeper.tmr.com>
In-Reply-To: <bhts76$8bm$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



bill davidsen wrote:

>In article <3F41B43D.6000706@cyberone.com.au>,
>Nick Piggin  <piggin@cyberone.com.au> wrote:
>| Eric St-Laurent wrote:
>
>| >
>| >Anyway i always tought linux default timeslice of 100 ms is way too long
>| >for desktop uses. Starting with this in mind, i think that a 10 ms
>| >timeslice should bring back good interactive feel, and by using longer
>| >timeslices for (lower prio) cpu-bound processes, we can save some costly
>| >context switches.
>| >
>| 
>| I agree completely.
>| 
>| >
>| >Unfortunatly i'm unable to test those ideas right now but i share them,
>| >maybe it can help other's work.
>| >
>| >- (previously mentionned) higher prio tasks should use small timeslices
>| >and lower prio tasks, longer ones. i think, maybe falsely, that this can
>| >lower context switch rate for cpu-bound tasks. by using up to 200 ms
>| >slices instead of 10 ms...
>| >
>| >- (previously mentionned) use dynamic priority to calculate timeslice
>| >length.
>| >
>| >- maybe adjust the max timeslice length depending on how many tasks are
>| >running/ready.
>| >
>| 
>| I agree with your previous two points. Not this one. I think it is very
>| easy to get bad feedback loops and difficult to ensure it doesn't break
>| down under load when doing stuff like this. I might be wrong though.
>
>I have to agree with Eric that sizing the max timeslices to fit the
>hardware seems like a reasonable thing to do. I have little salvaged
>systems running (well strolling would be more accurate) Linux on old
>Pentium Classic 90-166MHz machines. I also have 3+ GHz SMP machines. I
>have a gut feeling that the timeslices need to be longer on the slow
>machines to allow them to get something done, that the SMP machines
>will perform best with a different timeslice than UP of the same speed,
>etc.
>

Well its just so hard to get right. If someone could demonstrate a
big performance improvement, then the scheduler might need fixing
anyway.

For example, on your machines, its very likely that your new machines
would benefit more from big timeslices than the old ones due to more
cache, quicker cpu to memory, multiple cpus...


