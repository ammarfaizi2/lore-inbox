Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWAZDtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWAZDtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWAZDtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:04 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:27406 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932195AbWAZDtC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PPbLqW7KS4fZaltTCYLwPhbXAgNwZspDDQ+NP99gCI8YN5DJeeWzR1Os/AJgnuAEQpZejC6NSpWqQuGzsiqUNSxOEj54NbSrFmuA+xVRw/clHlZSMgNTfyK5KL0VSNl2Cq5M8ZRhDHp2BOzjY7bZ+d/q0seKhNH62cB0L+bCRgE=
Message-ID: <93564eb70601251949r1fb4c209t@mail.gmail.com>
Date: Thu, 26 Jan 2006 12:49:00 +0900
From: Samuel Masham <samuel.masham@gmail.com>
To: davids@webmaster.com
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Cc: lkml@rtr.ca, Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEJPJKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D8386B.6000204@rtr.ca>
	 <MDEHLPKNGKAHNMBLJOLKGEJPJKAB.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/06, David Schwartz <davids@webmaster.com> wrote:
>
> > >     So you cannot write an application that can tell the difference.
>
> > Not true.  The code for the relinquishing thread could indeed
> > tell the difference.
> >
> > -ml
>
>         It can tell the difference between the other thread getting the mutex first
> and it getting the mutex first. But it cannot tell the difference between an
> implementation that puts random sleeps before calls to 'pthread_mutex_lock'
> and an implementation that has the allegedly non-compliant behavior. That
> makes the behavior compliant under the 'as-if' rule.
>
>         If you don't believe me, try to write a program that prints 'non-compliant'
> on a system that has the alleged non-compliance but is guaranteed not to do
> so on any compliant system. It cannot be done.

Just putting priority inheritance on then in the running thread check
your priority, if it goes up then the waiting thread in really
waiting.

Then if you can release + get the lock again its non compliant.... no?

ie    pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int
protocol); with PTHREAD_PRIO_INHERIT

comment:
As a rt person I don't like the idea of scheduler bounce so the way
round seems to be have the mutex lock acquiring work on a FIFO like
basis.


>         In order to claim the alleged compliance, you would have to know that a
> thread waiting for a mutex did not get it. But there is no possible way you
> can know that another thread is waiting for the mutex (as opposed to being
> about to wait for it). So you can never detect the claimed non-compliance,
> so it's not non-compliance.
>
>         This is definitive, really. It 100% refutes the claim.
>
>         DS
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
