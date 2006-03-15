Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752111AbWCOPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbWCOPzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWCOPzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:55:43 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:60430 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1752111AbWCOPzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:55:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <3f250c710603150640y95617e3sfa7c8f8db005290b@mail.gmail.com>
x-originalarrivaltime: 15 Mar 2006 15:55:40.0983 (UTC) FILETIME=[E8F4A470:01C64848]
Content-class: urn:content-classes:message
Subject: Re: Jiffy is not able to measure the fraction of time a process runs a processor
Date: Wed, 15 Mar 2006 10:55:40 -0500
Message-ID: <Pine.LNX.4.61.0603151050220.13042@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Jiffy is not able to measure the fraction of time a process runs a processor
Thread-Index: AcZISOj72ai8xg7ITIyiFl/3Ta9jIg==
References: <3f250c710603130549w6ccdf14cu73a0d7d2999fd4ee@mail.gmail.com> <y0mveugagsm.fsf@ton.toronto.redhat.com> <3f250c710603150640y95617e3sfa7c8f8db005290b@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Mauricio Lin" <mauriciolin@gmail.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <craig.lkml@gmail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2006, Mauricio Lin wrote:

> Hi all,
>
> I have managed to measure the cpu time in nanoseconds. On i386 I have used
> the monotonic_clock() to measure the cpu time accurately.
>
> The cpu time measurements were based on t->sched_info.cpu_time, but
> instead of accumulate
> the all cpu time, I needed just the diff=jiffies
> -t->sched_info.last_arrival in the sched_info_depart().
>
> The problem was most of time the diff was zero. So to solve this
> problem I used the monotonic_clock() function that provides more accurate
> way to measure cpu time.
>
> Any comments?
>
> On 14 Mar 2006 15:54:17 -0500, Frank Ch. Eigler <fche@redhat.com> wrote:
>> "Mauricio Lin" <mauriciolin@gmail.com> writes:
>>
>>>  I am trying to measure the fraction of time a process runs on a
>>> processor, but the jiffies is not able to provide an accurate value.
>>
>> See sched_clock().
>
> I have checked it. It helped me to reach the monotonic_clock()
> function after hacking the code.
>
>>
>>>  The example below [...]
>>> PID  : NAME : LAST ARRIVAL : CPU TIME : CALLER
>>> 4544 : kmix : 6170433 : 0 : work_resched+0x6c
>>> 4078 : lpd : 6170433 : 0 : __down_interruptible+0x5
>>> 4544 : kmix : 6170433 : 0 : schedule_timeout+0xb8
>>
>> What tool/patchset are you using to generate this trace?
>
> I am using the relayfs to report the information I need among the
> processors. I just put some klog in some key points in the code.
>
> BR,
>
> Mauricio Lin.

Jiffies changes only 1000 times per second if it's set to 1000.
On a fast CPU this kind of coarse resolution will not give you
any useful information when trying to determine execution time.

You need to use the number of CPU clocks that it has taken.
This is obtained using rdtsc on ix86 machines.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
