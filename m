Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVHSVsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVHSVsQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVHSVsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:48:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32716 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965180AbVHSVsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:48:15 -0400
Message-ID: <43065440.5050608@us.ibm.com>
Date: Fri, 19 Aug 2005 14:50:56 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, "lkml, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6-rt9
References: <20050818060126.GA13152@elte.hu>
In-Reply-To: <20050818060126.GA13152@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.13-rc6-rt9 tree, which can be downloaded from 
> the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 

I'm looking into getting HRT and RT booting on a SUMMIT NUMA machine 
(cyclone timer), but after s/error/warning/ in arch/i386/timers/timer.c 
for the HRT cyclone ifdef, I still get the following link error:


   LD      .tmp_vmlinux1
net/built-in.o(.init.text+0xdae): In function `sock_ioctl':
net/socket.c:868: undefined reference to `__you_cannot_kmalloc_that_much'
make: *** [.tmp_vmlinux1] Error 1


I was expecting to be able to build the kernel, and have it crash on 
boot (due to unsynched TSCs I'm guessing) and then start debugging/devel 
from there.  But the the rt9 patch won't build (HRT standalone for 
2.6.10 does build).  Anyone else seeing this?

> it's a fixes-only release. Changes since 2.6.13-rc6-rt3:
> 
>  - USB irq flags use cleanups (Alan Stern)
> 
>  - RCU tasklist-lock fixes (Paul McKenney, Thomas Gleixner)
> 
>  - HR-timers waitqueue splitup, better HRT latencies (Thomas Gleixner)
> 
>  - latency tracer fixes, irq flags tracing cleanups (Steven Rostedt, me)
> 
>  - NFSd BKL unlock fix (Steven Rostedt)
> 
>  - stackfootprint-max-printer fix (Steven Rostedt)
> 
>  - stop_machine fix (Steven Rostedt)
> 
>  - lpptest fix (me)
> 
>  - turned off IOAPIC_POSTFLUSH when CONFIG_X86_IOAPIC_FAST. Now with
>    Karsten's VIA fixes my testbox does not show PCI-POST weirnesses
>    anymore. In case of IRQ problems please turn off IOAPIC_FAST. (me)
> 
> to build a 2.6.13-rc6-rt9 tree, the following patches should be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
>    http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc6-rt9
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185
