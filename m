Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUCSNjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUCSNjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:39:47 -0500
Received: from mail.shareable.org ([81.29.64.88]:41614 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262990AbUCSNjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:39:45 -0500
Date: Fri, 19 Mar 2004 13:39:42 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robert_Hentosh@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: spurious 8259A interrupt
Message-ID: <20040319133942.GA3897@mail.shareable.org>
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org> <20040319131608.A14431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319131608.A14431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Interrupt handlers generally run with the CPU interrupt disable flag
> cleared, so other interrupts can be serviced.

Indeed.  But why?  What's the advantage?

The obvious thought is it might improve latency of interrupt handlers
which need reasonably low latency, when other handlers take a long time.

E.g. if the irq 1 handler takes a long time, multiple irq 2
interrupts can be serviced during it.

But that doesn't work, when there are no meaningful hardware
priorities: an irq 2 handler can be interrupted by the long irq 1
handler, maybe before it gets to do anything useful, and then the irq
2 interrupt doesn't have low latency.

(I gather that irq priorities aren't especially meaningful on the x86
platform, as brought up on another thread recently).

Perhaps it works out statistically better.

Can you confirm that it does work out statistically better, or that
there's something I didn't think of?

Thanks,
-- Jamie
