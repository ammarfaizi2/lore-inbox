Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275317AbTHSDG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275318AbTHSDG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:06:59 -0400
Received: from dyn-ctb-203-221-74-179.webone.com.au ([203.221.74.179]:58628
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S275317AbTHSDG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:06:57 -0400
Message-ID: <3F419449.4070104@cyberone.com.au>
Date: Tue, 19 Aug 2003 13:06:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Eric St-Laurent <ericstl34@sympatico.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
References: <1061261666.2094.15.camel@orbiter>
In-Reply-To: <1061261666.2094.15.camel@orbiter>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric St-Laurent wrote:

>currently, nicer tasks (nice value toward -20) get larger timeslices,
>and less nice tasks (nice value toward 19) get small timeslices.
>

Funny, isn't it!

>
>this is contrary to all process scheduling theory i've read, and also
>contrary to my intuition.
>

Yep.

>
>maybe it was done this way for fairness reasons, but that's another
>story...
>
>high priority (interactive) tasks should get small timeslices for best
>interactive feeling, and low priority (cpu hog) tasks should get large
>timeslices for best efficiency, anyway they can be preempted by higher
>priority tasks if needed.
>

Its done this way because this is really how the priorities are
enforced. With some complicated exceptions, every task will be
allowed to complete 1 timeslice before any task completes 2
(assuming they don't block).

So higher priority tasks need bigger timeslices.

>
>also, i think dynamic priority should be used for timeslice calculation
>instead of static priority. the reason is, if a low priority task get a
>priority boost (to prevent starvation, for example) it should use the
>small timeslice corresponding to it's new priority level, instead of
>using it's original large timeslice that can ruin the interactive feel.
>

Among other things, yes, I think this is a good idea too. I'll be
addressing both these issues in my scheduler fork.

I do have dynamic timeslices, but currently high priority tasks
still get big timeslices.


