Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281299AbRKLHnD>; Mon, 12 Nov 2001 02:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281302AbRKLHmx>; Mon, 12 Nov 2001 02:42:53 -0500
Received: from lowland.webflex.nl ([212.72.61.81]:30881 "EHLO mail.webflex.nl")
	by vger.kernel.org with ESMTP id <S281299AbRKLHmj>;
	Mon, 12 Nov 2001 02:42:39 -0500
Date: Mon, 12 Nov 2001 08:42:27 +0100 (CET)
From: Mathijs Mohlmann <mathijs@knoware.nl>
To: Andrea Arcangeli <andrea@suse.de>
cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] fix loop with disabled tasklets
In-Reply-To: <20011112021142.O1381@athlon.random>
Message-ID: <Pine.BSI.4.05L.10111120819290.9564-100000@utopia.knoware.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Nov 2001, Andrea Arcangeli wrote:
> Mathijs, can you verify that? If my theory is right need_resched isn't
> set even if ksoftirqd loops forever. It could be one of those two
> possibilities:
> 
> 1) the timer irq isn't running yet
> 2) "current" isn't functional

well, i'm at work now, no sparc32's here. But during my debugging i made
a piece of code that counted to times a process was selected by schedule.
A custom SysRq key read the values. What i saw during the deadlock was
that there where three processes running allready and scheduling seemed to
work find. keventd got selected everytime i pressed SysRq and ksoftirqd
got selected during idle time.

This (to me) proves that "current" is working just fine. Not quite sure
about the timer irq. I will look at that tonight. But i'm pretty sure
need_resched is set again and again.

Even if the timer irq is working fine, the sun should not enable the 
keyboard irq without the tasklet being enabled. Initializing the keyboard
tasklet enabled got the sun to boot just fine for me.

But i feel that this is fixing the symptoms. If this turns out to be the
problem, it should be fixed, but i feel the softirq code needs some good 
looking over with respect to disabled tasklets as well. (tasklet_enable 
without a tasket_schedule and then a tasklet_kill will loop as well,
wont it?)

	me (everything IMVHO)

