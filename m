Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbSKDHny>; Mon, 4 Nov 2002 02:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265977AbSKDHny>; Mon, 4 Nov 2002 02:43:54 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:26312 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264146AbSKDHnx>; Mon, 4 Nov 2002 02:43:53 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 3 Nov 2002 23:50:15 -0800
Message-Id: <200211040750.XAA01372@baldur.yggdrasil.com>
To: davem@redhat.com
Subject: Re: Patch: linux-2.5.45/drivers/base/bus.c - new field to consolidate memory allocation in many drivers
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Miller writes:
>I don't know how much I like the DMA memory being allocated
>transparently based upon some structure initialization values.
>
>I'd rather the DMA alloc/free be explicit in the drivers.

	I think I roughly understand your attitude.  Certainly I am of
wary adding more abstraction.  Programmers tend to get lost in it.  In
spite of the best intentions, code is often made less readable and
maintainable, bugs less apparent.

	However, at some point, abstraction can be worth it.  The
resulting code actually shirnking, accelerating, being clearer,
when the abstraction results in the removal of bugs, are all
metrics that I would look at.

	Lifting most of the memory allocation and DMA mapping out of
the drivers will remove thousands of lines from Linux drivers in
aggregate and remove hundreds of potentially buggy error branches.  It
will be a little easier see the hardware from reading the driver.
In comparison, the CPU costs are small and may be negative if
some of that consolidation allows for additional optimizations.

	I'd be interested in knowing how you quantify this trade-off
and what you think might persuade you to support or at least be
neutral toward this type of facility (results of converting drivers,
examples of buggy error branches?).  Please keep in mind that not all
drivers necessarily need to use these facilities.

>Otherwise, the ->ops->alloc_consistent et al. abstraction
>looks ok.

	Thanks.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

	
