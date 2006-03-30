Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWC3QEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWC3QEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWC3QEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:04:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:11664 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750769AbWC3QEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:04:01 -0500
Message-ID: <442C016C.4010407@watson.ibm.com>
Date: Thu, 30 Mar 2006 11:03:56 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/8] cpu delays
References: <442B271D.10208@watson.ibm.com>	 <442B2967.6010704@watson.ibm.com> <1143734402.9731.75.camel@localhost.localdomain>
In-Reply-To: <1143734402.9731.75.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>On Wed, 2006-03-29 at 19:42 -0500, Shailabh Nagar wrote:
>  
>
>>-#ifdef CONFIG_SCHEDSTATS
>>-       memset(&p->sched_info, 0, sizeof(p->sched_info));
>>+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
>>+       if (unlikely(sched_info_on()))
>>+               memset(&p->sched_info, 0, sizeof(p->sched_info));
>> #endif 
>>    
>>
>
>If you unconditionally define sched_info_on(), you can get get rid of
>this #ifdef.
>
>+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
>+
>+static inline int sched_info_on(void)
>+{
>+ #ifdef CONFIG_SCHEDSTATS
>+       return 1;
>+#elif defined(CONFIG_TASK_DELAY_ACCT)
>+       return delayacct_on;
>+#else
>+	return 0;
>+#endif
>+}
>
>Might as well hide the junk in a header.
>  
>
Thanks, good point.
The sched_info_on() was wrong anyway and your snippet fixes that and 
gives the
junk reduction.

Will incorporate.

--Shailabh

>-- Dave
>
>  
>

