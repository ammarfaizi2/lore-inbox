Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130103AbRBTMbK>; Tue, 20 Feb 2001 07:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBTMbB>; Tue, 20 Feb 2001 07:31:01 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:10096 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129129AbRBTMa3>; Tue, 20 Feb 2001 07:30:29 -0500
Date: Tue, 20 Feb 2001 06:29:34 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Linux 2.4.1-ac15 
In-Reply-To: <32669.982619549@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.96.1010220062015.9350B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Keith Owens wrote:
> On Mon, 19 Feb 2001 16:04:07 +0000 (GMT), 
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Using wait_for_at_least_one_schedule_on_every_cpu() has no penalty
> except on the process running rmmod.  It does not require yet more
> spinlocks and is architecture independent.  Since schedule() updates
> sched_data->last_schedule, all the rmmod process has to do is wait
> until the last_schedule value changes on all cpus, forcing a reschedule
> if necessary.
> 
> Zero overhead in schedule, zero overhead in exception handling, zero
> overhead in IA64 unwind code, architecture independent.  Sounds good to
> me.

Not architecture independent unfortunately.  get_cycles() always returns 0
on some SMP-capable machines.

->last_schedule doesn't change if one CPU is always idle (kernel threads
do), or always running the same process (kernel threads do, unless it's an
RT process in an endless loop).  I'm not sure how you'd go about "forcing
a reschedule if necessary".

Using temporary kernel threads has zero overhead in {schedule, exception
handling, IA64 unwind code} and actually works on all architectures.  It
adds overhead to the wait_for_at_least_one_schedule_on_every_cpu() code,
but I think that's acceptable.

