Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263803AbTCVU36>; Sat, 22 Mar 2003 15:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263812AbTCVU36>; Sat, 22 Mar 2003 15:29:58 -0500
Received: from newglider.melbpc.org.au ([203.12.152.9]:54283 "EHLO
	relay9.melbpc.org.au") by vger.kernel.org with ESMTP
	id <S263803AbTCVU35>; Sat, 22 Mar 2003 15:29:57 -0500
Message-ID: <3E7CC836.4000707@melbpc.org.au>
Date: Sun, 23 Mar 2003 07:31:50 +1100
From: Tim Josling <tej@melbpc.org.au>
Organization: Melbourne PC User Group
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Philip.Blundell@pobox.com, linux-parport@torque.net
Subject: Re: [PATCH] to drivers/parport/ieee1284_ops.c to fix timing	dependent
 hang
References: <3E782567.3020008@melbpc.org.au>	 <1048278154.6017.2.camel@ixodes.goop.org>  <3E7C2BA0.4040100@melbpc.org.au> <1048355094.8537.11.camel@ixodes.goop.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.3.4(snapshot 20020706) (relay9)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeremy Fitzhardinge wrote:
> On Sat, 2003-03-22 at 01:23, Tim Josling wrote:
> 
>>According to my reading of the code, it should only happen in polled 
>>mode, but I have only one week of experience looking at kernel source.
> 
> 
> I'm wondering if a better fix might be to have something like:
> 
> 	if (wait * 2 > wait)
> 		wait *= 2;
> 
> at the bottom of the loop, so that the wrap-around doesn't happen.
> 

I tried
  wait *=2;
	if (wait > 10 * HZ)
		wait = 10 * HZ;
and that worked, so your theory would probably work. However to my mind 
it is a hack.

> 
>>So it should be a work-around, assuming interrupts work on the parallel 
>>port on your system :-). It is an very vexing problem, as I'm sure you know.
>>
>>By the way, LJ1100s tend to get page feeding problems about the time the 
>>warranty runs out, but HP has a free kit you can order to fix the problem.
> 
> 
> Yes, I just installed it.  It suddenly made the printer useful again, so
> I've printing more, and seeing the hangs.  I enabled interrupts, which
> seems to work OK.
> 
> 	J

Good. That (enabling interrupts fixes the problem) tends to add credence 
to my theory.

Happy printing!

Tim Josling


