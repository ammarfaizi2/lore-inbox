Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132974AbRA2KQb>; Mon, 29 Jan 2001 05:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135329AbRA2KQL>; Mon, 29 Jan 2001 05:16:11 -0500
Received: from colorfullife.com ([216.156.138.34]:50699 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132974AbRA2KQI>;
	Mon, 29 Jan 2001 05:16:08 -0500
Message-ID: <3A7542D3.FD9CA259@colorfullife.com>
Date: Mon, 29 Jan 2001 11:15:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: andrewm@uow.edu.au, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: flush_scheduled_tasks() question
In-Reply-To: <3A744820.2C4C94F6@colorfullife.com> <30086.980762036@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> -static struct tq_struct dummy_task;
> +static struct tq_struct dummy_task /* = all zero */;
>
That comment is superflous - that's just C.
The non-obvious part is

+static struct tq_struct dummy_task; /* remains zero, run_task_queue()
supports tqs.routine==NULL*/

BUT: The implementation isn't thread safe: what if multiple threads call
flush_scheduled_tasks()?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
