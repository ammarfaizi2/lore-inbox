Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286134AbRLJBhJ>; Sun, 9 Dec 2001 20:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286132AbRLJBg7>; Sun, 9 Dec 2001 20:36:59 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:35342 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286131AbRLJBgs>; Sun, 9 Dec 2001 20:36:48 -0500
Date: Sun, 9 Dec 2001 17:38:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <E16DF5E-00009N-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112091729180.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Alan Cox wrote:

> > > of non cpu hog processes running. A lot of messaging systems have high task
> > > switch rates but very few cpu hogs. So you still need to handle the non hogs
> > > carefully to avoid degenerating back into Linus scheduler.
> >
> > In my experience, if you've I/O bound tasks that lead to a long run queue,
> > that means that you're suffering major kernel latency problems ( other than the
> > scheduler ).
>
> I don't see any evidence of it in the profiles. Its just that a lot of stuff
> gets passed around between multiple daemons. You can see similar things
> in something as mundane as a 4 task long pipe, a user mode file system or
> some X11 clients.

If you've I/O bound ( very low user space average run time ) tasks
accumulation, it's very likely that the bottom part of the iceberg (
kernel ) is becoming quite fat with respect of the userspace part.
Coming at the pipe example, let's take Larry's lat_ctx ( lmbench ).
This is bouncing data through pipes using I/O bound tasks, and running
vmstat together with a lat_ctx 32 32 ... ( long list ), you'll see the run
queue length barley reach 3 ( with 32 bouncing tasks ).
It barely reaches 5 with 64 bouncing tasks.




- Davide


