Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269740AbRHTWlP>; Mon, 20 Aug 2001 18:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269752AbRHTWlF>; Mon, 20 Aug 2001 18:41:05 -0400
Received: from logger.gamma.ru ([194.186.254.23]:36875 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S269740AbRHTWkt>;
	Mon, 20 Aug 2001 18:40:49 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: Patch for bizzare oops in USB
Date: 21 Aug 2001 02:12:35 +0400
Organization: Average
Message-ID: <9ls20j$g3f$1@pccross.average.org>
In-Reply-To: <3B80FBA9.556B7B2B@scs.ch>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Thomas Sailer <sailer@scs.ch>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B80FBA9.556B7B2B@scs.ch>,
        Thomas Sailer <sailer@scs.ch> writes:

>> --- linux-2.4.8/drivers/usb/usb.c       Tue Jul 24 14:20:56 2001
>> +++ linux-2.4.8-e/drivers/usb/usb.c     Fri Aug 17 22:03:27 2001
>> @@ -1066,7 +1066,7 @@
>> 
>>         awd.wakeup = &wqh;
>>         init_waitqueue_head(&wqh);
>> -       current->state = TASK_INTERRUPTIBLE;
>> +       current->state = TASK_UNINTERRUPTIBLE;  /* MUST BE SO. -- zaitcev */
>>         add_wait_queue(&wqh, &wait);
>>         urb->context = &awd;
>>         status = usb_submit_urb(urb);
> 
> This is bad for other users of usb_control_msg/usb_bulk_msg that depend on
> the sleep to be interruptible. Instead of bouncing back and forth whether
> those routines shall sleep interruptibly or uninterruptibly, we should either
> provide two routines or a parameter that specifies whether the sleep
> shall be interruptible, or create a local version of usb_control_msg
> if ov511 is the only user requiring uninterruptible sleep.

I observe similar Oops with D-Link USB radio tuner on uhci when I hit
Ctrl-C (SMP system, UP system with ohci works).  I was preparing to
post ksymoops report when I read Pete's message ;)

Eugene
