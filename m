Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285730AbSAGTj3>; Mon, 7 Jan 2002 14:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbSAGTjU>; Mon, 7 Jan 2002 14:39:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:60065 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S285747AbSAGTjJ>;
	Mon, 7 Jan 2002 14:39:09 -0500
Date: Mon, 7 Jan 2002 22:36:34 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Brian Gerst <bgerst@didntduck.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <200201071922.g07JMN106760@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201072222100.15970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Linus Torvalds wrote:

> Ingo, looks true. A quick -D2?

yep, Brian is right. I've uploaded -D2:

        http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-D2.patch

other changes:

 - make rt_priority 99 map to p->prio 0, rt_priority 0 map to p->prio 99.

 - display 'top' priorities correctly, 0-39 for normal processes, negative
   values for RT tasks. (it works just fine it appears.) We did not use to
   display the real priority of RT tasks, but now it's natural.

> Oh, and please move console_init() back, other consoles (sparc?) may
> depend on having PCI layers initialized.

(doh, done too, fix is in -D2.)

> Oh, and _I_ don't like "cpu()".  What's wrong with the already
> existing "smp_processor_id()"?

nothing serious, my main problem with it is that it's often too long for
my 80 chars wide consoles, and it's also too long to type and i use it
quite often in SMP code.

IIRC we had a 'hard_smp_processor_id()' initially, partly to make it
harder to use it. (it was very slow because it did an APIC read). But
these days smp_processor_id() is just as fast (or even faster) as
'current'. So i wanted to use cpu() in new code to make it easier to read
and to make it more compact. But if this is a problem i can remove it.
I've verified that there is no obvious namespace collisions.

(i've done a quick UP sanity compile + boot of 2.5.2-pre9 + D2, it all
works as expected.)

	Ingo

