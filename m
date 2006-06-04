Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWFDEc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWFDEc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jun 2006 00:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWFDEc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 00:32:27 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:57168 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750911AbWFDEc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 00:32:27 -0400
Message-ID: <44826258.2070803@bigpond.net.au>
Date: Sun, 04 Jun 2006 14:32:24 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Sam Vilain <sam@vilain.net>,
       "Eric W.Biederman" <ebiederm@xmission.com>, Srivatsa <vatsa@in.ibm.com>,
       Balbir Singh <bsingharora@gmail.com>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Kingsley Cheung <kingsley@aurema.com>,
       CKRM <ckrm-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 1/4] sched: Add CPU rate soft caps
References: <20060604010831.2648.37997.sendpatchset@heathwren.pw.nest> <20060604010841.2648.43027.sendpatchset@heathwren.pw.nest> <200606041227.55892.kernel@kolivas.org>
In-Reply-To: <200606041227.55892.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 4 Jun 2006 04:32:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sunday 04 June 2006 11:08, Peter Williams wrote:
>> 3. Thanks to suggestions from Con Kolivas with respect to alternative
>> methods to reduce the possibility of a task being starved of CPU while
>> holding an important system resource, enforcement of caps is now
>> quite strict.  However, there will still be occasions where caps may be
>> exceeded due to this mechanism vetoing enforcement.
> 
> Transcription bug here:
> 
>>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>>  {
>> +	int ret;
>> +
>>  	might_sleep();
>>  	return __mutex_fastpath_lock_retval
>>  			(&lock->count, __mutex_lock_interruptible_slowpath);
> 
> should be ret = 

How embarrassing.  I wonder why I didn't notice an "unreachable code" 
warning here?

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
