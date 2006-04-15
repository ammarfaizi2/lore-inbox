Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWDOVbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWDOVbV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWDOVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:31:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:62772 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751620AbWDOVbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:31:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=dpnSXMLS8ULLZtUNTfinEGToxozbI++j3fVW0SJVq1iE9QYBLyMNjAF6QsYHhGa7R
	46qv68rXr4w0amFhG8ccw==
Message-ID: <44416616.10908@google.com>
Date: Sat, 15 Apr 2006 14:31:02 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
References: <4441452F.3060009@google.com> <20060415141744.042231a8.akpm@osdl.org>
In-Reply-To: <20060415141744.042231a8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
>>OK, looking back through the perf results, these two graphs clearly show
>>a perf regression in reaim7 from 2.6.15 to 2.6.16-rc1. We're loosing 
>>over 50% of the performance.
>>
>>http://test.kernel.org/abat/perf/reaim.moe.png
>>http://test.kernel.org/abat/perf/reaim.elm3b67.png
> 
> Something very bad has allegedly been happening in -mm.  It would have been
> nice to have heard about this problem in that multi-month wwindow there. 
> Does no human look at these numbers?

Obviously not ;-(
I do look every so often, but not frequently. I'm working on 
reformatting the site right now, which is why I was poking around.
reaim I often don't look at, as it's not as stable as I'd like, but
that is a *huge* drop.

You can see I collated stuff down into a collection of tests per
machine-release combo, so the dbench and LTP results are folded
into the main matrix now. Next stage is to add performance regression
comparions in there, but it's not easy unless we run multiple times
so that I get std dev as well as average. All of this should make it
easier to (a) see and (b) send out proactive notifications.

>>Drilling down (there's not enough detail on the graphs for releases that
>>far back), I see it's actually between -git5 and -git6
>>
>>These are both ia-32 NUMA machines, one is an x440, the other is NUMA-Q.
> 
> 
> The 2.6.15-git5 -> 2.6.15-git6 diff is enormous.  I'd assume some bad thing
> got transferred into mainline then.
> 
> How does one reproduce this?  Which type of filesystem, which command
> line/config file?

Sigh ... this is exactly why I want the new autotest harness, I could 
just hand you the control file and you could run the same test (at your
box or OSDL or whatever). Not finished yet though ;-(

drilling down into the results directories can get you the command line,
looks like "reaim -f workfile.short -s 1 -e 10 -i 2" to me. Buggered if
I can recall what that did though.

(http://test.kernel.org/abat/20229/004.reaim.test/results/cmdline)

I *think* it's only ia32 NUMA boxes, at least as far as I can see from
a quick poke around. Which would make me guess at scheduler code. Gitweb
would be nice to use, but it doesn't tag the -git snapshots, AFAICS, 
which is a real shame. Nor does the git snapshot include the git tag,
as far as I know. Grrrr. I guess I'll download the snapshots and diff
them, and try to pull out the sched changes by hand. Much suckage.

M.

