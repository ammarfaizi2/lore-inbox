Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSATUCG>; Sun, 20 Jan 2002 15:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSATUB4>; Sun, 20 Jan 2002 15:01:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21704 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288958AbSATUBr>;
	Sun, 20 Jan 2002 15:01:47 -0500
Date: Sun, 20 Jan 2002 22:59:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [sched] [patch] migration-fixes-2.5.3-pre2-A1
In-Reply-To: <3C4AD38F.7754CCC4@colorfullife.com>
Message-ID: <Pine.LNX.4.33.0201202254440.14434-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 Jan 2002, Manfred Spraul wrote:

> >  #define SPURIOUS_APIC_VECTOR   0xff
> >  #define ERROR_APIC_VECTOR      0xfe
> >  #define INVALIDATE_TLB_VECTOR  0xfd
> >  #define RESCHEDULE_VECTOR      0xfc
> > -#define CALL_FUNCTION_VECTOR   0xfb
> > +#define TASK_MIGRATION_VECTOR  0xfb
> > +#define CALL_FUNCTION_VECTOR   0xfa
> >

> Are you sure it's a good idea to have 6 interrupts at priority 15? The
> local apic of the P6 has only one in-service entry and one holding
> entry for each priority.

we havent been following this strict rule for some time. We are
distributing device interrupts according to this rule, but only as an
optimization, and only as long as the number of IRQ sources is smaller
than ~30.

i think the worst-case is that we might lose a local APIC timer interrupt
- and this only on older APIC versions. Recent CPUs should handle this
correctly. AND, we have the local APIC timer interrupt on its own priority
level anyway.

So i think the P6 documentation is a pessimisation of the true situation,
and that we can very well have multiple interrupts on the same priority
level even on older APICs - as long as the local timer interrupt is not
amongst them.

	Ingo

