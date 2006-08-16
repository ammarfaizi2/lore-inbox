Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWHPGfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWHPGfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWHPGfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:35:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17843 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750771AbWHPGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:35:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 2/7] pid: Add do_each_pid_task
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
	<11556661923847-git-send-email-ebiederm@xmission.com>
	<20060816031043.GE15241@sergelap.austin.ibm.com>
Date: Wed, 16 Aug 2006 00:34:51 -0600
In-Reply-To: <20060816031043.GE15241@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Tue, 15 Aug 2006 22:10:43 -0500")
Message-ID: <m1zme55gtw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> To avoid pid rollover confusion the kernel needs to work with
>> struct pid * instead of pid_t.  Currently there is not an iterator
>> that walks through all of the tasks of a given pid type starting
>> with a struct pid.  This prevents us replacing some pid_t instances
>> with struct pid.  So this patch adds do_each_pid_task which walks
>> through the set of task for a given pid type starting with a struct pid.
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>>  include/linux/pid.h |   13 +++++++++++++
>>  1 files changed, 13 insertions(+), 0 deletions(-)
>> 
>> diff --git a/include/linux/pid.h b/include/linux/pid.h
>> index 93da7e2..4007114 100644
>> --- a/include/linux/pid.h
>> +++ b/include/linux/pid.h
>> @@ -118,4 +118,17 @@ #define while_each_task_pid(who, type, t
>>  				1; }) );				\
>>  	}
>>  
>> +#define do_each_pid_task(pid, type, task)				\
>
> Hmm, defining do_each_pid_task right after do_each_task_pid could result
> in some frustration  :)
>
> Though not sure of a better name - do_each_task_structpid?

A couple of things.
-  I think do_each_pid_task is probably the most descriptive name
   I can come up with.  As these are tasks of a pid.  I don't quite understand
   where the old name came from.

- Whatever we pick for the new function is the name we are going to use
  for a long time so I don't want it to be clumsy.  The existing function
  will go away after everything is updated.

- If you pick the wrong one you will get a compile error, as integers and
  pointers are not very interchangeable.

I hate the temporary confusion but I don't see a better alternative.

Eric

