Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVEKS7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVEKS7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEKS7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:59:45 -0400
Received: from pD9E8B3EE.dip.t-dialin.net ([217.232.179.238]:29444 "EHLO
	gateway2.croq.loc") by vger.kernel.org with ESMTP id S261245AbVEKS7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:59:42 -0400
Message-ID: <428255D5.7040105@free.fr>
Date: Wed, 11 May 2005 20:58:29 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Scheduler: SIGSTOP on multi threaded processes
References: <200505102112.j4ALCwXN002849@magilla.sf.frob.com>
In-Reply-To: <200505102112.j4ALCwXN002849@magilla.sf.frob.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roland

Thanks for your reply.

>>- Can a SIGSTOP be in a pending state in Linux?
> 
> For short periods.
> 
>>- If kill(SIGSTOP,...) returns, does that mean that the corresponding 
>>process is completly suspended?
> 
> No.  One or more threads of the process may still be running on another CPU
> momentarily before they process the interrupt and stop for the signal.


I get sometimes 150ms delay between the end of kill() and suspension of 
the last thread of the 3 threads, on a single-CPU system (Pentium 4).

It seems understandable to me to have a delay of <=1ms, especialy on SMP 
systems, but I really can't understand:

- the so big delays (like the 150ms)

- why only multi-threaded applications make problems

- why the policy of the programs has an impact on the results

- why for some executions, the SIGSTOP effect is instantaneous 100s of 
times in a row, until the end of the test, and the next execution shows 
delays right from the beginning


I don't have much experience hacking the kernel, are these behaviours 
are quite difficult for me to monitor or trace.
I am beginning to run out of ideas to test further :(

Could it be that my observations undercover a problem?
Or are the a consequence of the  Linux implementation?
Or do I have a problem in my test bench?

Can anyone reproduce and/or validate these observations?

Any hint would be appreciated!
