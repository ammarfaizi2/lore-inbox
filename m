Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318853AbSG0W66>; Sat, 27 Jul 2002 18:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318854AbSG0W66>; Sat, 27 Jul 2002 18:58:58 -0400
Received: from holomorphy.com ([66.224.33.161]:56484 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318853AbSG0W66>;
	Sat, 27 Jul 2002 18:58:58 -0400
Date: Sat, 27 Jul 2002 16:01:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] Re: Serial Oopsen caused by global IRQ chanes
Message-ID: <20020727230150.GP25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020727191119.C32766@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207272034210.19384-100000@localhost.localdomain> <20020727223617.GO25038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020727223617.GO25038@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 08:43:04PM +0200, Ingo Molnar wrote:
>> the attached patch fixes a synchronize_irq() bug: if the interrupt is 
>> freed while an IRQ handler is running (irq state is IRQ_INPROGRESS) then 

On Sat, Jul 27, 2002 at 03:36:17PM -0700, William Lee Irwin III wrote:
> I'm having trouble with this one, I seem to get lots of these messages:
> pu: 12, clocks: 99983, slice: 3029
> CPU12<T0:99968,T1:60576,D:15,S:3029,C:99983>
> CPU 12 IS NOW UP!

Sorry, this is the hotplug stuff which surprised me, but is unrelated
to any deadlock (unless it's printk'ing at a bad time, which I doubt).
Thought it was an arch complaint about trying to wake already-woken cpus.

On Sat, Jul 27, 2002 at 03:36:17PM -0700, William Lee Irwin III wrote:
> ... and then the kernel deadlocks after free_initmem()'s printk().

Seems to be timing related, printk's in init/main.c made it go away.
ISTR hearing something about hotplug merge troubles, I'll investigate
that thread and report results with the fixes posted there.

Cheers,
Bill
