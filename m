Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUGCXLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUGCXLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 19:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUGCXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 19:11:08 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:33673 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265281AbUGCXLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 19:11:04 -0400
Message-ID: <40E73CF7.9050205@colorfullife.com>
Date: Sun, 04 Jul 2004 01:10:47 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc 1/3: Add refcount to ipc_rcu_alloc
References: <40E6EE71.9050402@colorfullife.com>	<20040703132217.2754ea75.akpm@osdl.org>	<40E72AB7.50802@colorfullife.com> <20040703154412.1d03ed41.akpm@osdl.org>
In-Reply-To: <20040703154412.1d03ed41.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Manfred Spraul <manfred@colorfullife.com> wrote:
>  
>
>>+struct ipc_rcu_hdr
>> +{
>> +	int refcount;
>> +	int is_vmalloc;
>> +	void *data[0];
>> +};
>>    
>>
>
>That's not what I meant ;)
>
>struct ipc_rcu_hdr
>{
>	int refcount;
>	int is_vmalloc;
>};
>
>Then place one of these inside struct msg_queue, one inside struct
>sem_array, etc.
>
>  
>
No. The size of the headers depends on the allocation size: 8 bytes for 
allocs < 4088 bytes, 60 bytes for larger allocs. I don't want to expose 
that implementation detail outside of util.c.
ipc_rcu_alloc allocates an arbitrary sized refcounted memory block that 
is released through the rcu framework. Everything else is hidden in util.c.

--
    Manfred
