Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSAMSV5>; Sun, 13 Jan 2002 13:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287417AbSAMSVs>; Sun, 13 Jan 2002 13:21:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:63761 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287596AbSAMSVi>;
	Sun, 13 Jan 2002 13:21:38 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020113113941.B13566@flint.arm.linux.org.uk>
In-Reply-To: <E16PUeP-00034K-00@the-village.bc.nu>
	<1010891457.3561.18.camel@phantasy> 
	<20020113113941.B13566@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 13:24:20 -0500
Message-Id: <1010946261.11852.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 06:39, Russell King wrote:
> On Sat, Jan 12, 2002 at 10:10:55PM -0500, Robert Love wrote:
> > It can if we increment the preempt_count in disable_irq_nosync and
> > decrement it on enable_irq.
> 
> Who says you're going to be enabling IRQs any time soon?  AFAIK, there is
> nothing that requires enable_irq to be called after disable_irq_nosync.
> 
> In fact, you could well have the following in a driver:
> 
> 	/* initial shutdown of device */
> 
> 	disable_irq_nosync(i); /* or disable_irq(i); */
> 
> 	/* other shutdown stuff */
> 
> 	free_irq(i, private);
> 
> and you would have to audit all drivers to find out if they did this -
> this would seriously damage your preempt_count.

I wasn't thinking.  Anytime we are in an interrupt handler, preemption
is disabled.  Regardless of how (or even if) interrupts are disabled. 
We bump preempt_count on the entry path.  So, no problem.

	Robert Love

