Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVLWAvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVLWAvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVLWAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:51:06 -0500
Received: from bay16-f8.bay16.hotmail.com ([65.54.186.58]:20886 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751208AbVLWAvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:51:04 -0500
Message-ID: <BAY16-F8E0161EA0C4B79180F698AF330@phx.gbl>
X-Originating-IP: [203.166.111.194]
X-Originating-Email: [alexshinkin@hotmail.com]
In-Reply-To: <43AB41D9.6070600@shaw.ca>
From: "Alexey Shinkin" <alexshinkin@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: questions on wait_event ...
Date: Fri, 23 Dec 2005 06:51:04 +0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 23 Dec 2005 00:51:04.0262 (UTC) FILETIME=[F3A2C660:01C6075A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Alexey Shinkin wrote:
>>Hi , all !
>>Could anyone please clarify one thing in that old well known
>>wait_event_... code (taken from 2.6.5 wait.h ):
>>
>>#define __wait_event_interruptible(wq, condition, ret)          \
>>do {                                                                    \
>>        wait_queue_t __wait;                                     \
>>        init_waitqueue_entry(&__wait, current);           \
>>                                                                        \
>>        add_wait_queue(&wq, &__wait);                   \
>>        for (;;) {                                                      \
>>                set_current_state(TASK_INTERRUPTIBLE);    \
>>                if (condition)                                          \
>>                        break;
>>........................................
>>
>>Is it possible that scheduling happen after set_current_state() but before
>>checking the condition ?
>>If yes - even if we will have condition==TRUE by this moment - the 
>>scheduler
>>will make the process to sleep anyway , right ?
>
>Yes, but since the condition would then have changed after we were put into 
>the wait queue, they would have woken up the queue and we should be woken 
>up again.
>
>--
>Robert Hancock      Saskatoon, SK, Canada
>To email, remove "nospam" from hancockr@nospamshaw.ca
>Home Page: http://www.roberthancock.com/
>


And what if the condition have changed after we have checked it in 
wait_event() but
before calling __wait_event() and before putting the process into the wait 
queue ?
The process could not be woken up "in advance" , right ?


#define wait_event(wq, condition)        \
do {                                                   \
        if (condition)                                \
                break;                                 \
   /* and here we have condition changed  ???? */
        __wait_event(wq, condition);        \
} while (0)


Regards
Alexey Shinkin

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.com/

