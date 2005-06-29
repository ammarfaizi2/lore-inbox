Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVF2AnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVF2AnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVF2AmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:42:24 -0400
Received: from smtp-2.llnl.gov ([128.115.250.82]:4094 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S261457AbVF2Ac7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:32:59 -0400
Date: Tue, 28 Jun 2005 17:32:49 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <Pine.LNX.4.63.0506281513001.5191@ghostwheel.llnl.gov>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0506281713240.2256@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net>
 <200506251039.14746.gene.heskett@verizon.net>
 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
 <1119902991.4794.5.camel@dhcp153.mvista.com>
 <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain>
 <20050628081843.GA16455@elte.hu> <20050628091222.GA30629@elte.hu>
 <Pine.LNX.4.63.0506281513001.5191@ghostwheel.llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Chuck Harding wrote:

> On Tue, 28 Jun 2005, Ingo Molnar wrote:
>
>> 
>> * Ingo Molnar <mingo@elte.hu> wrote:
>> 
>>> * Steven Rostedt <rostedt@goodmis.org> wrote:
>>> 
>>>> Although turning off apm works, this is a fix to the symptom and not a
>>>> cure.  Has someone already taken a look at this code? Since
>>>> apm_bios_call_simple calls local_save_flags and afterwards
>>>> raw_lock_irq_restore is then called.  Shouldn't that have been
>>>> raw_local_save_flags?
>>> 
>>> ah, indeed. I fixed this bug and have uploaded the -50-26 patch.
>>> Chuck, does this fix the APM problems for you?
>> 
>> i've also uploaded -50-27 in which i've improved the irq-flags debugging
>> code. They are activated if CONFIG_DEBUG_PREEMPT is enabled, and can
>> come in two variants of kernel messages:
>> 
>> BUG: bad raw irq-flag value 80000000, test/3810!
>> BUG: bad soft irq-flag value 00000202, test/3810!
>> 
>> so we should now be able to detect mismatches of irq flags right where
>> they occur.
>>
>> 	Ingo
>
> Ack!! I didn't have that enabled so I am rebuilding again. One thing I've
> noticed is that sox seems to be hanging when it is trying to play a .wav
> file (for system beeps) and there aren't any error messages about what
> might be going on.
>
>

More info - sox is locked up so tight that no kill can stop it. I'm not
seeing any of the BUG messages either even though I enabled 
CONFIG_DEBUG_PREEMPT.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- LISP: To call a spade a thpade. --
