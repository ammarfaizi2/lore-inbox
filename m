Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVCWVKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVCWVKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVCWVIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:08:00 -0500
Received: from alog0321.analogic.com ([208.224.222.97]:45972 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262937AbVCWU4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:56:23 -0500
Date: Wed, 23 Mar 2005 15:56:12 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Arjan van de Ven <arjan@infradead.org>
cc: sounak chakraborty <sounakrin@yahoo.co.in>, linux-kernel@vger.kernel.org
Subject: Re: repeat a function after fixed time period
In-Reply-To: <1111610935.6306.97.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0503231551570.16734@chaos.analogic.com>
References: <20050323194308.8459.qmail@web53307.mail.yahoo.com> 
 <Pine.LNX.4.61.0503231522070.16567@chaos.analogic.com>
 <1111610935.6306.97.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Arjan van de Ven wrote:

>
>>
>> This kernel code should do just fine.
>>
>>
>>
>> struct INFO {
>>      struct timer_list timer;            // For test timer
>>      atomic_t running;                   // Timer is running
>>      };
>>
>> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
>> //
>> //   This stops the timer. This must NOT be called with a spin-lock
>> //   held.
>> //
>> static void stop_timer()
>> {
>>      if(atomic_read(&info->running))
>>      {
>>          atomic_dec(&info->running);
>
> this is a race.

No, never. stop_timer() can be called at any time, even from
interrupt context. The last guy to touch info->running wins.
The logic works just perfectly.

>
>>          if(info->timer.function)
>>              del_timer(&info->timer);
>
> you probably want del_timer_sync() here.
>
>
>> static void start_timer(void)
>> {
>>      if(!atomic_read(&info->running))
>>      {
>>          atomic_inc(&info->running);
>
> same race.

No such race at all.


>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
