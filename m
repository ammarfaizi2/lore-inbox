Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbSAGS1S>; Mon, 7 Jan 2002 13:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbSAGS1J>; Mon, 7 Jan 2002 13:27:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:11794 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284886AbSAGS05>; Mon, 7 Jan 2002 13:26:57 -0500
Date: Mon, 7 Jan 2002 10:31:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matthias Hanisch <mjh@vr-web.de>
cc: Mikael Pettersson <mikpe@csd.uu.se>, Jens Axboe <axboe@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <Pine.LNX.4.10.10201070803290.135-100000@pingu.franken.de>
Message-ID: <Pine.LNX.4.40.0201071030210.1612-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Matthias Hanisch wrote:

> On Sat, 5 Jan 2002, Davide Libenzi wrote:
>
> > There should be some part of the kernel that assume a certain scheduler
> > behavior. There was a guy that reported a bad  hdparm  performance and i
> > tried it. By running  hdparm -t  my system has a context switch of 20-30
> > and an irq load of about 100-110.
>
> This guy was me, IMHO (just with my office email address :).
>
>
> > The scheduler itself, even if you code it in visual basic, cannot make
> > this with such loads.
> > Did you try to profile the kernel ?
>
> To answer your question, I wanted to profile 2.5.2-pre8 against
> 2.5.2-pre8-old-scheduler. _Fortunately_ I made some mistake and forgot to
> back out the following chunk of memory.
>
> --- v2.5.1/linux/arch/i386/kernel/process.c     Thu Oct  4 18:42:54 2001
> +++ linux/arch/i386/kernel/process.c    Thu Dec 27 08:21:28 2001
> @@ -125,7 +125,6 @@
>         /* endless idle loop with no priority at all */
>         init_idle();
>         current->nice = 20;
> -       current->counter = -100;

In sched.c::init_idle() :

current->dyn_prio = -100;

Let me know.




- Davide


