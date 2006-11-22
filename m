Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754932AbWKVGiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbWKVGiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 01:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756899AbWKVGiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 01:38:24 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:16395 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1754932AbWKVGiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 01:38:23 -0500
Message-ID: <4563F05C.4090809@argo.co.il>
Date: Wed, 22 Nov 2006 08:38:20 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@timesys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH] Add do_not_call_when_idle option to timer and workqueue
References: <20061121162845.A24791@unix-os.sc.intel.com> <20061121181114.b9d923bd.akpm@osdl.org>
In-Reply-To: <20061121181114.b9d923bd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2006 06:38:21.0552 (UTC) FILETIME=[CD996700:01C70E00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> Index: linux-2.6.19-rc-mm/include/linux/timer.h
>> ===================================================================
>> --- linux-2.6.19-rc-mm.orig/include/linux/timer.h	2006-11-13 15:06:26.000000000 -0800
>> +++ linux-2.6.19-rc-mm/include/linux/timer.h	2006-11-13 16:01:03.000000000 -0800
>> @@ -8,6 +8,8 @@
>>  
>>  struct tvec_t_base_s;
>>  
>> +#define TIMER_FLAG_NOT_IN_IDLE	(0x1)
>> +
>>  struct timer_list {
>>  	struct list_head entry;
>>  	unsigned long expires;
>> @@ -16,6 +18,7 @@
>>  	unsigned long data;
>>  
>>  	struct tvec_t_base_s *base;
>> +	int	flags;
>>  #ifdef CONFIG_TIMER_STATS
>>     
>
> Adding a new field to the timer_list is somewhat of a hit - this is going
> to make an awful lot of data structures a bit larger.  Some of which we
> allocate a large number of.
>
> I think we could justfy getting nasty and using the LSB of
> timer_list.function for this..
>
>   

The lsb of a function pointer is used in variable length instruction 
processors (such as x86 when optimizing for size).  The msb is constant 
though.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

