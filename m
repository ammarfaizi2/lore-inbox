Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131124AbRA2Jye>; Mon, 29 Jan 2001 04:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132542AbRA2JyY>; Mon, 29 Jan 2001 04:54:24 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:62848 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131124AbRA2JyN>; Mon, 29 Jan 2001 04:54:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A744820.2C4C94F6@colorfullife.com> 
In-Reply-To: <3A744820.2C4C94F6@colorfullife.com> 
To: Manfred Spraul <manfred@colorfullife.com>
Cc: andrewm@uow.edu.au, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: flush_scheduled_tasks() question 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jan 2001 09:53:56 +0000
Message-ID: <30086.980762036@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


manfred@colorfullife.com said:
> Is is intentional that tummy_task is not initialized? 

It _is_ initialised. To zero :)

> Ok, it won't crash because the current __run_task_queue()
> implementation doesn't call tq->routine if it's NULL, but IMHO it's
> ugly.

-static struct tq_struct dummy_task;
+static struct tq_struct dummy_task /* = all zero */;


manfred@colorfullife.com said:
>  Additionally I don't like the loop in flush_scheduled_tasks(), what
> about replacing it with a locked semaphore (same idea as vfork)?

The reason for doing it that way was because there was no guarantee that 
scheduled tasks will be called in order. So you can't just stick a new task 
in the queue and assume that when it's completed the queue is flushed. 

Linus then changed that and made the eventd thread call tasks in order, but 
I believe the intention is still that we don't make that guarantee, so it 
may change at any point in the future. 

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
