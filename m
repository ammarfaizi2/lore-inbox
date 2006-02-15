Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWBOTuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWBOTuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWBOTuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:50:03 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:54221 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1750992AbWBOTuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:50:01 -0500
Message-ID: <43F385C1.9020508@nortel.com>
Date: Wed, 15 Feb 2006 13:49:21 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ulrich Drepper <drepper@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
References: <20060215151711.GA31569@elte.hu> <p73lkwc5xv2.fsf@verdi.suse.de> <43F36A00.602@redhat.com> <200602151942.20494.ak@suse.de>
In-Reply-To: <200602151942.20494.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 19:49:23.0867 (UTC) FILETIME=[EBADEEB0:01C63268]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 15 February 2006 18:50, Ulrich Drepper wrote:
>>Andi Kleen wrote:
>>
>>>e.g. you could add a new VMA flag that says "when one user
>>>of this dies unexpectedly by a signal kill all" 
>>
>>"kill all"?  

> It would solve the problem statement given by Ingo in the rationale 
> for this kernel patch - cleaning up after a hanging yum. 
> 
> If there are any other problems this is intended to solve then they 
> should be stated in the rationale.

"robust" mutexes isn't a new thing, so I assume Ingo didn't think he 
needed to post the whole rationale.

Consider a group of tasks that want to use a mutex to control access to 
data.  If one of them dies while holding the mutex, the state of the 
data is unknown and the mutex is left locked.

The goal is for the kernel to unlock the mutex, but the next task to 
aquire it gets some special notification that the status is unknown.  At 
that point the task can either validate/clean up the data and reset the 
mutex to clean (if it can) or it can give up the mutex and pass it on to 
some other task that does know how to validate/clean up.

You want the speed of futexes if possible.  You want to keep running. 
You just want to know that the data protected by the mutex may not be 
self-consistent.

Chris
