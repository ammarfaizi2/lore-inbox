Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289113AbSAMLkP>; Sun, 13 Jan 2002 06:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSAMLkG>; Sun, 13 Jan 2002 06:40:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7955 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289113AbSAMLjw>; Sun, 13 Jan 2002 06:39:52 -0500
Date: Sun, 13 Jan 2002 11:39:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@fenrus.demon.nl,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113113941.B13566@flint.arm.linux.org.uk>
In-Reply-To: <E16PUeP-00034K-00@the-village.bc.nu> <1010891457.3561.18.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010891457.3561.18.camel@phantasy>; from rml@tech9.net on Sat, Jan 12, 2002 at 10:10:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 10:10:55PM -0500, Robert Love wrote:
> It can if we increment the preempt_count in disable_irq_nosync and
> decrement it on enable_irq.

Who says you're going to be enabling IRQs any time soon?  AFAIK, there is
nothing that requires enable_irq to be called after disable_irq_nosync.

In fact, you could well have the following in a driver:

	/* initial shutdown of device */

	disable_irq_nosync(i); /* or disable_irq(i); */

	/* other shutdown stuff */

	free_irq(i, private);

and you would have to audit all drivers to find out if they did this -
this would seriously damage your preempt_count.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

