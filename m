Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSAYOPm>; Fri, 25 Jan 2002 09:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290688AbSAYOPc>; Fri, 25 Jan 2002 09:15:32 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58785 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290686AbSAYOPS>;
	Fri, 25 Jan 2002 09:15:18 -0500
Date: Fri, 25 Jan 2002 17:12:49 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: The Doctor What <docwhat@gerf.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>
Subject: Re: O(1) on powerpc....
In-Reply-To: <1011967954.3501.17.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201251706240.9275-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Jan 2002, Robert Love wrote:

> We could do some things to generically make the other arches
> compatible with the new scheduler, things like:
>
> #define smp_processor_id() (current->processor)
>
> still need to be fixed (to use ->cpu).  I bet after a trivial
> find/replace there is little left to do.

it's often more subtle then this. Every arch has to:

- implement the lowlevel task-migration mechanizm

- update the idle-thread code to use init_idle() + idle_startup_done().
  Update the idle-thread priority changing bits.

- check context_switch() for IRQ-atomicity for being called with the
  runqueue lock held - eg. ia64 re-enabled interrupts.

- add a definition of sched_find_first_bit()

- update any possible out-of-sync field offsets in entry.S.

so i'd not touch the trivial bits, because the hard bits will still be
unfixed, and who likes fixing the hard stuff only? :-)

	Ingo

