Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbUK3EOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUK3EOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUK3EOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:14:44 -0500
Received: from lakermmtao07.cox.net ([68.230.240.32]:33754 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261973AbUK3EOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:14:42 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEFPACAB.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKAEFPACAB.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5AC4B64A-4286-11D9-8639-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: jonathan@jonmasters.org, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Concurrent access to /dev/urandom
Date: Mon, 29 Nov 2004 23:14:40 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2004, at 21:31, David Schwartz wrote:
>> Especially when used on a box without any effective entropy source - 
>> like
>> praktically most cheap servers stashed away into some rack.
> 	Assuming most of your cheap servers are running some version of the 
> Intel
> Pentium or comparable, they have wonderful entropy sources. Nobody can
> predict the oscillator offset between the crystals in the network 
> cards on
> both ends and the TSC. This entropy source is mined by the kernel.

Even timer interrupts are incredibly unpredictable.  Instructions can 
take
variable times to complete, and all instructions plus some indeterminate
cache operations and queue flushing must occur before the CPU can
even begin to service an interrupt.  Also of note, there are small 
critical
sections with interrupts disabled scattered all over the kernel and 
scheduler,
in addition to varying memory latencies, etc. (NOTE: I am not an arch 
expert
so this is all just a very general overview of the way most kinds of 
CPUs
handle interrupts).  In general these unpredictable instabilities have a
randomization effect on the low bits of the TSC at each timer interrupt,
(or arch equivalent).  The same thing goes for most other such events.  
I
suspect that the computational power necessary to provide a useful model
of such a system would be so tremendous you would have an easier job
just trying all the possible cryptographic keys. :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


