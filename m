Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284633AbRLDAUv>; Mon, 3 Dec 2001 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284890AbRLDASS>; Mon, 3 Dec 2001 19:18:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:4868 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S285244AbRLCWSL>;
	Mon, 3 Dec 2001 17:18:11 -0500
Subject: Re: [linuxsh-dev] [PATCH] Preemptible kernel for SH
From: Robert Love <rml@tech9.net>
To: Jeremy Siegel <jsiegel@mvista.com>
Cc: linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <3C0BEB90.16DC3749@mvista.com>
In-Reply-To: <1007261428.820.4.camel@phantasy> 
	<3C0BEB90.16DC3749@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Dec 2001 17:18:07 -0500
Message-Id: <1007417890.1303.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-03 at 16:16, Jeremy Siegel wrote:
> Just FYI... the preemptible kernel depends on non-preemptible critical regions
> denoted by spinlock calls (see Robert Love's excellent summary in
> Documentation/preempt-locking.txt).  Many common drivers are assumed to have
> correct locking for SMP operation, but non-SMP drivers may not. I've only run
> the PreK SH kernel on the Solution Engine w/Ethernet and serial, but I did not
> yet check to see if additional locks might be required in drivers/char/sh-sci.c
> or drivers/net/stnic.c, which are specific to SH platforms and thus not SMP-safe
> otherwise.

Ahh, good point.  Similar situation occured on ARM when it went
preemptive.  Thankfully, Russel King and company try to properly lock
things even if they are no ops.

Coding under a preemptive kernel means more than what
Documentation/preempt-locking.txt implies ... you have to protect data
regions as if you are operating under SMP.

It is good practice, anyhow.

This means you can include linux/spinlock.h and use the locking
constructs as needed.  Under a normal UP kernel, they will compile
away.  Under a preemptive kernel, they will provide the needed
reentrancy protection.  If there ever is a an SMP SH kernel (or
something like it) the kernel will be ready for the future.

	Robert Love

