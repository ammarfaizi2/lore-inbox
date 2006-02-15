Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422998AbWBOGW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWBOGW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422999AbWBOGW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:22:59 -0500
Received: from fmr21.intel.com ([143.183.121.13]:47818 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422998AbWBOGW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:22:58 -0500
Message-ID: <43F2C874.10400@linux.intel.com>
Date: Wed, 15 Feb 2006 14:21:40 +0800
From: bibo mao <bibo_mao@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Zhou Yingchao <yingchao.zhou@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH] kretprobe instance recycled by parent process
References: <43F3059A.9070601@linux.intel.com>	 <67029b170602141936v69b85832q@mail.gmail.com>	 <67029b170602141939v4791ac72l@mail.gmail.com>	 <43F324CD.1020807@linux.intel.com> <67029b170602142159i7a2bf1b2w@mail.gmail.com>
In-Reply-To: <67029b170602142159i7a2bf1b2w@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhou Yingchao wrote:
>>>> When kretprobe probe schedule() function, if probed process exit then
>>>> schedule() function will never return, so some kretprobe instance will
>>>> never be recycled. By this patch the parent process will recycle
>>>> retprobe instance of probed function, there will be no memory leak of
>>>> kretprobe instance. This patch is based on 2.6.16-rc3.
>>> Is there any process which can exit without go through the do_exit() path?
>>> --
>> When process exits through do_exit() function, it will call schedule()
>> function. But if schedule() function is probed by kretprobe, this time
>> schedule() function will not return never because process has exited.
>>
>> bibo,mao
>>
> 
> In the original path, doesn't the call path of
> do_exit()->exit_thread()->kprobe_flush_task(current) recycle the
> kretprobe instance? Is there anything misundstood?
> --
yes, it is right. The old recycle method is
    do_exit()->exit_thread()->kprobe_flush_task(current)
             ->schedule()
At last line of do_exit() it will call schedule() function, and this 
time it will never return. But if schedule function is probed, who is 
responsible for recycling it?

bibo,mao
