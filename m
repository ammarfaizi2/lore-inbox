Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVBKGBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVBKGBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 01:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVBKGBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 01:01:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36848 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262185AbVBKGBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 01:01:06 -0500
Message-ID: <420C4A1E.4030002@mvista.com>
Date: Thu, 10 Feb 2005 22:01:02 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Dietrich <sdietrich@mvista.com>
CC: "'Ingo Molnar'" <mingo@elte.hu>, "'William Weston'" <weston@lysdexia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
References: <000701c50fcd$f42dc600$bc0a000a@mvista.com>
In-Reply-To: <000701c50fcd$f42dc600$bc0a000a@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dietrich wrote:
> Hi George,
> 
> you may want to use this for reference.
> 
> This patch adds a config option to allow you to select whether timer IRQ runs in thread or not.
> 
> I'm not totally happy with the #ifdefs, but it may make witching back and forth easier.

Thanks, but...

You are addressing a different problem than I.  I want to code the VST patch to 
work in a system with or without the RT patch (it is easy to work with the RT 
option on or off).  The problem is setting up the spin locks it needs.  My 
solution assumes that RAW_SPIN_LOCK_UNLOCKED will not be defined unless the RT 
patch is applied.

As to your patch, in most archs the timer interrupt does accounting which 
requires input on just who was interrupted on the interrupt.  This is lost when 
threading the timer IRQ.  I think it was problems of this sort that caused Ingo 
to back away...

George

PS
By the way, your mailer (Microsoft Outlook????) set up your attachment in such a 
way that my mailer would not inline it.  You might want to look into this.
> 
> Sven
> 
> 
> 
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>>George Anzinger
>>Sent: Thursday, February 10, 2005 12:21 PM
>>To: Ingo Molnar
>>Cc: William Weston; linux-kernel@vger.kernel.org
>>Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
>>
>>
>>If I want to write a patch that will work with or without the 
>>RT patch applied 
>>is the following enough?
>>
>>#ifndef RAW_SPIN_LOCK_UNLOCKED
>>typedef raw_spinlock_t spinlock_t
>>#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
>>#endif
>>
>>
>>-- 
>>George Anzinger   george@mvista.com
>>High-res-timers:  http://sourceforge.net/projects/high-res-timers/
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe 
>>linux-kernel" in the body of a message to 
>>majordomo@vger.kernel.org More majordomo info at  
>>http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

