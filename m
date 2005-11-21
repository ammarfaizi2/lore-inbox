Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVKUBMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVKUBMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVKUBMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:12:50 -0500
Received: from [210.76.114.20] ([210.76.114.20]:40144 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S932156AbVKUBMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:12:49 -0500
Message-ID: <43811F26.7080309@ccoss.com.cn>
Date: Mon, 21 Nov 2005 09:13:10 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] spin_lock in interrupt handler.
References: <4379B5EB.40709@ccoss.com.cn> <437A8867.8080809@ccoss.com.cn>	 <437C2133.2030103@ccoss.com.cn> <200511172057.33131.kernel@kolivas.org>	 <437D92C5.1060902@ccoss.com.cn> <1132353884.14048.10.camel@localhost.localdomain>
In-Reply-To: <1132353884.14048.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Fri, 2005-11-18 at 16:37 +0800, liyu wrote:
>  
>
>>Hi, every one in LKML.
>>
>>    I have one question about how to use spin_lock.
>>
>>    I read Documentation/spinlocks.txt wrote by Linus. The Lesson 1 and 
>>2 are simple for me.
>>But I confused in Lesson 3. The most doublt is why we can not use 
>>spin_lock_irq*() version in
>>interrupt handler?
>>
>>    At i386, I known the interrupt is disabled in interrupt handler. I 
>>think this feature is
>>supplied in handware-level. The spin_lock_irqrestore() will use  'sti'  
>>instruction internal, it will change interrupt mask bit in FLAGS 
>>register, do this have re-enable interrupt, even in interrput handler? I 
>>can not sure this.
>>    
>>
>
>Hello once again Liyu ;-)
>
>I don't see where he says you can't use spin_lock_irq* in interrupt
>handlers.  He only says that you are safe to use the non-irq* versions
>IFF (if and only if) the locks are not used in interrupts.
>
>So, (copied from the text itself):
>
>---
>The reasons you mustn't use these versions if you have interrupts that
>play with the spinlock is that you can get deadlocks:
>
>        spin_lock(&lock);
>        ...
>                <- interrupt comes in:
>                        spin_lock(&lock);
>---
>
>If you hold a spin lock without interrupts disabled, and an interrupt
>happens on the same CPU that holds the lock, and that interrupt handler
>tries to grab the lock it will just spin until that lock is released,
>which will _never_ happen, since the lock is held by the process that
>was interrupted, and will not run until the interrupt (that's spinning)
>is done. So you have a deadlock.
>
>Clear?
>
>-- Steve
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Hi, Steven, Nice to meet you too ;) (These are the words that I first 
studied in English class.)

Yes, I am clear, I think I understand it in wrong direction before.

Good Luck.

-liyu




