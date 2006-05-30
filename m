Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWE3V5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWE3V5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWE3V5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:57:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:48290 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932516AbWE3V5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:57:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jAUTc62iDtwap3ptR9O40aVVJtBY8SnJGGTyEtnSSJWarUsaXDnSOdK33eE4/bgrCqpJDQB88ihDdqCARpwfV7T2HWS/mm0Ist47gjhhMtAAmmqWtFTnCjQ9yq6c88G1mWmagCDGGNqIeLo6SU5WSgqU05SebNmfZxPiy5X0/1E=
Message-ID: <6bffcb0e0605301457v9ba284bk75b8b6d14384489a@mail.gmail.com>
Date: Tue, 30 May 2006 23:57:10 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060530194259.GB22742@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
	 <6bffcb0e0605301157o6b7c5f66q3c9f151cbb4537d5@mail.gmail.com>
	 <20060530194259.GB22742@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/06, Ingo Molnar <mingo@elte.hu> wrote:
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > SCSI or libata problem.
>
> i think SCSI and libata is innocent here.
>
> > ============================
> > [ BUG: illegal lock usage! ]
> > ----------------------------
> > illegal {in-hardirq-W} -> {hardirq-on-W} usage.
>
> > 1 locks held by init/1:
> > #0:  (&base->lock#2){++..}, at: [<c0129a24>] lock_timer_base+0x29/0x55
> >
> > stack backtrace:
> > [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
> > [<c01044b3>] show_trace+0xd/0x10
> > [<c010457b>] dump_stack+0x19/0x1b
> > [<c0137d63>] print_usage_bug+0x1a1/0x1ab
> > [<c0138458>] mark_lock+0x2d7/0x514
> > [<c01386dc>] mark_held_locks+0x47/0x65
> > [<c0139745>] trace_hardirqs_on+0x12b/0x16f
> > [<c02f2b61>] restore_nocheck+0x8/0xb
>
> weird. We are holding base->lock#2 [CPU#1's timer base lock], _and_ we
> execute restore_nocheck - which is a return-to-userspace thing.
>
> unfortunately the stacktrace provides no clues of how we got here.
> For such nasty cases i have a kernel tracing patch prepared, you can get
> it from:
>
>   http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch
>
> just apply it ontop of your current tree and accept all the new .config
> options as the kernel suggests them to you.

I can't boot with that patch. I even don't see "Uncompressing
Linux..." - machine reboots.
I have 2.6.17-rc5-mm1 +
genirq-cleanup-remove-irq_descp-fix.patch
lock-validator-irqtrace-support-non-x86-architectures.patch
lock-validator-special-locking-sb-s_umount-2-fix.patch
from hot fixes
+
Arjan's net/ipv4/igmp.c patch.

BTW. I got error when compiling kernel/latency.c, so I change
if (DEBUG_WARN_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK))))

to

if (DEBUG_WARN_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK)))

Here is config
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config3

Here is "Kernel Bug : The Movie" (4,3MB)
www.stardust.webpages.pl/files/crap/kbtm.avi

[snip]
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
