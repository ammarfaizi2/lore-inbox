Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWH1U2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWH1U2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWH1U2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:28:52 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:6792
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751473AbWH1U2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:28:51 -0400
Date: Mon, 28 Aug 2006 13:28:27 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060828202827.GA3625@gnuppy.monkey.org>
References: <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com> <20060823202046.GA17267@gnuppy.monkey.org> <20060823210558.GA17606@gnuppy.monkey.org> <20060823210842.GB17606@gnuppy.monkey.org> <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com> <20060824014658.GB19314@gnuppy.monkey.org> <20060825071957.GA30720@gnuppy.monkey.org> <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com> <20060826104923.GA7879@gnuppy.monkey.org> <e6babb600608281133q3597c42dsa88820ddd82f9d01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608281133q3597c42dsa88820ddd82f9d01@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...resend...]

On Mon, Aug 28, 2006 at 11:33:59AM -0700, Robert Crocombe wrote:
> On 8/26/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >The function __put_task_struct() should never show up a stack trace
> >EVER. That function has been rename under all things
> >CONFIG_PREEMPT_RT
> >under my addendum patches. That's why I'm starting to think it's your
> >build environment or you're miss applying the patches.
>
> but is it used?
...
> +void fastcall __put_task_struct(struct task_struct *task)
> +{
> +       struct list_head *head;
> +
> +       head = &get_cpu_var(delayed_put_task_struct_list);
> +       list_add_tail(&task->delayed_drop, head);
> +
> +       _wake_cpu_desched_task();
> +
> +       put_cpu_var(delayed_put_task_struct_list);
> +}
> +#endif
> +
>
> So I think you're mistaken.  Patch is applied like this:

The patch is applied correctly.

This is what I'm having a problem with in your stack trace...

I was unclear in explain that __put_task_struct() should never
appear with free_task() in a stack trace as you can clearly see
from the implementation. All it's suppose to do is wake a thread,
so "how?" you're getting those things simultaneously in the stack
trace is completely baffling to me. Could you double check to see
if it's booting the right kernel ? maybe make sure that's calling
that version of the function with printks or something ?

bill

