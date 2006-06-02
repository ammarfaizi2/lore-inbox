Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWFBHjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWFBHjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWFBHjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:39:09 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:24482 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751222AbWFBHjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:39:07 -0400
Message-ID: <447FE9F8.4060004@sw.ru>
Date: Fri, 02 Jun 2006 11:34:16 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: balbir@in.ibm.com, dev@openvz.org, Andrew Morton <akpm@osdl.org>,
       Srivatsa <vatsa@in.ibm.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Sam Vilain <sam@vilain.net>, Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com> <447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com> <1149187413.13336.24.camel@linuxchandra>
In-Reply-To: <1149187413.13336.24.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>- disk I/O bandwidth:
>>>we started to use CFQv2, but it is quite poor in this regard. First, it 
>>>doesn't prioritizes writes and async disk operations :( And even for 
>>>sync reads we found some problems we work on now...

> CKRM (on e-series) had an implementation based on a modified CFQ
> scheduler. Shailabh is currently working on porting that controller to
> f-series.
can you explain what was changed by CKRM there? Did you made it to 
control ASYNC read/writes? I don't think so...
Do you have any plots on what is concurrent bandwidth is depending on 
weights? Because, our measurements show that CFQ is not ideal and 
behaves poorly when prio 0,5,6,7 are used :/ Only 1,2,3,4 are really 
linear-scalable...

>>>3) memory and other resources.
>>>- memory
>>>- files
>>>- signals and so on and so on.
>>>For example, in OpenVZ we have user resource beancounters (original 
>>>author is Alan Cox), which account the following set of parameters:
>>>kernel memory (vmas, page tables, different structures etc.), dcache 
> i started looking at UBC. They provide only max limits, not min
> guarantees, right ?
they provide also vmpages guarantees and guarantees against OOM killer. 
(vmguarpages and oomguarpages) i.e. if container consumes less than X 
pages it won't be killed by OOM killer. Only if there no any other 
container to select. I.e. we have 2-level OOM.

Kirill
