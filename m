Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030638AbVKISJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbVKISJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030652AbVKISJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:09:13 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:8967 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1030638AbVKISJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:09:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <7d40d7190511090924k6ef493dbn@mail.gmail.com>
References: <7d40d7190511090749j3de0e473x@mail.gmail.com> <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com> <7d40d7190511090856x24fd68f5g@mail.gmail.com> <Pine.LNX.4.61.0511091158350.10894@chaos.analogic.com> <7d40d7190511090924k6ef493dbn@mail.gmail.com>
X-OriginalArrivalTime: 09 Nov 2005 18:09:08.0419 (UTC) FILETIME=[ADB5E930:01C5E558]
Content-class: urn:content-classes:message
Subject: Re: Stopping Kernel Threads at module unload time
Date: Wed, 9 Nov 2005 13:09:07 -0500
Message-ID: <Pine.LNX.4.61.0511091306090.11232@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stopping Kernel Threads at module unload time
Thread-Index: AcXlWK29UK/1oRR7QPq/xQ0U77D0Aw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Aritz Bastida" <aritzbastida@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2005, Aritz Bastida wrote:

>>
>>> Now, if I call kthread_stop() in module unload time, does that code
>>> run in user process context just like system calls do? That is
>>> important, because if it cannot sleep, it would deadlock.
>>>
>>
>> Not relevent. You have apparently made up your mind that you
>> need to do it "your" way. Fine.
>
> No, no, that is not MY way. That is the 2.6 way.
> (see http://lwn.net/Articles/64444/).
>
> With the old API (kernel_thread) there was no way (at least, direct
> way) to bind a thread to a cpu, which i actually need. And this is not
> MY own approach , it is used throught the kernel:
>
> * migration thread at sched.c:
>           http://lxr.linux.no/source/kernel/sched.c#L4196
>
> * ksoftirqd thread at softirq.c:
>           http://lxr.linux.no/source/kernel/softirq.c#L350
>
> * worker thread used in workqueues:
>           http://lxr.linux.no/source/kernel/workqueue.c#L182
>
> ...and so on
>
> All these threads are standard and well debugged, and all use the API
> which I was talking about. Of course, as they are included in the
> official kernel sources, none of them is stopped at module unload
> time.
>
> Thus, all I want to know is why kthread_stop() cant be called at
> module unload time, if the cleanup code can sleep and if there is a
> workaround for that.
>
> I hope my questions are clearer now.
> Thanks for your help

Then if you are going to use the macros to bind to a certain CPU
when you start up a kernel thread, then you need to use the
complimenting macros to run them down.

You need to use the for_each_cpu() stuff to pick up each thread.
Then you may actually get to talk to the right process.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
