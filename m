Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbRCWMoP>; Fri, 23 Mar 2001 07:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130777AbRCWMoF>; Fri, 23 Mar 2001 07:44:05 -0500
Received: from [32.97.166.34] ([32.97.166.34]:38024 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S130686AbRCWMmf>;
	Fri, 23 Mar 2001 07:42:35 -0500
Message-Id: <m14fr35-001PKoC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Wed, 21 Mar 2001 01:41:25 -0800."
             <15032.30533.638717.696704@pizda.ninka.net> 
Date: Thu, 22 Mar 2001 09:25:47 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15032.30533.638717.696704@pizda.ninka.net> you write:
> 
> Keith Owens writes:
>  > Or have I missed something?
> 
> Nope, it is a fundamental problem with such kernel pre-emption
> schemes.  As a result, it would also break our big-reader locks
> (see include/linux/brlock.h).

Good point: holding a brlock has to block preemption, as per spinlocks.

> Basically, anything which uses smp_processor_id() would need to
> be holding some lock so as to not get pre-empted.

When I audited the uses of smp_processor_id() for the hotplug cpu
stuff, there were surprisingly few calls to smp_processor_id(), and
most of these will be holding a brlock, so OK already.

Rusty.
--
Premature optmztion is rt of all evl. --DK
