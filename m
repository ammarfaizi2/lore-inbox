Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUGJAQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUGJAQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 20:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUGJAQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 20:16:40 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:58264 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264991AbUGJAQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 20:16:34 -0400
Message-ID: <40EF354F.9090903@kolivas.org>
Date: Sat, 10 Jul 2004 10:16:15 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Likelihood of rt_tasks
References: <40EE6CC2.8070001@kolivas.org> <40EF2FF2.6000001@bigpond.net.au>
In-Reply-To: <40EF2FF2.6000001@bigpond.net.au>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4BD00A7ACA3646424644FB6C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4BD00A7ACA3646424644FB6C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Con Kolivas wrote:
> 
>> A quick question about the usefulness of making rt_task() checks 
>> unlikely in sched-unlikely-rt_task.patch which is in -mm
>>
>> quote:
>>
>> diff -puN include/linux/sched.h~sched-unlikely-rt_task 
>> include/linux/sched.h
>> --- 25/include/linux/sched.h~sched-unlikely-rt_task    Fri Jul  2 
>> 16:33:01 2004
>> +++ 25-akpm/include/linux/sched.h    Fri Jul  2 16:33:01 2004
>> @@ -300,7 +300,7 @@ struct signal_struct {
>>
>>  #define MAX_PRIO        (MAX_RT_PRIO + 40)
>>
>> -#define rt_task(p)        ((p)->prio < MAX_RT_PRIO)
>> +#define rt_task(p)        (unlikely((p)->prio < MAX_RT_PRIO))
>>
>>  /*
>>   * Some day this will be a full-fledged user tracking system..
>>
>> ---
>> While rt tasks are normally unlikely, what happens in the case when 
>> you are scheduling one or many running rt_tasks and the majority of 
>> your scheduling is rt? Would it be such a good idea in this setting 
>> that it is always hitting the slow path of branching all the time?
> 
> 
> Even when this isn't the case you don't want to make all rt_task() 
> checks "unlikely".  In particular, during "wake up" using "unlikely" 
> around rt_task() will increase the time that it takes for SCHED_FIFO 
> tasks to get onto the CPU when they wake which will be bad for latency 
> (which is generally important to these tasks as evidenced by several 
> threads on the topic).

Well I dont think making them unlikely is necessary either, but 
realistically the amount of time added by the unlikely() check will be 
immeasurably small in real terms - and hitting it frequently enough will 
be washed over by the cpu as Ingo said. I dont think the order of 
magnitude of this change is in the same universe as the problem of 
scheduling latency that people are complaining of.

Con

--------------enig4BD00A7ACA3646424644FB6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7zVUZUg7+tp6mRURAi6+AJ9KYbPy4LBrT7c7pRwX6WgRWMZnMQCgi6Xv
TnwurCcjthtyTtg4sI0GkeY=
=NCPr
-----END PGP SIGNATURE-----

--------------enig4BD00A7ACA3646424644FB6C--
