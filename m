Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311278AbSCQDSA>; Sat, 16 Mar 2002 22:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311277AbSCQDRk>; Sat, 16 Mar 2002 22:17:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28174 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310363AbSCQDRe>; Sat, 16 Mar 2002 22:17:34 -0500
Subject: Re: 2.4.18 Preempt Freezeups
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 17 Mar 2002 03:31:24 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ian@ianduggan.net (Ian Duggan),
        rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <E16mNxQ-0000mM-00@starship> from "Daniel Phillips" at Mar 17, 2002 12:51:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mROG-00083A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Reviewing driver code for situations where it requires a small timing delay
> > 	and a large one is unacceptable
> 
> Has anyone found one of those yet?

There are some frame buffers with that requirement. The stuff I've looked
at where the are such timing rules already disables interrupts.

(The other classic btw is older PIO IDE setups)

> > Checking anywhere you use the cpu id that you don't do somthing where it
> > 	might change under you (eg per cpu variables)
> 
> Is per-cpu data the whole list there?

Think about profiling registers, mtrrs, msrs, and so forth. For example
if we had thread handling MCE traps we would hit a problem. As it happens
MCE is an interrupt so its all nice.

Alan
