Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWJEJCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWJEJCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWJEJCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:02:47 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:64434 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751258AbWJEJCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:02:46 -0400
Date: Thu, 5 Oct 2006 13:02:15 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061005090214.GB1015@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru> <4523ED6C.9080902@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4523ED6C.9080902@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 05 Oct 2006 13:02:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:20:44AM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> > It is completely possible to do what you describe without special
> > syscall parameters.
> 
> First of all, I don't see how this is efficiently possible.  The mask
> might change from call to call.

And you can add/remove signal events using existing kevent api between
calls.

> Second, hasn't it sunk in that inventing new ways to pass parameters is
> bad?  Programmers don't want to learn new ways for every new interface.
>  Reuse is good!

And creating special cases for usual events is bad.
There is unified way to deal with events in kevent -
add/remove/modify/wait on them, signals are just usual events.

> This applies to the signal mask here.
> 
> But there is another parameter falling into that category and I meant to
> mention it before: the timeout value.  All other calls except poll and
> especially all modern interfaces use a timespec pointer.  This is the
> way times are kept in userland code.  Don't try to force people to do
> something else.
> 
> Using a timespec also has the advantage that we can add an absolute
> timeout value mode (optional) instead of the relative timeout value.
> 
> In this context, we should/must be able to specify which clock the
> timeout is for (not as part of the wait call, but another control
> operation perhaps).  It's important to distinguish between
> CLOCK_REALTIME and CLOCK_MONOTONE.  Both have their use.

I think you wanted to say, that 'all event mechanism except the most
commonly used poll/select/epoll use timespec'.
I designed it to be similar to poll(), it is really good interface.
Nature of the waiting is to wait for some time, so I put there that
'some time'.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
> 



-- 
	Evgeniy Polyakov
