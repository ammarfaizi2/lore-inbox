Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTBCPZp>; Mon, 3 Feb 2003 10:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbTBCPZp>; Mon, 3 Feb 2003 10:25:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35746 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266718AbTBCPZn>; Mon, 3 Feb 2003 10:25:43 -0500
Date: Mon, 3 Feb 2003 15:35:12 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Message-ID: <20030203153510.A21371@devserv.devel.redhat.com>
References: <1044285222.2396.14.camel@gregs> <1044285587.2527.4.camel@laptop.fenrus.com> <1044286557.2402.20.camel@gregs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1044286557.2402.20.camel@gregs>; from gj@pointblue.com.pl on Mon, Feb 03, 2003 at 03:35:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 03:35:57PM +0000, Grzegorz Jaskiewicz wrote:
> On Mon, 2003-02-03 at 15:19, Arjan van de Ven wrote:
> > > #include <linux/modversions.h>
> > don't do that. ever.
> why ?

because if you ever need it, modules.h will automatically include
it for you already. And if it doesn't you don't need it and it does more
harm than good.

> > > #ifdef CONFIG_KMOD
> > > #include <linux/kmod.h>
> > > #endif
> > 
> > bullshit ifdef's (and the surrounding code has a whole bunch too
> this has been taken from first from edge module, just to put it into example ;)

it's wrong, for the same reason as the modversions include is wrong

> > btw you do know you can't do vmalloc (or vfree) from interrupt context ?
> > And that every vmalloc eats at minimum 8Kb of virtual memory space? Of
> > which you can't count on having more than 64Mb on x86 ?
> I didn't knew that. I have at least as i said 300 of those, if user
> space software is doing something else. In practice i have around 30.
> even if 1000 it gives 1000*8kb=8MB so it is not that bad. 

the 64Mb vmalloc limit is a system wide one... and
shared between threads allocating their LDT etc etc.

> Whatver, should i consider timer as interrupt too ?

timers are run in interrupt context yes... so you can't do vmalloc
or vfree there. 

Greetings,
   Arjan van de Ven


-- 
But when you distribute the same sections as part of a whole which is a work 
based on the Program, the distribution of the whole must be on the terms of 
this License, whose permissions for other licensees extend to the entire whole,
and thus to each and every part regardless of who wrote it. [sect.2 GPL]
