Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292062AbSCDHTZ>; Mon, 4 Mar 2002 02:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292079AbSCDHTP>; Mon, 4 Mar 2002 02:19:15 -0500
Received: from zero.tech9.net ([209.61.188.187]:54027 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292062AbSCDHTE>;
	Mon, 4 Mar 2002 02:19:04 -0500
Subject: Re: interrupt - spin lock question
From: Robert Love <rml@tech9.net>
To: sridharv@ufl.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1015223610.3c83153a33024@webmail.health.ufl.edu>
In-Reply-To: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu>
	<1015219669.868.35.camel@phantasy> 
	<1015223610.3c83153a33024@webmail.health.ufl.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 02:19:09 -0500
Message-Id: <1015226350.15281.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 01:33, sridharv@ufl.edu wrote:

> ok things are clear now. so the spin_lock_irq friends are actually for 2 
> purposes - preventing racing from interrupts and from SMP. so if SMP is not 
> chosen only the local_irq_disable() part works right??
> 
> do { local_irq_disable();         spin_lock(lock); } while (0)

Correct.  Although, you would want to use spin_lock_irqsave most of the
time, not spin_lock_irq (difference is, the stored flags value is used
to restore interrupts to there previous condition instead of
unconditionally reenable them).

Btw, Go Gators!

	Robert Love

