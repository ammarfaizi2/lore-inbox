Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTFXVox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTFXVox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:44:53 -0400
Received: from dm6-35.slc.aros.net ([66.219.221.35]:650 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262227AbTFXVow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:44:52 -0400
Message-ID: <3EF8C9A3.5020206@aros.net>
Date: Tue, 24 Jun 2003 15:58:59 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jds <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.
References: <20030624191740.M38428@soltis.cc>
In-Reply-To: <20030624191740.M38428@soltis.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jds wrote:

>Hi Andrew:
>
>
>    I have kernel panic when boot with kernel 2.5.73-mm1, in kernel 2.5.73
>working good.
>
>    Anex part the OOps:
>
>
>    EPI: 0060:[<c20f480>]   not tainted VLI
>    EFLAHS: 0010246
>    EIP:   is at kobject_add+0xd0/0130
>    eax: 736f70a3 ebx:736f705f  ecx:00000000   edx:ffff0001
>    esi: 736f70a3 edi:dfd6653x  ebp:c157df40   esp:c157df24
>    ds:  007b  es: 007b  ss:  0068
>
>    Process:   swapper( pid:1, theaddinfo= c157c000 task = c157f880)
>    
>    Stack:
>
>    c03ed505  00000059  dfd6653c  dfd80860  dfd66400 dfd653c  c157f75c
>     
>  
>    Call Trace:
>
>    [< c020f503>]  kobject_register+0x23/0x60
>    [<             blk_register_queue+0x80/0xb0
>                   nbd_init+0x1df/0x220
>                   do_initcalls+0x2b/0xa0
>                   init_workqueues+0x12/0x30
>                   init+0x28/0x150
>                   init+0x0/0x150
>                   kernel_thread_helper+0x50/0xc
>
>   Code: feff
>   <0>Kernel Panic:  Attempted to kill init!
>. . .
>
I'm *guestimating* that the following patch will fix this problem. Let 
me know if you use it wether it makes this problem go away or not. Note 
that to me at least, blk_init_queue() should be responsible for 
initializing this memory not the driver. Either way, something has to 
initialize request_queue.kobj.kset otherwise I think this is the result 
when the kset field can be any value.

