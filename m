Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUGFDUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUGFDUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 23:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGFDUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 23:20:05 -0400
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:9935 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S262906AbUGFDT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 23:19:58 -0400
Message-ID: <40E9F6DB.6010705@bigpond.net.au>
Date: Tue, 06 Jul 2004 10:48:27 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Paul Davis <paul@linuxaudiosystems.com>, Matt Mackall <mpm@selenic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK
References: <20040701181401.GB21066@holomorphy.com> <200407020327.i623RT0J010592@localhost.localdomain> <20040702073749.GK21066@holomorphy.com> <s5h6596ae0f.wl@alsa2.suse.de>
In-Reply-To: <s5h6596ae0f.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Fri, 2 Jul 2004 00:37:49 -0700,
> William Lee Irwin III wrote:
> 
>>On Thu, Jul 01, 2004 at 01:03:56PM -0500, Matt Mackall wrote:
>>
>>>>>I'm afraid these "brave souls" have shown up to the baby shower after
>>>>>the child's been accepted to college. Developers getting around to
>>>>>testing 2.6 after multiple vendors are shipping it should not be
>>>>>characterized as courageous.
>>
>>On Thu, Jul 01, 2004 at 11:27:28PM -0400, Paul Davis wrote:
>>
>>>I call BS on this response.
>>>We were told by A(ndrew)M(orton) and several other people that 2.6
>>>would not be as good as 2.4 for low latency real time audio. It was
>>>made clear that the preemption patches were considered more
>>>appropriate even though they did not do anywhere near as reliable an
>>>improvement as AM's lowlat patches. We found out (and I mean no
>>>discredit to AM whatsoever - he did an amazing job on the 2.4 lowlat
>>>patches) that the author of the premiere lowlat patches for 2.4 would
>>>not be maintaining a similar set for 2.6. We also found during the
>>>development of 2.5 that there were a number of areas of real concern,
>>>(the VM subsystem and the scheduler and the disk subsystems) but that
>>>many notable kernel developers were not particularly interested in our
>>>needs - we were considered odd, edge case studies.
>>
>>Not only are lowlat-alike changes in mainline 2.6, the algorithms where
>>lowlat found explicit preemption points were necessary have been changed
>>in a number of cases to be asymptotically faster.
>>
>>So you gave no feedback. What do you expect us to do? There are
>>enough other bugreports to keep us busy without testing the known
>>universe on behalf of you or anyone else sitting around waiting
>>silently for their needs to magically be addressed.
> 
> 
> Well, the point is that no kernel developer is watching and working on
> low-latency fixes regulariy for 2.6 kernels, as Andrew did for every
> 2.4 release.  And, the users can't report easily what gets wrong.
> (If the report were something like '2.6.x worked but 2.6.y not', it
>  would be easy to figure out, but many users experience this problem
>  between 2.4 and 2.6...)
> 
> Maybe this situation can be improved by enabling the xrun_debug proc
> switch on ALSA, which shows the stack trace when a buffer
> over/underrun happens.  Also, running a latencytest program would be
> helpful for spotting out the problem.
> 
> 
> BTW, 2.6 kernel works pretty well on my system.  Perhaps it's because
> I run jackd directly as root.
> 
> I've also heard some people complaining after replacement with 2.6,
> too, but I believe it's either driver-specific problem or a bug caused
> by the NPTL incompatibility reported on this thread.
> AFAIK, there are still some problematic parts, for example, a long
> lock in shrink_dcache_parent(), and too-long RCU jobs in a tasklet,
> but they are relatively minor. 
> 
> 
> 
>>In summary:
>>(1) please try to present adequate information directly
>>	-- describe your situation directly instead of needing people
>>	-- to debug your apps for you
> 
> 
> The problem is the incompatibility between NPTL and LinuxThreads.
> As Paul pointed, if calling pthread_setschedparm() has no influence
> _after_ creating the thread, it sounds like a bug to me.  This might
> be a problem of glibc, not of kernel.  We don't know even it. 
> 
> Anyway, we'll need a small testcase to reproduce this problem...

Version 1.4 of the various SPA schedulers (for 2.6.7) are available for 
download at <https://sourceforge.net/projects/cpuse/>.  In this 
modification I have attempted to minimize the scheduling overhead costs 
for SCHED_FIFO tasks.  I would appreciate any feedback on how successful 
I have been.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

