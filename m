Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289932AbSAKVTc>; Fri, 11 Jan 2002 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290117AbSAKVTX>; Fri, 11 Jan 2002 16:19:23 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28155 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289932AbSAKVTH>; Fri, 11 Jan 2002 16:19:07 -0500
Message-ID: <3C3F56A0.E1240EE6@mvista.com>
Date: Fri, 11 Jan 2002 13:18:24 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, kpreempt-tech@lists.sourceforge.net,
        mingo@elte.hu, torvalds@transmeta.com
Subject: Re: [PATCH] Preemptive Kernel for Ingo's O(1) scheduler
In-Reply-To: <1010783095.819.61.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> A version of preempt-kernel is now available for Ingo's O(1) scheduler.

Great!  Well done.
> 
> For 2.5.2-pre11:
>         ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.5/preempt-kernel-rml-2.5.2-pre11-1.patch
> For 2.4.18-pre3 + sched-O1-H6:
>         ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/ingo-O1-sched/preempt-kernel-rml-2.4.18-pre3-ingo-1.patch
> 
> Because of changes in load_balance, I suggest not using preempt-kernel
> and an additional sched update on 2.5.  I'll update as the patches are
> merged into 2.5.
> 
> Making the kernel fully preemptible should be synergistic with Ingo's
> scheduler with its faster task dispatch time and better RT support.
> 
> Getting the two to play together was not hard, albeit a bit of a pain.
> The actually scheduling support is less, due to the simplified schedule
> and schedule_tail, although there is added code for making the per-CPU
> runqueues preempt-safe.
> 
> Benchmarks:
> 
> 2.5.2-pre11 dbench 16:          24.5364 MB/s
> 2.5.2-pre11-preempt dbench 16:  27.5192 MB/s
> 
> 2.5.2-pre11 latencytest:
> worst-case latency is 18.7ms with 96% scheduling latency on-time
> 2.5.2-pre11-preempt latencytest:
> 6ms (<1.5ms in all but disk write) with 99.9% scheduling latency on-time
> 
> 2.5.2-pre11-preempt avg latency is 1.1ms (for an arbitray work-load I
> tested with).  The obstacle for sub-ms average latency is still the
> long-held spinlocks that can be 100ms+.
> 
> Full ChangeLog:
> 
> - make preempt-kernel and Ingo's O(1) scheduler play nicely
> 
> - (2.5 only) more include additions
> 
> - various cleanups and such
> 
> Comments, patches, etc. are appreciated.  While it is running stable
> here in both SMP and UP on both 2.4 and 2.5, more testing could reveal
> problems.  Also, some optimization could be done at this point to
> hopefully reduce overhead.  Enjoy,
> 
>         Robert Love

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
