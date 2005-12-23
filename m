Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVLWAS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVLWAS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVLWAS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:18:26 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:13473 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751204AbVLWASZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:18:25 -0500
Date: Thu, 22 Dec 2005 18:16:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: questions on wait_event ...
In-reply-to: <5mIFB-6PS-33@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43AB41D9.6070600@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5mIFB-6PS-33@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Shinkin wrote:
> Hi , all !
> Could anyone please clarify one thing in that old well known
> wait_event_... code (taken from 2.6.5 wait.h ):
> 
> #define __wait_event_interruptible(wq, condition, ret)          \
> do {                                                                    \
>        wait_queue_t __wait;                                     \
>        init_waitqueue_entry(&__wait, current);           \
>                                                                        \
>        add_wait_queue(&wq, &__wait);                   \
>        for (;;) {                                                      \
>                set_current_state(TASK_INTERRUPTIBLE);    \
>                if (condition)                                          \
>                        break;
> ........................................
> 
> Is it possible that scheduling happen after set_current_state() but before
> checking the condition ?
> If yes - even if we will have condition==TRUE by this moment - the 
> scheduler
> will make the process to sleep anyway , right ?

Yes, but since the condition would then have changed after we were put 
into the wait queue, they would have woken up the queue and we should be 
woken up again.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

