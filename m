Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUI2LtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUI2LtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 07:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUI2LtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 07:49:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:49793 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268313AbUI2Lsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 07:48:54 -0400
Date: Wed, 29 Sep 2004 13:48:42 +0200 (MEST)
Message-Id: <200409291148.i8TBmgbH014789@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: albert@users.sourceforge.net, benh@kernel.crashing.org
Subject: Re: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 08:54:04 +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2004-09-28 at 06:05, Albert Cahalan wrote:
>> Benjamin Herrenschmidt writes:
>> 
>> > Be careful that some G4's have a bug which can cause a
>> > perf monitor interrupt to crash your kernel :( Basically, the
>> > problem is if any of TAU or PerfMon interrupt happens at the
>> > same time as a DEC interrupt, some revs of the CPU can get
>> > confused and lose the previous exception state.
>> 
>> Instead of excluding all these CPUs, simply put the
>> clock tick on the PerfMon interrupt. There's a bit-flip
>> that'll go at about 4 kHz on a system with a 100 MHz bus.
>> That should do. One need not change HZ; the interrupt
>> can be ignored whenever the timebase hasn't advanced
>> enough to require another clock tick.
>
>True, we can use the perfmon instead of the DEC for those

In principle, yes. The problem is that integrating two
unrelated uses of the perfmon HW will require major
changes in perfctr's ppc32 driver. And the kernel would
also have to be patched to redirect all DEC accesses to
the emulation code.

I have more pressing API issues to resolve, so I won't
do anything about this broken HW workaround for now.

/Mikael
