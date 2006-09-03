Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWICSQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWICSQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 14:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWICSQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 14:16:02 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:33356 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932071AbWICSQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 14:16:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ey801y+GqdCP4eq8YAi1eU1Y/X44kZZQ9c8NfMbDOJn7MhOqLnTpcJtJ7qSu4j59Izua1vLRKBUGzUP67qIyLpZw0nhBumLK+9SnpOTWLUgH0nZNyCf8APV4EeaXUa1HN31UDkS2u+oAMbkyZASjCJqTZFPYALqNkt9easwTKx8=
Message-ID: <a44ae5cd0609031115r3a0d10den8a86a79cd6c5756a@mail.gmail.com>
Date: Sun, 3 Sep 2006 11:15:59 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- BUG: MAX_STACK_TRACE_ENTRIES too low!
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0609031005u263aebebr6e53fb59e0153d0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
	 <20060903125458.GA21390@elte.hu>
	 <a44ae5cd0609031005u263aebebr6e53fb59e0153d0a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/06, Miles Lane <miles.lane@gmail.com> wrote:
> On 9/3/06, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Miles Lane <miles.lane@gmail.com> wrote:
> >
> > > Sorry Andrew.  I don't see clues here to help me target the report to
> > > a maintainer. I hope this helps.
> > >
> > > BUG: MAX_STACK_TRACE_ENTRIES too low!
> > > turning off the locking correctness validator.
> >
> > Miles, could you try the patch below? (Andrew: if this solves Miles'
> > problem then i think this is v2.6.18 material too. [The other
> > possibility would be some permanent stack-trace entries leak, in which
> > case the patch will not help. If that happens then we'll have to debug
> > this some more.])
> >
> >         Ingo
> >
> > ---------------->
> > From: Ingo Molnar <mingo@elte.hu>
> > Subject: lockdep: double the number of stack-trace entries
> >
> > Miles Lane reported the "BUG: MAX_STACK_TRACE_ENTRIES too low!" message,
> > which means that during normal use his system produced enough lockdep
> > events so that the 128-thousand entries stack-trace array got exhausted.
> > Double the size of the array.
> >
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > ---
> >  kernel/lockdep_internals.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Index: linux/kernel/lockdep_internals.h
> > ===================================================================
> > --- linux.orig/kernel/lockdep_internals.h
> > +++ linux/kernel/lockdep_internals.h
> > @@ -27,7 +27,7 @@
> >   * Stack-trace: tightly packed array of stack backtrace
> >   * addresses. Protected by the hash_lock.
> >   */
> > -#define MAX_STACK_TRACE_ENTRIES        131072UL
> > +#define MAX_STACK_TRACE_ENTRIES        262144UL
> >
> >  extern struct list_head all_lock_classes;
> >
> >
>
> Ingo, there seemed to be a difference between the file you editted and
>  the one in Andrew's tree.  I remade you patch so it applies cleanly.
> I'll test and let you know.  One word of caution, I only hit the
> problem once and I'm not sure how to trigger the condition.  I'll do
> my best.
>
> Thanks,
>         Miles
>
> --- kernel/lockdep_internals.h~ 2006-09-03 09:59:29.000000000 -0700
> +++ kernel/lockdep_internals.h  2006-09-03 10:00:55.000000000 -0700
> @@ -27,7 +27,7 @@
>   * Stack-trace: tightly packed array of stack backtrace
>   * addresses. Protected by the hash_lock.
>   */
> -#define MAX_STACK_TRACE_ENTRIES        131072UL
> +#define MAX_STACK_TRACE_ENTRIES        262144UL
>
>  extern struct list_head all_lock_classes;
>

By the way, after making this change "make all install modules
modules_install" didn't seem to notice that the file had been
modified.  I backed up .config, ran "make mrproper", etc.  Is this a
build dependency checker bug?

Thanks,
        Miles

-- 
VGER BF report: H 4.35163e-06
