Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbSJCI1n>; Thu, 3 Oct 2002 04:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263209AbSJCI1n>; Thu, 3 Oct 2002 04:27:43 -0400
Received: from dial-ctb0563.webone.com.au ([210.9.245.63]:24583 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S263201AbSJCI1l>;
	Thu, 3 Oct 2002 04:27:41 -0400
Message-ID: <3D9C00B4.8080502@cyberone.com.au>
Date: Thu, 03 Oct 2002 18:32:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: colpatch@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] kernel/sched.c oddness?
References: <Pine.LNX.4.44.0210030840110.4477-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


         * Make sure nothing changed since we checked the
         * runqueue length.
         */
-       if (busiest->nr_running <= nr_running + 1) {
+       if (busiest->nr_running <= nr_running) {
                spin_unlock(&busiest->lock);
                busiest = NULL;
        }

OK, thanks for the explanation, then disregard this part of the patch, the
other two are still valid I think.

Ingo Molnar wrote:

>>[...] However, I noticed on my 2xSMP system that quite unbalanced loads
>>weren't getting even CPU time best example - 3 processes in busywait
>>loops - one would get 100% of one cpu while two would get 50% each of
>>the other.
>>
>
>this was done intentionally, and this scenario (1+2 tasks) is the very
>worst scenario. The problem is that by trying to balance all 3 tasks we
>now have 3 tasks that trash their cache going from one CPU to another.  
>(this is what happens with your patch - even with another approach we'd
>have to trash at least one task)
>
>By keeping 2 tasks on one CPU and 1 task on the other CPU we avoid
>cross-CPU migration of threads. Think about the 2+3 or 4+5 tasks case
>rather, do we want absolutely perfect balancing, or good SMP affinity and
>good combined performance?
>
>	Ingo
>
>
>
>


