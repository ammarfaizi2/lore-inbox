Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286333AbRLTTH3>; Thu, 20 Dec 2001 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286331AbRLTTHV>; Thu, 20 Dec 2001 14:07:21 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:15123 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286351AbRLTTHH>; Thu, 20 Dec 2001 14:07:07 -0500
Date: Thu, 20 Dec 2001 11:10:00 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
        <anton@samba.org>, <davej@suse.de>, <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.17-pre5
In-Reply-To: <20011219231619.A120@elf.ucw.cz>
Message-ID: <Pine.LNX.4.40.0112201105000.1622-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001, Pavel Machek wrote:

> Hi!
>
> > > Using the scheduler i'm working on and setting a trigger load level of 2,
> > > as soon as the idle is scheduled it'll go to grab the task waiting on the
> > > other cpu and it'll make it running.
> >
> > That rapidly gets you thrashing around as I suspect you've found.
> >
> > I'm currently using the following rule in wake up
> >
> > 	if(current->mm->runnable > 0)	/* One already running ? */
> > 		cpu = current->mm->last_cpu;
>
> Is this really a win?
>
> I mean, if I have two tasks that can run from L2 cache, I want them on
> different physical CPUs even if they share current->mm, no?

It depends. If you've two CPU and these two tasks are the only ones
running, yes running them on separate CPUs is ok because the parallelism
that you'll get is going to pay you back for the cache issues.
And this is the automatic bahavior that you'll get with sane schedulers.
But as a general rule, matching MMs should lead to a tentative to run them
on the same CPU ( give preference, not force ).




- Davide


