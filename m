Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVJ2LhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVJ2LhU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVJ2LhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:37:20 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:14757 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751021AbVJ2LhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:37:19 -0400
Message-ID: <43635EDE.3040108@colorfullife.com>
Date: Sat, 29 Oct 2005 13:37:02 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Davi Arnaut <davi.lkml@gmail.com>, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/slab.c:1488! (2.6.13.2)
References: <750c918d0510272032k79211b44vee825864d0f26438@mail.gmail.com> <20051027215312.57303595.akpm@osdl.org>
In-Reply-To: <20051027215312.57303595.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Davi Arnaut <davi.lkml@gmail.com> wrote:
>  
>
>> > It seems that something still tries to load the ext3 module, and I get the
>> > BUG seen below.  If I remove the ext3 module and re-build the initrd,
>> > the error goes away.
>>    
>>
>
>Yes, I think the kernel is overreacting here.
>
>Manfred, what sayest thou?
>
>(nb: untested)
>
>  
>
It looks goot, it doesn't crash on boot

>Notes:
>
>- Swaps the ranking of cache_chain_sem and lock_cpu_hotplug().  Doesn't seem
>  important.
>
>  
>
Correct. It might even allow a further cleanup: Since both 
cpuup_callback and kmem_cache_create now runs entirely under 
cache_chain_sem, it could be possible to remove lock_cpu_hotplug() entirely.

>Signed-off-by: Andrew Morton <akpm@osdl.org>
>  
>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

