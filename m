Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSG0JHv>; Sat, 27 Jul 2002 05:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSG0JHu>; Sat, 27 Jul 2002 05:07:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:20443 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318717AbSG0JHu>;
	Sat, 27 Jul 2002 05:07:50 -0400
Date: Sat, 27 Jul 2002 11:10:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Doug Ledford <dledford@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810_audio.c cli/sti fix
In-Reply-To: <20020725021439.A9261@redhat.com>
Message-ID: <Pine.LNX.4.44.0207271103180.2606-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Doug Ledford wrote:

> it is merely intended to stop all interrupts that might skew our timing
> via udelay() on the local CPU (it's actually pretty important that we
> keep our variance from a real 50ms delay as small as possible, since the
> more variance we allow in this loop the more likely it will be that our
> sound card will play sounds either a bit too fast or too slow).

how about a disable_irq_all() and enable_irq_all() call, which would
disable every single interrupt source in the system? Sure it's a bit
heavyweight (it disables the timer interrupt too), but if some driver
**really** needs complete silence in the IRQ system then it might be
useful. It would roughly be equivalent to cli() and sti(), from the
hardirq disabling point of view. [it would not disable bottom halves.]

	Ingo

