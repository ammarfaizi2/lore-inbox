Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275183AbRJFPYX>; Sat, 6 Oct 2001 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275229AbRJFPYN>; Sat, 6 Oct 2001 11:24:13 -0400
Received: from geos.coastside.net ([207.213.212.4]:45766 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S275183AbRJFPYJ>; Sat, 6 Oct 2001 11:24:09 -0400
Mime-Version: 1.0
Message-Id: <p05100304b7e4d1f5b152@[207.213.214.37]>
In-Reply-To: <1002379256.857.3.camel@thanatos>
In-Reply-To: <E15prGs-0001G3-00@the-village.bc.nu>
 <1002379256.857.3.camel@thanatos>
Date: Sat, 6 Oct 2001 08:24:51 -0700
To: Thomas Hood <jdthood@mail.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Question about rtc_lock
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:40 AM -0400 2001-10-06, Thomas Hood wrote:
>On Sat, 2001-10-06 at 09:13, Alan Cox wrote:
>>  > No, but what if the rtc interrupts while the lock is held in this
>>  > bit of code?
>>
>>  Thats fine. It wont take the lock
>
>But the first line of irq_interrupt() is:
>    spin_lock (&rtc_lock);
>
>If one has a multi-processor machine, and CPUx is going through
>the bootflag code, which takes the rtc_lock, and that CPU is
>interrupted and enters rtc_interrupt(), which tries to take the
>rtc_lock, won't it deadlock?
>
>If not, then I'm missing some clue about how these spinlocks work.

rtc_interrupt(), you mean.

Even if there weren't current interrupt code doing CMOS accesses, it 
would seem prudent to assume that there might be eventually, the 
RTC/NVRAM being a multi-purpose shared resource.
-- 
/Jonathan Lundell.
