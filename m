Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWHBPcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWHBPcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWHBPcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:32:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33437 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751211AbWHBPcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:32:04 -0400
Message-ID: <44D0C56C.3030505@watson.ibm.com>
Date: Wed, 02 Aug 2006 11:31:56 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
CC: balbir@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com> <44CF6433.50108@in.ibm.com> <44CFCCE4.7060702@sgi.com>
In-Reply-To: <44CFCCE4.7060702@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Balbir Singh wrote:
> 
>> Jay Lan wrote:
>>
>>>  
>>> -#define TASKSTATS_VERSION    1
>>> +#define TASKSTATS_VERSION    2
>>> +#define TASK_COMM_LEN        16
>>>  
>>
>>
>>
>> We should find a way to keep this in sync with with the definition
>> in linux/sched.h (won't we a warning if both this header and
>> linux/sched.h are included together?)
> 
> 
> I do not know how to sync it up. This header linux/taskstats.h is
> meant to be included by userspace programs. If an application
> happens to include linux/sched.h, which includes linux/time.h,
> the application will very likely have compilation errors because
> the "struct timespec" declaration in <linux/time.h> and <time.h>
> are conflicting.
> 
> The <linux/acct.h> defines it to
> #define ACCT_COMM    16
> 
> I can change our define to TS_COMM_LEN with remakes saying it
> should be in sync with the TAKS_COMM_LEN defined in linux/sched.h.

This seems like a good enough way to do it. There's no real need for
the taskstats comm length to remain exactly in sync with the task struct's
comm length (by way of trying to include sched.h etc.) though avoiding the
compile error by renaming is desirable as Balbir pointed out.

Moreover, TASK_COMM_LEN in linux/sched.h isn't likely to change much -
if it increases and csa_acct users also really need the extra info provided,
taskstats can always be changed and version bumped up. If the size decreases
there's no harm done (strncpy should be sufficient protection).

--Shailabh

