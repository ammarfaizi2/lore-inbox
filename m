Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSLAKZ5>; Sun, 1 Dec 2002 05:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSLAKZ5>; Sun, 1 Dec 2002 05:25:57 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9398 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261581AbSLAKZ4>;
	Sun, 1 Dec 2002 05:25:56 -0500
Message-ID: <3DE9E567.4030103@colorfullife.com>
Date: Sun, 01 Dec 2002 11:33:11 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues, 2.5.50
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some notes:
- coding style: linux functions usually have only one return at the end 
of the function, and goto internally. mqueue_parse_options() does that, 
mqueue_create contains multiple returns.
- why do you allocate the ext_wait_queue structure dynamically? Put it 
on the stack, that avoids error handling for failed allocations.
- reusing kernel functions is not a disadvantage - load_msg() and 
store_msg() automagically split the kmalloc allocations into page sized 
chunks.
- why do you use __add_wait_queue in wq_sleep_on()? It seems you have 
copied that code from kernel/sched.c - it's not needed. It was needed for

    cli()
    if(condition_var==0)
        sleep_on(&my_queue);

--
    Manfred



