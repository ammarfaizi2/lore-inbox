Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266799AbUGVE4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbUGVE4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 00:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266803AbUGVE4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 00:56:35 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:25946 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266799AbUGVE4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 00:56:33 -0400
Message-ID: <40FF48F9.1020004@yahoo.com.au>
Date: Thu, 22 Jul 2004 14:56:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption
 Patch
References: <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu>
In-Reply-To: <20040721154428.GA24374@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>What do you think about deferring softirqs just while in critical
>>sections?
>>
>>I'm not sure how well this works, and it is CONFIG_PREEMPT only but in
>>theory it should prevent unbounded softirqs while under locks without
>>taking the performance hit of doing the context switch.
> 
> 
> i dont think this is sufficient. A high-prio RT task might be performing
> something that is important to it but isnt in any critical section. This
> includes userspace processing. We dont want to delay it with softirqs.
> 

Given that we're looking for something acceptable for 2.6, how about
adding
if (rt_task(current))
	kick ksoftirqd instead

Otherwise, what is the performance penalty of doing all softirq
processing from ksoftirqd?
