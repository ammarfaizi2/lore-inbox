Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261948AbSIYJFt>; Wed, 25 Sep 2002 05:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbSIYJFs>; Wed, 25 Sep 2002 05:05:48 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:12557 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S261948AbSIYJFs>; Wed, 25 Sep 2002 05:05:48 -0400
Date: Wed, 25 Sep 2002 04:11:01 -0500 (CDT)
Message-Id: <200209250911.g8P9B1734121@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: ajm@sgi.com (Alan Mayer)
Subject: Re: irqs on large machines (patch)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.3.96.1020924142045.102141A-100000@fergus.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC 64 (p690 in particular) had a similar but different
problem with NR_IRQS.

The hardware gives direct vectors, but the number space is 9 bits
to identify the pci host bridge in the drawers, and yet 4 more to
identify the source on the pci bus.  All of the 9 bits are used at
various levels of the hardware for routing, so the global number
space is a bit sparse.

Each interrupt can be sent to the global queue or a specific
processor's queue.

Rather than size NR_IRQS for the native index, the hardware numbers
are mapped with a simple mapping table that directly maps dense
linux irqs to hardware numbers.  Thus the linux NR_IRQs is set based on
the total number of hardware sources.  (And yes, we found we needed
/proc/interrupts to be seq_file based, but that is long merged).


Perhaps this will give you ideas for other alternatives?  This approach
could also allow you to assign IO interrupts to a node if your hardware
allows.

milton
-- 
[I'll look for any replys on the list]
