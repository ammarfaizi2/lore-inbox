Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272369AbTHNOEw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272372AbTHNOEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:04:52 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.30]:45999 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S272369AbTHNOEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:04:51 -0400
Message-ID: <3F3BB38F.6060506@wanadoo.fr>
Date: Thu, 14 Aug 2003 16:06:39 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmem_cache_destroy: Can't free all objects (2.6)
References: <Pine.LNX.4.33.0308141215430.7602-100000@blackhole.kfki.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jozsef Kadlecsik wrote:
> Hello,
> 
> I'm working on performance testing netfilter ip_conntrack.  The tested
> machine is a dual Xeon PC with Serverworks chipset and e1000 cards.
> 
> "Calibrating" without ip_conntrack loaded in went fine. However as
> the ip_conntrack module was removed after a test, sometimes I got the
> message:
> 
> slab error in kmem_cache_destroy(): cache `ip_conntrack': Can't free all
> objects
> Call Trace:
>  [<c0136fe9>] kmem_cache_destroy+0xd8/0x116
>  [<f889f3ba>] ip_conntrack_cleanup+0x43/0x6c [ip_conntrack]
>  [<f889d61a>] init_or_cleanup+0x131/0x190 [ip_conntrack]
>  [<f889fc13>] fini+0xf/0x19 [ip_conntrack]
>  [<c012dd76>] sys_delete_module+0x13c/0x169
>  [<c01402ab>] sys_munmap+0x45/0x66
>  [<c0108f9b>] syscall_call+0x7/0xb
> 
> I cannot reliably reproduce the error. Sometimes it comes at the
> first test run, sometimes at say the 20th, but I have never been able to
> run all the planned 150 tests.
> 
> This happens both with 2.5.74 and 2.6.0-test1.

I fixed a bug with exactly this symptom, all object freed but
the cache was retaining some object internally. I look 2.6.0-test1
and the fix is in, apologies if you already did it correctly
but can you double check the bug is really in 2.6.0-test1.

> Slab cache ip_conntrack: 2052678 allocs vs 2052678 frees


> slab error in kmem_cache_destroy(): cache `ip_conntrack': Can't free all objects

regards,
Philippe Elie


