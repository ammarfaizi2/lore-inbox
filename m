Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUI0UK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUI0UK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUI0UKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:10:19 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:28036 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267323AbUI0UJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:09:13 -0400
Subject: Re: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt
	support
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: mikpe@csd.uu.se, benh@kernel.crashing.org
Content-Type: text/plain
Organization: 
Message-Id: <1096315531.1296.21.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Sep 2004 16:05:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> Be careful that some G4's have a bug which can cause a
> perf monitor interrupt to crash your kernel :( Basically, the
> problem is if any of TAU or PerfMon interrupt happens at the
> same time as a DEC interrupt, some revs of the CPU can get
> confused and lose the previous exception state.

Instead of excluding all these CPUs, simply put the
clock tick on the PerfMon interrupt. There's a bit-flip
that'll go at about 4 kHz on a system with a 100 MHz bus.
That should do. One need not change HZ; the interrupt
can be ignored whenever the timebase hasn't advanced
enough to require another clock tick.


