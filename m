Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbTGOPow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268586AbTGOPow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:44:52 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:19866 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268677AbTGOPkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:40:23 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jul 2003 08:47:47 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy    
 ...
In-Reply-To: <5.2.1.1.2.20030715054158.01b19b48@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307150830480.4825@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net>
 <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net> <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net> <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
 <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net> <5.2.1.1.2.20030715054158.01b19b48@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Mike Galbraith wrote:

> At 10:22 AM 7/14/2003 -0700, Davide Libenzi wrote:
> >On Mon, 14 Jul 2003, Mike Galbraith wrote:
> >
> > > Yes, and it worked fine.  No cpu load I tossed at it caused a skip.
> >
> >I tried yesterday a thud.c load and it did not get a single skip here
> >either. It is interesting what thud.c can do to latency (let's not talk
> >about irman because things get really nasty). With a simple `thud 5` the
> >latency rised to more then one full second, as you can see by the graphs
> >inside the SOFTRR page. No buffer size can cope with that.
>
> Yes, thud is well named.  It's easy to kill, but not so easy to kill
> without hurting important dynamic response characteristics and/or
> interactivity.

The problem with thud and irman is not the sound. If it was only that I'd
be rather happy. Try to get the simplified version of the irman I dropped
inside the SOFTRR (didn't try to original, it's maybe even worse) page and
run it with '-n 40 -b 350' for example. Then try to buld a kernel.
Yesterday on my Athlon 1GHz 768MB of RAM where usually the kernel takes
8:33 to build (2.5), after 15 minutes I had only two lines printed on my
screen. We can easily say that sound can break under those corner cases,
but we cannot say that anything but super-interactive tasks will run on
such a system. This is Unix and ppl still uses it in a multiuser fashion.
In every system (not only in computer science) where there is no fairness,
there will be someone ready to take advantage (exploit) of it. We use to
sacrify fairness for interactivity, and this is good since interactivity
is a good thing. Whatever you tune your sleep->burn cycle, someone will be
able to exploit it by trying to get the more CPU you give away to
interactive tasks. This multiplied for a limited number of tasks will make
the system to hugely suck away CPU from anything but super-interactive
tasks. We need to have a limit to the CPU that we assign to interactive
tasks (something like 70/30 or whatever), so that we don't completely
starve the non-interactive world (see "Scheduler woes" post). This is
critical for multiuser systems IMHO.




- Davide

