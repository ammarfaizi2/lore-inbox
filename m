Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287421AbSAMSVh>; Sun, 13 Jan 2002 13:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSAMSV2>; Sun, 13 Jan 2002 13:21:28 -0500
Received: from zero.tech9.net ([209.61.188.187]:62225 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287417AbSAMSVN>;
	Sun, 13 Jan 2002 13:21:13 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16Pn2o-0007I8-00@the-village.bc.nu>
In-Reply-To: <E16Pn2o-0007I8-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 13:20:08 -0500
Message-Id: <1010946009.12125.10.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 10:59, Alan Cox wrote:
> > I disable a single specific interrupt, I don't disable the timer interrupt.
> > Your code doesn't seem to handle that.
> 
> It can if we increment the preempt_count in disable_irq_nosync and
> decrement it on enable_irq.

OK, Alan, you spooked me with the disable_irq mess and admittedly my
initial solution wasn't ideal for a few reasons.

But it isn't a problem after all. In hw_irq.h we bump the count in the
interrupt path.  This should handle any handler, however we end up in
it.

I realized it because if we did not have a global solution to interrupt
request handlers, dropping spinlocks in the handler, even with IRQs
disabled, would cause a preemptive schedule.  All interrupts are
properly protected.

	Robert Love

