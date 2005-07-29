Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVG2QQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVG2QQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVG2QQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:16:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60807 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262633AbVG2QQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:16:12 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<159600000.1122616708@[10.10.2.4]>
	<20050728230820.236cba84.akpm@osdl.org>
	<197380000.1122650508@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 10:15:58 -0600
In-Reply-To: <197380000.1122650508@[10.10.2.4]> (Martin J. Bligh's message
 of "Fri, 29 Jul 2005 08:21:48 -0700")
Message-ID: <m1hded4mgx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> writes:

>> From: Eric W. Biederman <ebiederm@xmission.com>
>> 
>> sync_tsc was using smp_call_function to ask the boot processor to report
>> it's tsc value.  smp_call_function performs an IPI_send_allbutself which is
>> a broadcast ipi.  There is a window during processor startup during which
>> the target cpu has started and before it has initialized it's interrupt
>> vectors so it can properly process an interrupt.  Receveing an interrupt
>> during that window will triple fault the cpu and do other nasty things.
>
> Wheeeeeeee! that does indeed seem to work. Nice job. 

Welcome.  I hadn't how many people were tracking this.

>> I believe this patch suffers from apicid versus logical cpu number
>> confusion.  I copied the basic logic from smp_send_reschedule and I can't
>> find where that translates from the logical cpuid to apicid.  So it isn't
>> quite correct yet.  It should be close enough that it shouldn't be too hard
>> to finish it up.
>> 
>> More bug fixes after I have slept but I figured I needed to get this
>> one out for review.
>
> Eric, when you have a final version, throw it over to me, and I'll give
> that one a spin-test too ...

With respect to the fix that is final.  The rest of the bug
fixes in my queue are for other problems.    

Mostly my concerns are with respect to apicid vs logical cpu
numbers that I'm not certain are handled properly in the code.
genapic_flat doesn't seem to do any translation.  And I don't
recall if boot_cpu_id is an apic_id or a logical cpu number.
On most hardware it is 0 in either case so it doesn't matter.

Eric

