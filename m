Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWKBFfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWKBFfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWKBFfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:35:05 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:48006 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751803AbWKBFfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:35:01 -0500
Message-ID: <4549832A.2040400@in.ibm.com>
Date: Thu, 02 Nov 2006 11:03:30 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Paul Menage <menage@google.com>, vatsa@in.ibm.com,
       Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com>	 <45486925.4000201@openvz.org> <20061101181236.GC22976@in.ibm.com>	 <1162419565.12419.154.camel@localhost.localdomain>	 <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com> <1162427450.12419.184.camel@localhost.localdomain>
In-Reply-To: <1162427450.12419.184.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Wed, 2006-11-01 at 15:50 -0800, Paul Menage wrote:
>> On 11/1/06, Matt Helsley <matthltc@us.ibm.com> wrote:
>>> On Wed, 2006-11-01 at 23:42 +0530, Srivatsa Vaddagiri wrote:
>>>> On Wed, Nov 01, 2006 at 12:30:13PM +0300, Pavel Emelianov wrote:
>>> <snip>
>>>
>>>>>>   - Support movement of all threads of a process from one group
>>>>>>     to another atomically?
>>>>> I propose such a solution: if a user asks to move /proc/<pid>
>>>>> then move the whole task with threads.
>>>>> If user asks to move /proc/<pid>/task/<tid> then move just
>>>>> a single thread.
>>>>>
>>>>> What do you think?
>>>> Isnt /proc/<pid> listed also in /proc/<pid>/task/<tid>?
>>>>
>>>> For ex:
>>>>
>>>>       # ls /proc/2906/task
>>>>       2906  2907  2908  2909
>>>>
>>>> 2906 is the main thread which created the remaining threads.
>>>>
>>>> This would lead to an ambiguity when user does something like below:
>>>>
>>>>       echo 2906 > /some_res_file_system/some_new_group
>>>>
>>>> Is he intending to move just the main thread, 2906, to the new group or
>>>> all the threads? It could be either.
>>>>
>>>> This needs some more thought ...
>>>         I thought the idea was to take in a proc path instead of a single
>>> number. You could then distinguish between the whole thread group and
>>> individual threads by parsing the string. You'd move a single thread if
>>> you find both the tgid and the tid. If you only get a tgid you'd move
>>> the whole thread group. So:
>>>
>>> <pid>                   -> if it's a thread group leader move the whole
>>>                            thread group, otherwise just move the thread
>>> /proc/<tgid>            -> move the whole thread group
>>> /proc/<tgid>/task/<tid> -> move the thread
>>>
>>>
>>>         Alternatives that come to mind are:
>>>
>>> 1. Read a flag with the pid
>>> 2. Use a special file which expects only thread groups as input
>> I think that having a "tasks" file and a "threads" file in each
>> container directory would be a clean way to handle it:
>>
>> "tasks" : read/write complete process members
>> "threads" : read/write individual thread members
>>
>> Paul
> 
> Seems like a good idea to me -- that certainly avoids complex parsing.
> 
> Cheers,
> 	-Matt Helsley
> 

Yeah, sounds like a good idea. We need to give the controllers some control
over whether they support task movement, thread movement or both.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
