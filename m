Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWAZTOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWAZTOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWAZTOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:14:53 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:64786 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S964814AbWAZTOw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:14:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43D91C33.7050401@yahoo.com.au>
X-OriginalArrivalTime: 26 Jan 2006 19:14:17.0952 (UTC) FILETIME=[B431CE00:01C622AC]
Content-class: urn:content-classes:message
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Thu, 26 Jan 2006 14:14:17 -0500
Message-ID: <Pine.LNX.4.61.0601261405320.9584@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Thread-Index: AcYirLQ79/tViC5KQsOB9w94w3tjyQ==
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43D91C33.7050401@yahoo.com.au>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Howard Chu" <hyc@symas.com>, "Lee Revell" <rlrevell@joe-job.com>,
       "Christopher Friesen" <cfriesen@nortel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <hancockr@shaw.ca>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2006, Nick Piggin wrote:

> linux-os (Dick Johnson) wrote:
>>
>> To fix the current problem, you can substitute usleep(0); It will
>> give the CPU to somebody if it's computable, then give it back to
>> you. It seems to work in every case that sched_yield() has
>> mucked up (perhaps 20 to 30 here).
>>
>
> That sounds like a terrible hack.
>
> What cases has sched_yield mucked up for you, and why do you
> think the problem is sched_yield mucking up? Can you solve it
> using mutexes?
>
> Thanks,
> Nick

Somebody wrote code that used Linux Threads. We didn't know
why it was so slow so I was asked to investigate. It was
a user-interface where high-speed image data gets put into
a buffer (using DMA) and one thread manipulates it. Another
thread copies and crunches the data, then displays it. The
writer insisted that he was doing the correct thing, however
the response sucked big time. I ran top and found that the
threaded processes were always grabbing big chunks of
CPU time. Searching for every instance of sched_yield(), I
was going to replace it with a diagnostic. However, the code
ran beautifully when the 'fprintf(stderr, "Message\n"' was
in the code! The call to write() sleeps. That gave the
CPU to somebody who was starving. The 'quick-fix" was
to replace sched_yield() with usleep(0).

The permanent fix was to not use threads at all.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
