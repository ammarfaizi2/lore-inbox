Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSLAO1R>; Sun, 1 Dec 2002 09:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSLAO1R>; Sun, 1 Dec 2002 09:27:17 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:49083 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S261732AbSLAO1Q>; Sun, 1 Dec 2002 09:27:16 -0500
Date: Sun, 1 Dec 2002 15:34:22 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues, 2.5.50
In-Reply-To: <3DE9E567.4030103@colorfullife.com>
Message-ID: <Pine.GSO.4.40.0212011435000.7409-100000@anna>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Manfred Spraul wrote:

> Some notes:
> - coding style: linux functions usually have only one return at the end
> of the function, and goto internally. mqueue_parse_options() does that,
> mqueue_create contains multiple returns.
Ok, I've fixed it.
I just didn't know that this also belongs to coding style (I don't
like goto's much and it isn't in CodingStyle ;-).

> - why do you allocate the ext_wait_queue structure dynamically? Put it
> on the stack, that avoids error handling for failed allocations.
Hmh, you remind me about one thing that I'm constantly forgetting.
In fact allocation will stay (it is dynamic queue and it must be that way)
but I should use there list.h stuff. My fault.

> - reusing kernel functions is not a disadvantage - load_msg() and
> store_msg() automagically split the kmalloc allocations into page sized
> chunks.
Of course. I just wanted to be fair. There were pointed out main
differences (in first place) and some advantages.

> - why do you use __add_wait_queue in wq_sleep_on()? It seems you have
> copied that code from kernel/sched.c - it's not needed. It was needed for
>
>     cli()
>     if(condition_var==0)
>         sleep_on(&my_queue);
>
And from Russell King:
> Do we have to encourage this abonimation?  We do have
> wait_event().

wait_event is rather not good as I don't have condition to check - in that
case I just place process in a queue and wait for wake_up.
But I agree that it is ugly - I used it only as a quick fix for one bug.
Now I think I have good solution but I have to test it first.


Thanks for advices - new patch will be placed on
www.mat.uni.torun.pl/~wrona/posix_ipc
on Tuesday along with new library.

Krzysiek Benedyczak

