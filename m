Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVBYLKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVBYLKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVBYLKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:10:41 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:18869 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262672AbVBYLKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:10:20 -0500
Message-ID: <421F0798.3030609@yahoo.com.au>
Date: Fri, 25 Feb 2005 22:10:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/13] rework schedstats
References: <200502251050.j1PAo6QK008040@owlet.beaverton.ibm.com>
In-Reply-To: <200502251050.j1PAo6QK008040@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
>     I have an updated userspace parser for this thing, if you are still
>     keeping it on your website.
> 
> Sure, be happy to include it, thanks!  Send it along.  Is it for version
> 11 or version 12?
> 

Version 12. I can send it to you next week. This was actually
directed at Andrew, who was hosting my parser somewhere for a
while. But it would be probably better if it just goes on your
site.

Sorry, no update to your script because I can't write perl to
save my life, let alone read it :|


>     Move balancing fields into struct sched_domain, so we can get more
>     useful results on systems with multiple domains (eg SMT+SMP, CMP+NUMA,
>     SMP+NUMA, etc).
> 
> It looks like you've also removed the stats for pull_task() and
> wake_up_new_task().  Was this intentional, or accidental?
> 

I didn't really think wunt_cnt or wunt_moved were very interesting
with respect to the scheduler. wunt_cnt is more or less just the
total number of forks, wunt_moved is a very rare situation where
the new task is moved before being woken up.

The balance-on-fork schedstats code does add some more interesting
stuff here.

pull_task() lost the "lost" counter because that is tricky to put
into the context of sched-domains. It also isn't important in my
current line of analysis because I'm just doing summations over
all CPUs, so in that case your "gained" was always the same as
"lost".

If you have uses for other counters, by all means send patches and
we can discuss (not that I can imagine I'd have any objections).

> I can't quite get the patch to apply cleanly against several variants
> of 2.6.10 or 2.6.11-rc*.  Which version is the patch for?
> 

It was 11-rc4, but it should fit on -rc5 OK too.

