Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUGZBBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUGZBBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUGZBBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:01:46 -0400
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:33486 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264767AbUGZBBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:01:41 -0400
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040725174849.75f2ecf6.akpm@osdl.org>
Message-ID: <cone.1090803691.689003.20693.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Date: Mon, 26 Jul 2004 11:01:31 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

>> > But decreasing /proc/sys/vm/swappiness does that too?
>> 
>> Low memory boxes and ones that are heavily laden with applications find that 
>> ends up making things slow down trying to keep all applications in physical 
>> ram.
> 
> Doesn't that mean that swappiness was decreased by too much?

Sure does. But the desired effect when it's not applications is that of 
swappiness being excruciatingly low so people end up doing that. Then they 
find themselves dropping it at nighttime and increasing it during the day.

>> >> It has no measurable effect on any known benchmarks.
>> > 
>> > So how are we to evaluate the desirability of the patch???
>> 
>> Get desktop users to report back their experiences which is what I have 
>> currently. Sorry we're in the realm of subjectivity again.
> 
> Seriously, we've seen placebo effects before...

I am in full agreement there... It's easy to see that applications do not 
swap out overnight; but i'm having difficulty trying to find a way to 
demonstrate the other part. I guess timing the "linking the kernel with full 
debug" on a low memory box is measurable.

>> > Shouldn't mapped_bias be local to refill_inactive_zone()?
>> 
>> That is so a followup patch can use it elsewhere...
> 
> erk.  I guess it's OK because the thing is derived from global state which
> changes slowly over time.
> 
>> > Why is `swappiness' getting squared?  AFAICT this will simply make the
>> > swappiness control behave nonlinearly, which seems undesirable?
>> 
>> To parallel the nonlinear nature of the mapped bias effect. 
> 
> That doesn't really answer my question?  What goes wrong if swappiness is
> not squared?

Oh sorry, perhaps I should have said - that keeps people's current settings 
meaningful, but that can happily be broken. That would make the default 
setting something like 34 instead of 60.

Cheers,
Con

