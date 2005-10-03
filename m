Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVJCCya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVJCCya (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 22:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVJCCya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 22:54:30 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:15512 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932113AbVJCCya convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 22:54:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Axl7oTnN1CUzQpCOkZoQBNHi/ID4fn+hMH+341sh8QWGaU1gmH1VjVtMgEfbMvNP4PfgGbjllqEOwKRSebK83Z6qtFdbK7kaYOQ0FKGDWXr/0pvyvgrMlhuA7lPjJYMOemmdzMVoTlclwaEArFPI1rMrG15sLNadHppB2dVVbas=
Message-ID: <2cd57c900510021954l20488718n20b06f2cbc6c567d@mail.gmail.com>
Date: Mon, 3 Oct 2005 10:54:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509290901060.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <433C0F3D.30C19186@tv-sign.ru>
	 <Pine.LNX.4.58.0509290901060.3308@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 29 Sep 2005, Oleg Nesterov wrote:
> >
> > do_signal_stop:
> >
> >       for_each_thread(t) {
> >               if (t->state < TASK_STOPPED)
> >                       ++sig->group_stop_count;
> >       }
> >
> > However, TASK_NONINTERACTIVE > TASK_STOPPED, so this loop will not
> > count TASK_INTERRUPTIBLE | TASK_NONINTERACTIVE threads.
>
> Ok, I think your patch is correct (we really do try to keep an order to
> those task flags), but the _real_ issue is that the comparisons are bogus.
>
> Using ">" for task states is wrong. It's a bitmask, and if you want to
> check multiple states, then we should just do so with
>
>         if (t->state & (TASK_xxx | TASK_yyy | ...))
>
> Oh, well. The inequality comparisons are shorter, and historical, so I

The inequality comparisons are faster or faster on some CPU.
We should use it if we can keep the order IMHO.

> guess it's debatable whether we should remove them all.
>
>                 Linus

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
