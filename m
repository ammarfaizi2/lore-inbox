Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbTCOVxl>; Sat, 15 Mar 2003 16:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbTCOVxl>; Sat, 15 Mar 2003 16:53:41 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:59380 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261598AbTCOVxj>; Sat, 15 Mar 2003 16:53:39 -0500
Message-Id: <200303152204.h2FM4RnB683562@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: dan carpenter <d_carpenter@sbcglobal.net>
To: wrlk@riede.org, Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Any hope for ide-scsi (error handling)?
Date: Sat, 15 Mar 2003 05:43:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com> <20030315210120.GI7082@linnie.riede.org>
In-Reply-To: <20030315210120.GI7082@linnie.riede.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 March 2003 10:01 pm, Willem Riede wrote:
> It may not be elegant to schedule(1) with the lock taken, but it
> does work.
>
> However, my latest patch doesn't seem to be applied, since in my
> version I have a set_current_state(TASK_INTERRUPTIBLE); before
> the schedule.

I don't see how it works.

spin_lock_irqsave() increments  preempt_count()
in_atomic checks is defined as:
# define in_atomic()    ((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
kernel_locked() is defined as:
#define kernel_locked()         (current->lock_depth >= 0)

If you call schedule while in_atomic() then it prints out the error 
"bad: scheduling while atomic!\n".  

As far as I can see set_current_state() doesn't affect
preempt_count() or current->lock_depth.  I must be 
missing something...

regards,
dan carpenter

