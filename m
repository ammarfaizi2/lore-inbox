Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUJFPML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUJFPML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJFPMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:12:10 -0400
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:5061 "EHLO
	pbl.ca") by vger.kernel.org with ESMTP id S269285AbUJFPLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:11:51 -0400
Message-ID: <41640C38.8010600@pbl.ca>
Date: Wed, 06 Oct 2004 10:16:08 -0500
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrea Arcangeli <andrea@novell.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost> <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au> <20041006020734.GA29383@havoc.gtf.org> <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com> <416369F9.7050205@yahoo.com.au> <41636D8B.8020401@pobox.com>
In-Reply-To: <41636D8B.8020401@pobox.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> You're making my point for me.  If the bandaid (preempt) is not active, 
> then the system can be accurated profiled.  If preempt is active, then 
> it is potentially hiding trouble spots.
> 
> The moral of the story is not to use preempt, as it
> * potentially hides long latency code paths
> * potentially introduces bugs, as we've seen with net stack and many 
> other pieces of code
> * is simply not needed, if all code paths are fixed

One can also look onto it from another angle:
* conviniently resolves long latency code paths that can't be avoided
* uncovers bugs that need to be fixed
* implicitly fixes code paths

It seems to me that you are mixing latency of the system, efficiency of 
the driver functions, and performance of the system in the way it suits 
your arguments.

Those three influent each other, but should be looked at and solved 
separately.

Preempt is a fix for latency.  It doesn't (and can't) fix efficiency and 
performace.  If you are using latency as a measure for efficiency and 
performance, you are mixing apples and oranges with bananas.

Unefficient driver function (or code path) will not become efficient if 
you sprinkle it with cond_resched (it will only reduce the latency of 
the system).  As you conviniently said, you are just putting band aid on 
the problem, instead of fixing it.  Not different than using preept 
kernel, really.  Only more time spent on it by developer, that might be 
used better somewhere else (like making code path more efficient).

Performance of the system might be a bit lower with preempt kernel.  But 
most of those that would notice or care (0.1% of users?  probably less) 
would probably be happier without cond_resched executed thousands a time 
per second too, and would happily sacrifice latency to high performance.

Finally, the bugs.  Bugs need to be fixed.  Period.  If bug goes away 
when somebody turns off preempt on uniprocessor system, it may as well 
hit back when you move to non-preempt SMP system in even more obscure 
ways (because than you really have code paths executed in parallel). 
Telling somebody to try with non-preempt kernel should be debugging 
step, not the solution.

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
