Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUCSOGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCSOGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:06:32 -0500
Received: from dp.samba.org ([66.70.73.150]:6061 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262925AbUCSOG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:06:29 -0500
Date: Sat, 20 Mar 2004 01:04:55 +1100
From: Anton Blanchard <anton@samba.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Robert_Hentosh@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: spurious 8259A interrupt
Message-ID: <20040319140455.GB1153@krispykreme>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <20040319131608.A14431@flint.arm.linux.org.uk> <20040319133942.GA3897@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319133942.GA3897@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Indeed.  But why?  What's the advantage?

We enable IRQs during IRQ processing on ppc64 for one reason. We set the
IPI priority higher than normal IRQs so we can service it as soon as
possible and the calling cpu can move on.

> E.g. if the irq 1 handler takes a long time, multiple irq 2
> interrupts can be serviced during it.
> 
> But that doesn't work, when there are no meaningful hardware
> priorities: an irq 2 handler can be interrupted by the long irq 1
> handler, maybe before it gets to do anything useful, and then the irq
> 2 interrupt doesn't have low latency.

Yeah. We have a huge number of possible priorities on some ppc64
interrupt controllers but it turns out we dont have a concept of
priority or tolerance of latency for devices in Linux. I could see us
wanting serial IRQs to have a higher priority than disk IRQs if the
information was there for us to exploit.

In the end we map all IRQs to the same priority on ppc64 which means we
will never take a recursive IRQ due to devices.

Anton
