Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318799AbSHWN2H>; Fri, 23 Aug 2002 09:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSHWN2H>; Fri, 23 Aug 2002 09:28:07 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:14032 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S318799AbSHWN2F>; Fri, 23 Aug 2002 09:28:05 -0400
Message-Id: <200208231332.WAA29857@cttsv008.ctt.ne.jp>
Date: Fri, 23 Aug 2002 15:22:51 +0900
To: root@chaos.analogic.com
CC: sanket rathi <sanket@linuxmail.org>, linux-kernel@vger.kernel.org
From: Kerenyi Gabor <wom@tateyama.hu>
Subject: Re: interrupt handler
Organization: Tateyama Hungary Ltd.
X-Mailer: Opera 5.12 build 932
X-Priority: 3 (Normal)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/23/2002 10:07:54 PM, "Richard B. Johnson" <root@chaos.analogic.com> wrote:

>On Fri, 23 Aug 2002, Kerenyi Gabor wrote:
>> Anyway, do anybody know what kind of advantages/disadvantages I can get
>> if I don't disable interrupts at all in my driver? Even if I have to
>> use a circular
>> buffer or anything else? Is it worth trying to find such a solution or is it
>> a wasted time?
>> 
>> Gabor
>
>If your ISR manipulates any data, which is quite likely, then
>your driver code, that is outside the ISR, must be written
>with the knowledge that an interrupt can happen at any time.

Well I wrote it in this way of course.

>There are probably certain critical regions of code that must
>be protected against modification from the ISR code. You need
>to protect those critical regions with spin-locks.

I know. But there are some technics that can be used to workaorund
the irq disabling thing.

>Spin-locks have very little code. If there is no contention,
>they do not affect performance in any measurable way. If there
>is contention, they simply delay execution of the ISR to a time
>where code is executing in a non-critical section. This delay
>is necessary so, even though it does affect performance, the
>system would not work without it.

I talked about irq disabling, not spinlocks. With or without spinlocks.
When you need synch between a bottom half(or user context) and irq
handler on single processor machine you can't use just spinlocks. you have to
disable the irq. so the question is about irq disabling to modify data
in a mutual way.
I solved it without disabling irq using a circular buffer (very simple one)
I think with this solution there is a better response time for the hardware
items. (they can get immediate response from the OS)

Gabor


