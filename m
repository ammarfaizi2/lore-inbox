Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSHWOPt>; Fri, 23 Aug 2002 10:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSHWOPt>; Fri, 23 Aug 2002 10:15:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49066 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318812AbSHWOPs>;
	Fri, 23 Aug 2002 10:15:48 -0400
Date: Fri, 23 Aug 2002 07:12:43 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andi Kleen <ak@suse.de>, James Cleverdon <jamesclv@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 Summit NUMA patch with dynamic IRQ balancing
Message-ID: <2710659712.1030086762@[10.10.2.3]>
In-Reply-To: <p73d6saoxqd.fsf@oldwotan.suse.de>
References: <p73d6saoxqd.fsf@oldwotan.suse.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doing the TPR change is certainly very involved - testing that on 
> a lot of different SMP machines will be definitely needed. I think
> it is the right way to go I agree, balance_irq always looked fishy to
> me, especially with HyperThreading. 

The one advantage it would seem to have is cache warmth for the
interrupt processor - some stickiness is good. But I think using
idle CPUs properly is more important. I don't think an explicit
IO apic programming method can do this fast enough without being
horribly inefficient in terms of constantly reprogramming things.

> How even is the distribution of the interrupts under load? 

Do you really care? I fail to understand why this is a goal for
people. Pretty numbers in /proc/interrupts are meaningless ...
what we really want is to direct interrupts to CPUs where they
can be efficiently processed. That means idle cpus, or cpus with
cache context (warmth) in some form, whether that be for the int
processing code, or the task the interrupt's data is really 
destined for (very hard to determine). 

If they all end up on one CPU because that just happens to be 
efficient, so be it. There was some concern at one point about
timer irq's not being distributed which I don't understand the
problem with, but let's deal with that seperately if necessary.

> [I'm surprised you are not using ACPI for this on your boxes]

We don't have ACPI on all our boxes ... some of us are happy
about that ;-)

M.

