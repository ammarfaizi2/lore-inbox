Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSHHKlo>; Thu, 8 Aug 2002 06:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSHHKlo>; Thu, 8 Aug 2002 06:41:44 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15628 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317436AbSHHKln>; Thu, 8 Aug 2002 06:41:43 -0400
Message-ID: <3D524A67.7030407@evision.ag>
Date: Thu, 08 Aug 2002 12:39:35 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: martin@dalecki.de, "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       linux-kernel@vger.kernel.org
Subject: Re: bad: schedule() with irqs disabled! (+ ksymoops)
References: <Pine.LNX.4.44.0208081218160.24255-100000@linux-box.realnet.co.sz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Zwane Mwaikambo napisa?:
> On Thu, 8 Aug 2002, Marcin Dalecki wrote:
> 
> 
>>I can report pretty the same:
>>
>>Trace; c0113f84 <try_to_wake_up+104/110>
>>Trace; c0113fa6 <wake_up_process+16/20>
>>Trace; c011d1f7 <do_softirq+a7/c0>
> 
> 
> What to do? Looks like do_softirq needs some work, also reading the 
> comments at the beginning of kernel/softirq.c is it preempt safe? This is 
> from looking at 'cpu = smp_processor_id' usage in do_softirq.

I think that you are right do_softirq is apparently in toruble.
Nowever the above only occurs when, I'm working on my notebook through
ssh X11 port forward login. So in this case there are likely
many overlapping IDE/eth0 IRQ comming through. And it's *really* the
eth part that matters. So it could simply be that the e8139too 
       driver deserves review in regards of proper lock protection.

