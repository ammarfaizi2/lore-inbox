Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266088AbUFPDEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUFPDEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUFPDBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:01:07 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:54955 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266124AbUFPDAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:00:13 -0400
Message-ID: <40CFB7B0.5090702@yahoo.com.au>
Date: Wed, 16 Jun 2004 13:00:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
References: <200406121028.06812.kernel@kolivas.org> <20040615045616.GA2006@elte.hu>
In-Reply-To: <20040615045616.GA2006@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>* Con Kolivas <kernel@kolivas.org> wrote:
>
>
>>with a little bit of detective work and help from Wli we tracked down that 
>>this patch caused it:
>>[PATCH] sched: improve wakeup-affinity
>>
>
>>A massive increase in idle time was observed and the throughput
>>dropped by 40% Reversing this patch gave these results:
>>
>
>>backsched1: http://khack.osdl.org/stp/293865/
>>Composite 	Query Processing Power 	Throughput Numerical Quantity
>>193.93 	145.95 	257.67
>>
>>It may be best to reverse this patch until the regression is better 
>>understood.
>>
>
>agreed. It is weird because Nick said that pgsql was tested with the
>patch - and we applied the patch based on those good results. Nick?
>
>

Sigh, yes, Mark did run a test for me, but I think it was dbt2-pgsql.
This one is dbt3-pgsql. Also, his system was a 4 logical CPU Xeon.

Strangely enough, Mark's setup was showing a fairly large too-much-idle
regression not long ago, while these 8-ways weren't.

Anyway, Linus has reverted my patch now, which is the right thing to
do. Your sync wakeup change is still in there, so that will hopefully
help bw_pipe scores.

I have some changes which bring throughput up to 240, however I'm not
sure if it would be wise to try to fix everything before 2.6.7.

I'd be happy for 2.6.7 to be released with kernel/sched.c as it is now.
What are your thoughts?

