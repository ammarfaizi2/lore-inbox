Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291676AbSCDF2E>; Mon, 4 Mar 2002 00:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291717AbSCDF1z>; Mon, 4 Mar 2002 00:27:55 -0500
Received: from zero.tech9.net ([209.61.188.187]:31499 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291676AbSCDF1s>;
	Mon, 4 Mar 2002 00:27:48 -0500
Subject: Re: interrupt - spin lock question
From: Robert Love <rml@tech9.net>
To: sridharv@ufl.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu>
In-Reply-To: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 00:27:49 -0500
Message-Id: <1015219669.868.35.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 00:18, sridharv@ufl.edu wrote:
> I have a question related to spin locking on UP systems.Before that I would 
> like to point out my understanding of the background stuff
> 1. spinlocks shud be used in intr handlers
> 2. interrupts can preempt kernel code
> 3. spinlocks are turned to empty when kernel is compiled without SMP support.

This is right.

> If a particular driver is running( not the intr handler part) and at this time 
> an interrupt occurs. The handler has to be invoked now. Won't the preemption 
> cause race conditions/inconsistencies? Is any other mechanism used?
> Pl correct me if I have not understood any part of this correctly
> -sridhar

Right, that is why you would use a spin_lock ! :)

Further, you would want to use a spin_lock_irq and related friends.  The
irq disable prevents the race wrt interrupts and the spin_lock prevents
racing wrt SMP.

	Robert Love

