Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130944AbRBSEOG>; Sun, 18 Feb 2001 23:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131040AbRBSEN4>; Sun, 18 Feb 2001 23:13:56 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:9208 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130944AbRBSENn>; Sun, 18 Feb 2001 23:13:43 -0500
Message-ID: <3A908D69.A9130BCD@mvista.com>
Date: Sun, 18 Feb 2001 19:05:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie <jamie@blah123.fsnet.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel timers and jiffie wrap-around
In-Reply-To: <20001129224354.B07C19F14F@jade.local.jnet>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie wrote:
> 
> Hi !
> 
> I've been trying to determine the reliability of kernel timers when a box has been up for a while. Now as everyone is aware (for HZ=100 (default)), when the uptime of the kernel reaches (approx.) 1.3 years the clock tick count (jiffies) wraps-around. Now if a kernel timer is added just before the wrap-around then from the source I get the impression the kernel timer will be run immediately instead of after the specified delay. Here's my reasoning:
> 
> When adding a timer the internal_add_timer() function is (eventually) called. Given that the current jiffies is close to maximum for an unsigned long value then the following index value is computed:
> 
>         // jiffies = ULONG_MAX - 10, say.
>         // so timer_jiffies is close to jiffies.
>         // timer.expires = jiffies + TIMEOUT_VALUE, where TIMEOUT_VALUE=200, say.
> 
>         index = expires - timer_jiffies;
> 
> Thus index is a large negative number resulting in the timer being added to tv1.vec[tv1.index] which means that the timer is run on the next execution of run_timer_list().

Now just how did you arrive at this?  What value _is_ ULONG_MAX+190?  It
rolls over to 190.  But you should think of timer_jiffies as 0-10 (in
your case) so index=190+10 or the desired 200.  No need to tweak the
kernel, just try some simple C code.  It all works until the requested
time out is greater than ULONG_MAX/2 (about .68 years).

George

   snip~
> 
> Surely I've misunderstood something in the timer code ?

Now you have a good interview question for that next potential new hire
:)

snip~
