Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUINXHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUINXHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUINXE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:04:26 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:31343 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266705AbUINXAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:00:10 -0400
Message-ID: <414777EA.5080406@yahoo.com.au>
Date: Wed, 15 Sep 2004 08:59:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
CC: linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net> <4147555C.7010809@drdos.com>
In-Reply-To: <4147555C.7010809@drdos.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> 
> Hi Jeff,
> 
>> Can you give us a few more details please? Post the allocation failure
>> messages in full, and post /proc/meminfo, etc. Thanks.
>> -
>>
> Here you go.
> 

Thanks.

> Jeff
> 
> Sep 14 14:18:59 datascout4 kernel: if_regen2: page allocation failure. 
> order:3, mode:0x20
> Sep 14 14:18:59 datascout4 kernel:  [<80106c7e>] dump_stack+0x1e/0x30
> Sep 14 14:18:59 datascout4 kernel:  [<80134aac>] __alloc_pages+0x2dc/0x350
> Sep 14 14:18:59 datascout4 kernel:  [<80134b42>] __get_free_pages+0x22/0x50
> Sep 14 14:18:59 datascout4 kernel:  [<80137d9f>] kmem_getpages+0x1f/0xd0
> Sep 14 14:18:59 datascout4 kernel:  [<8013897a>] cache_grow+0x9a/0x130
> Sep 14 14:18:59 datascout4 kernel:  [<80138b4b>] 
> cache_alloc_refill+0x13b/0x1e0
> Sep 14 14:18:59 datascout4 kernel:  [<80138fa4>] __kmalloc+0x74/0x80
> Sep 14 14:18:59 datascout4 kernel:  [<80299298>] alloc_skb+0x48/0xf0
> Sep 14 14:18:59 datascout4 kernel:  [<f8972e67>] 
> create_xmit_packet+0x57/0x100 [dsfs]
> Sep 14 14:18:59 datascout4 kernel:  [<f8973150>] regen_data+0x60/0x1d0 
> [dsfs]
> Sep 14 14:18:59 datascout4 kernel:  [<80104355>] 
> kernel_thread_helper+0x5/0x10
> Sep 14 14:18:59 datascout4 kernel: printk: 12 messages suppressed.
> 
> MemTotal:      1944860 kB
> MemFree:        200008 kB

Wow. You have 200MB free, and can't satisfy an order 3 allocation (although it
is atomic).

Now it just so happens that I have a couple of patches that are supposed to fix
exactly this. Unfortunately I haven't had the hardware to properly test them
(they're pretty stable though). Want to give them a try? :)
