Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSAGHaJ>; Mon, 7 Jan 2002 02:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288985AbSAGH37>; Mon, 7 Jan 2002 02:29:59 -0500
Received: from mail.vr-web.de ([195.243.197.42]:18701 "HELO mail.VR-Web.de")
	by vger.kernel.org with SMTP id <S288969AbSAGH3y>;
	Mon, 7 Jan 2002 02:29:54 -0500
Date: Mon, 7 Jan 2002 08:22:44 +0100 (CET)
From: Matthias Hanisch <mjh@vr-web.de>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        axboe@suse.de, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <Pine.LNX.4.40.0201051506170.1607-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10201070803290.135-100000@pingu.franken.de>
Organization: Matze at his stone-old Linux Box
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002, Davide Libenzi wrote:

> There should be some part of the kernel that assume a certain scheduler
> behavior. There was a guy that reported a bad  hdparm  performance and i
> tried it. By running  hdparm -t  my system has a context switch of 20-30
> and an irq load of about 100-110.

This guy was me, IMHO (just with my office email address :).


> The scheduler itself, even if you code it in visual basic, cannot make
> this with such loads.
> Did you try to profile the kernel ?

To answer your question, I wanted to profile 2.5.2-pre8 against
2.5.2-pre8-old-scheduler. _Fortunately_ I made some mistake and forgot to
back out the following chunk of memory.

--- v2.5.1/linux/arch/i386/kernel/process.c     Thu Oct  4 18:42:54 2001
+++ linux/arch/i386/kernel/process.c    Thu Dec 27 08:21:28 2001
@@ -125,7 +125,6 @@
        /* endless idle loop with no priority at all */
        init_idle();
        current->nice = 20;
-       current->counter = -100;
 
        while (1) {
                void (*idle)(void) = pm_idle;

So it seems, that removing this line from kernel sources with the old
scheduler causes this unresponsive behavior. This chunk looks also a
little bit strange. In most (all?) the other chunks "counter" gots
replaced with "dyn_prio", not completely removed.

I'll verify this tonight (have to earn some money at first :). I'll do
also some profiling.

Mikael, if you have time, maybe you can try to apply only this chunk of
patch (or only remove the line) to a clean 2.4.18-pre1 and report the
behavior.


Davide, regarding your question in the other mail:

> Can you try some changes that i'll tell you ?

Please forward to me also. Sometimes it takes a little bit longer, because
there is also life without LKML, but I want to get this understood and
fixed, so I'll try to help you as much as I can.


Regards,
	Matze


