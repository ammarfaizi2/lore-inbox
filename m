Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRJJCJ2>; Tue, 9 Oct 2001 22:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJJCJR>; Tue, 9 Oct 2001 22:09:17 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:60432 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S273918AbRJJCJD>; Tue, 9 Oct 2001 22:09:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Tue, 9 Oct 2001 22:09:33 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@ufl.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random>
In-Reply-To: <20011010031803.F8384@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011010020912Z273918-760+23013@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 October 2001 21:18, Andrea Arcangeli wrote:
> On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> > mp3 player to skip, though.   That probably wont be fixed intil 2.5,
> > since you need to have preemption in the vm and the rest of the kernel.
>
> xmms skips during I/O should have nothing to do with preemption.
>
> As Alan noted for the ring of dma fragments to expire you need a
> scheduler latency of the order of seconds, now (assuming the ll points
> in read/write paths) when we've bad latencies under writes it's of the
> order of 10msec and it can be turned down further by putting preemption
> checks in the buffer lru lists write paths.
>
> The reason xmms skips I believe is because the vm is doing write
> throttling. I've at least one idea on how to fix it but it has nothing
> to do with preemption in the VM or whatever else scheduler related
> thing.
>
> So I wouldn't expect to fix any playback skips where buffering is
> possible by using the preemptive patch etc.. It's nearly impossible that
> it makes any difference.
>
> The preemptive patch can matter only if you're doing real time signal
> processing where any kind of buffering isn't possible.
>
> Andrea

That's what i would think too at first.  What's confusing me is the fact that 
it is affected by priority.  Which means preemption can solve the problem.  
If i run the mp3 player at nice -n -20, i get no skips.   Why else would that 
be if not that preemption is dictating that freeamp's process gets whatever 
it wants when it wants ?   
My question is why does freeamp need to be at -20 nice just to do it's thing 
when logic dictates that it should be dbench that skips and is throttled down 
when run at the same priority as freeamp and not freeamp, since freeamp isn't 
trying to abuse it's resources.   
I mean, if renicing the process allows it not to skip, what else is going on 
if it's not preemption,  isn't that what the purpose of the priorities are - 
preempting lower priorities?  Or is nice something totally different, 
separate from priorities?  
I'm not exactly seeing how renicing it to -20 and the kernel letting freeamp 
do what it wants over anything else does not fall under the definition of 
preemption.  It cant possibly have nothing to do with preemption of 
preemption directly effects it.

Ok, so maybe i'm wrong and it has nothing to do with preemption, if then what 
exactly is allowing freeamp to play perfectly when run with nice -n -20 and 
not at normal 0.   And why is that the default behavior of the kernel ?  It 
seems quite unfair in a multiuser-multiprocessing system. 
