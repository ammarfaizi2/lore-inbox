Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWAZReh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWAZReh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWAZReh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:34:37 -0500
Received: from spirit.analogic.com ([204.178.40.4]:51730 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932358AbWAZReg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:34:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43D8FC76.2050906@symas.com>
X-OriginalArrivalTime: 26 Jan 2006 17:34:23.0075 (UTC) FILETIME=[BEF82B30:01C6229E]
Content-class: urn:content-classes:message
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Thu, 26 Jan 2006 12:34:12 -0500
Message-ID: <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Thread-Index: AcYinr8BXDDMkh21SVygFLvjxGVowg==
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Howard Chu" <hyc@symas.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Christopher Friesen" <cfriesen@nortel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <hancockr@shaw.ca>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2006, Howard Chu wrote:

> Nick Piggin wrote:
>> No, a spec is something that is written unambiguously, and generally
>> the wording leads me to believe they attempted to make it so (it
>> definitely isn't perfect - your mutex unlock example is one that could
>> be interpreted either way). If they failed to say something that should
>> be there then the spec needs to be corrected -- however in this case
>> I don't think you've shown what's missing.
>
> What is missing: sched_yield is a core threads function but it's defined
> using language that only has meaning in the presence of an optional
> feature (Process Scheduling.) Since the function must exist even in the
> absence of these options, the definition must be changed to use language
> that has meaning even in the absence of these options.
>
>> And actually your reading things into the spec that "they failed to say"
>> is wrong I believe (in the above sched_yield example).
>>
>>> interpretation would come from saying "hey, this spec is only defined
>>> for realtime behavior, WTF is it supposed to do for the default
>>> non-realtime case?" and getting a clear definition in the spec.
>>
>> However they do not omit to say that. They quite explicitly say that
>> SCHED_OTHER is considered a single priority class in relation to its
>> interactions with other realtime classes, and is otherwise free to
>> be implemented in any way.
>>
>> I can't see how you still have a problem with that...
>>
> I may be missing the obvious, but I couldn't find this explicit
> statement in the SUS docs. Also, it would not address the core
> complaint, that sched_yield's definition has no meaning when the Process
> Scheduling option doesn't exist.
>
> The current Open Group response to my objection reads:
> >>>
>
> Add to APPLICATION USAGE
> Since there may not be more than one thread runnable in a process
> a call to sched_yield() might not relinquish the processor at all.
> In a single threaded application this will always be case.
>
> <<<
> The interesting point one can draw from this response is that
> sched_yield is only intended to yield to other runnable threads within a
> single process. This response is also problematic, because restricting
> it to threads within a process makes it useless for Process Scheduling.
> E.g., the Process Scheduling language would imply that a single-threaded
> app could yield the processor to some other process. As such, I think
> this response is also flawed, and the definition still needs more work.
>
> --
>  -- Howard Chu
>  Chief Architect, Symas Corp.  http://www.symas.com
>  Director, Highland Sun        http://highlandsun.com/hyc
>  OpenLDAP Core Team            http://www.openldap.org/project/
>

To fix the current problem, you can substitute usleep(0); It will
give the CPU to somebody if it's computable, then give it back to
you. It seems to work in every case that sched_yield() has
mucked up (perhaps 20 to 30 here).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
