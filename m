Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274910AbRIXTcT>; Mon, 24 Sep 2001 15:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274909AbRIXTcI>; Mon, 24 Sep 2001 15:32:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:101 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274907AbRIXTcB>; Mon, 24 Sep 2001 15:32:01 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "Christopher K. St. John" <cks@distributopia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010920101821.davidel@xmailserver.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2001 13:23:13 -0600
In-Reply-To: <XFMail.20010920101821.davidel@xmailserver.org>
Message-ID: <m1adzk75r2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On 20-Sep-2001 Christopher K. St. John wrote:
> > Davide Libenzi wrote:
> >> 
> >> Here are examples basic functions when used with
> >> coroutines.
> >>
> >  
> >  I think all might be made clear if you did a quick
> > test harness that didn't use coroutines. I'm guessing
> > the vast majority of potential users will not be using
> > a coroutine library.
> > 
> >  On "nio-improve" page, you've got:
> > 
> >         for (;;) {
> >           evp.ep_timeout = STD_SCHED_TIMEOUT;
> >           evp.ep_resoff = 0;
> >           nfds = ioctl(kdpfd, EP_POLL, &evp);
> >           pfds = (struct pollfd *) (map + evp.ep_resoff);
> >           for (ii = 0; ii < nfds; ii++, pfds++) {
> >              ...
> >           }
> >         }
> 
> Coroutines or not, this does not change the picture.
> All multiplexed servers have an IO driven scheduler that calls
> code sections based on the fd.
> Obviously if you've a one-thread-per-socket model, epoll is not your answer.

A couroutine is a thread, the two terms are synonyms.  Generally
coroutines refer to threads with a high volumne of commniucation
between them.  And the terms come from different programming groups.

However a fully cooperative thread (as is implemented in the current
coroutine library) can be quite cheap, and is a easy way to implement
a state machine.  A pure state machine will have a smaller data
footprint than the stack of a cooperative thread, but otherwise
the concepts are pretty much the same.  Language support for
cooperative threads, so you could verify you wouldn't overflow your
stack would be very nice. 

So epoll is a good solution if you have a one-thread-per-socket model,
and you are doing cooperative threads.  The thread being used here is
simply a shortcut to writing a state machine.

Eric
