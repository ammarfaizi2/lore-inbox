Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUCKX3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUCKX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:29:40 -0500
Received: from anumail3.anu.edu.au ([150.203.2.43]:30420 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S261832AbUCKX3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:29:38 -0500
Message-ID: <4050F657.3050005@cyberone.com.au>
Date: Fri, 12 Mar 2004 10:29:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311134955.GB16751@krispykreme>
In-Reply-To: <20040311134955.GB16751@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3.3)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,QUOTE_TWICE_1,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:

> 
>
>>- The CPU scheduler changes in -mm (sched-domains) have been hanging about
>>  for too long.  I had been hoping that the people who care about SMT and
>>  NUMA performance would have some results by now but all seems to be silent.
>>
>>  I do not wish to merge these up until the big-iron guys can say that they
>>  suit their requirements, with a reasonable expectation that we will not
>>  need to churn this code later in the 2.6 series.
>>
>>  So.  If you have been testing, please speak up.  If you have not been
>>  testing, please do so.
>>
>
>I sucked sched-* out of mm, added sched-ppc64bits (attached) and am
>having problems with the following threaded test case. NUMA is enabled.
>
>#include <pthread.h>
>#define NR_THREADS 100
>
>void dostuff(void *junk)
>{
>        while(1)
>                ;
>}
>
>int main()
>{
>        int i;
>        pthread_t tid;
>
>        for (i = 0; i < NR_THREADS-1; i++)
>                pthread_create(&tid, NULL, dostuff, NULL);
>
>        dostuff(NULL);
>}
>
>100 runnable threads but we never use more than one cpu:
>

OK thanks. This is probably a simple bug somewhere. I'll have a look
at it soon.


