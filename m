Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUI0W4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUI0W4g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 18:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267403AbUI0W4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 18:56:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:57488 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267421AbUI0W4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 18:56:33 -0400
Subject: Re: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, mikpe@csd.uu.se
In-Reply-To: <1096315531.1296.21.camel@cube>
References: <1096315531.1296.21.camel@cube>
Content-Type: text/plain
Message-Id: <1096325643.1101.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 28 Sep 2004 08:54:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 06:05, Albert Cahalan wrote:
> Benjamin Herrenschmidt writes:
> 
> > Be careful that some G4's have a bug which can cause a
> > perf monitor interrupt to crash your kernel :( Basically, the
> > problem is if any of TAU or PerfMon interrupt happens at the
> > same time as a DEC interrupt, some revs of the CPU can get
> > confused and lose the previous exception state.
> 
> Instead of excluding all these CPUs, simply put the
> clock tick on the PerfMon interrupt. There's a bit-flip
> that'll go at about 4 kHz on a system with a 100 MHz bus.
> That should do. One need not change HZ; the interrupt
> can be ignored whenever the timebase hasn't advanced
> enough to require another clock tick.

True, we can use the perfmon instead of the DEC for those

Ben.


