Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284966AbSAGSbi>; Mon, 7 Jan 2002 13:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbSAGSbT>; Mon, 7 Jan 2002 13:31:19 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:14098 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284966AbSAGSbK>; Mon, 7 Jan 2002 13:31:10 -0500
Date: Mon, 7 Jan 2002 10:36:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>, <mjh@vr-web.de>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <200201071801.TAA11871@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.40.0201071035150.1612-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Mikael Pettersson wrote:

> On Mon, 7 Jan 2002 08:43:04 -0800 (PST), Linus Torvalds wrote:
> >Hey, that would do it. It looks like the idle task ends up being a
> >_normal_ process (just nice'd down), so it will get real CPU time instead
> >of only getting scheduled when nothing else is runnable.
> >
> >Davide, I think the bounce-buffer is a red herring, it's simply that we're
> >wasting time in idle..
>
> This does seem to be the case. As a quick hack I added
>
> 	if (p == &init_task) return -50;
>
> at the start of kernel/sched.c:goodness() [to approximate the old
> scheduler's behaviour], and this immediately restored performance
> on my 486 to the old scheduler's levels.

I'll post a patch to Linus in 20 minutes otherwise Linus simply

sched.c::init_idle()

current->dyn_prio = -100;




- Davide


