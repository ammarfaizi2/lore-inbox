Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbWD1Ftj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbWD1Ftj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWD1Ftj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:49:39 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:61830 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965177AbWD1Ftj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:49:39 -0400
Message-ID: <4451AEA4.1040108@sw.ru>
Date: Fri, 28 Apr 2006 09:56:52 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] Re: [PATCH 0/9] CPU controller
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <1146201936.7523.15.camel@homer>
In-Reply-To: <1146201936.7523.15.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Andrew,
>>
>>This patchset adds a CPU resource controller on top of Resource Groups. 
>>The CPU resource controller manages CPU resources by scaling timeslice
>>allocated for each task without changing the algorithm of the O(1)
>>scheduler.
>>
>>Please consider these for inclusion in -mm tree.
> 
> 
> This patch set professes to be a resource controller, yet 100% of high
> priority tasks are uncontrolled.  Distribution of CPU among high
> priority tasks isn't important, but distribution of what they leave
> behind is?

Also, as it turned out these doesn't do good fair scheduling under some 
curcemstances (with busy loops on SMP) :(. Which was reported to MAEDA.
And it doesn't provide limits. as Andrew noticed already, the 
infrastructe is ok, but without much content (or at least good plan) we 
can end up in the only infrastracture.

I'm also pretty sure, that CPU controller based on timeslice tricks 
behaves poorly on burstable load patterns as well and with interactive 
tasks. So before commiting I propose to perform a good testing on 
different load patterns.

Thanks,
Kirill

