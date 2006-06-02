Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWFBDWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWFBDWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 23:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWFBDWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 23:22:39 -0400
Received: from alt.aurema.com ([203.217.18.57]:26222 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S1751190AbWFBDWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 23:22:38 -0400
Message-ID: <447FAEB0.3060103@aurema.com>
Date: Fri, 02 Jun 2006 13:21:20 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, Srivatsa <vatsa@in.ibm.com>,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Sam Vilain <sam@vilain.net>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>	<447F77A4.3000102@bigpond.net.au> <1149213759.10377.7.camel@linuxchandra>
In-Reply-To: <1149213759.10377.7.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Fri, 2006-06-02 at 09:26 +1000, Peter Williams wrote:
>> Chandra Seetharaman wrote:
>>> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
>>>> Hi, Kirill,
>>>>
>>>> Kirill Korotaev wrote:
>>>>>> Do you have any documented requirements for container resource 
>>>>>> management?
>>>>>> Is there a minimum list of features and nice to have features for 
>>>>>> containers
>>>>>> as far as resource management is concerned?
>>>>> Sure! You can check OpenVZ project (http://openvz.org) for example of 
>>>>> required resource management. BTW, I must agree with other people here 
>>>>> who noticed that per-process resource management is really useless and 
>>>>> hard to use :(
>>> I totally agree.
>>>> I'll take a look at the references. I agree with you that it will be useful
>>>> to have resource management for a group of tasks.
>> But you don't need something as complex as CKRM either.  This capping
> 
> All CKRM^W Resource Groups does is to group unrelated/related tasks to a
> group and apply resource limits. 
> 
>>  
>> functionality coupled with (the lamented) PAGG patches (should have been 
>> called TAGG for "task aggregation" instead of PAGG for "process 
>> aggregation") would allow you to implement a kernel module that could 
>> apply caps to arbitrary groups of tasks.
> 
> I do not follow how PAGG + this cap feature can be used to put cap of
> related/unrelated tasks. Can you provide little more explanation,
> please.

I would have thought it was fairly obvious.  PAGG supplies the task 
aggregation mechanism, these patches provide per task caps and all 
that's needed is the code that marries the two.

> 
> Also, i do not think it can provide guarantees to that group of tasks.
> can it ?

It could do that by manipulating nice which is already available in the 
kernel.

I.e. these patches plus improved statistics (which are coming, I hope) 
together with the existing policy controls provide all that is necessary 
to do comprehensive CPU resource control.  If there is an efficient way 
to get the statistics out to user space (also coming, I hope) this 
control could be exercised from user space.

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
