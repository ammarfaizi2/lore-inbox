Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274926AbRIXUBN>; Mon, 24 Sep 2001 16:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274925AbRIXUBE>; Mon, 24 Sep 2001 16:01:04 -0400
Received: from [208.129.208.52] ([208.129.208.52]:56586 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274924AbRIXUAw>;
	Mon, 24 Sep 2001 16:00:52 -0400
Message-ID: <XFMail.20010924130453.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <m1adzk75r2.fsf@frodo.biederman.org>
Date: Mon, 24 Sep 2001 13:04:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: <ebiederm@xmission.com (Eric W. Biederman)>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Christopher K. St. John" <cks@distributopia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Sep-2001 Eric W. Biederman wrote:
>> Coroutines or not, this does not change the picture.
>> All multiplexed servers have an IO driven scheduler that calls
>> code sections based on the fd.
>> Obviously if you've a one-thread-per-socket model, epoll is not your answer.
> 
> A couroutine is a thread, the two terms are synonyms.  Generally
> coroutines refer to threads with a high volumne of commniucation
> between them.  And the terms come from different programming groups.
> 
> However a fully cooperative thread (as is implemented in the current
> coroutine library) can be quite cheap, and is a easy way to implement
> a state machine.  A pure state machine will have a smaller data
> footprint than the stack of a cooperative thread, but otherwise
> the concepts are pretty much the same.  Language support for
> cooperative threads, so you could verify you wouldn't overflow your
> stack would be very nice. 
> 
> So epoll is a good solution if you have a one-thread-per-socket model,
> and you are doing cooperative threads.  The thread being used here is
> simply a shortcut to writing a state machine.

If you'd be the os i guess you'd not say the same :)
It was pretty clear the model i meant was one real thread/process per fd.
The main difference with coroutines is that the /dev/epoll engine become
the scheduler of your app.
It's also clear that you can avoid the coroutines by writing a state machine.
There's a HUGE memory save with the stack removal that you pay with a more
complicated code.




- Davide

