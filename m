Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293167AbSCOTMl>; Fri, 15 Mar 2002 14:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293162AbSCOTMb>; Fri, 15 Mar 2002 14:12:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:51204 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293161AbSCOTMT>;
	Fri, 15 Mar 2002 14:12:19 -0500
Subject: Re: 2.4.18 Preempt Freezeups
From: Robert Love <rml@tech9.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15506.7486.729120.64389@kim.it.uu.se>
In-Reply-To: <3C9153A7.292C320@ianduggan.net>
	<1016157250.4599.62.camel@phantasy> <3C91B2A1.48C74B82@ianduggan.net>
	<1016202310.908.1.camel@phantasy>  <15506.7486.729120.64389@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 15 Mar 2002 14:11:49 -0500
Message-Id: <1016219530.904.21.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-15 at 11:11, Mikael Pettersson wrote:

> "more than likely": that's perhaps true for your average NIC/soundcard/
> whatever driver, but things that poke the processor itself (like my
> performance-monitoring counters driver) really do depend on not being
> preempted. In my view, CONFIG_SMP is a minor triviality compared to
> CONFIG_PREEMPT ...

If you "poke the processor", to be SMP-safe, you should hold a lock to
prevent multiple concurrent "pokings of the processor" - thus you become
preempt-safe.

It is a rare case where something does not hold lock, assumes some sort
of non-reentrancy/concurrency, and is actually still SMP-safe.  The only
nontrivial case I have seen is drivers that call disable_irq(n) and thus
are assured they won't have another driver request and then go off to
touch hardware.

In general, the sort of "non-preemptibility" you are requiring is also a
requirement for non-reentrancy and non-concurrency and thus your
measures to protect those (SMP locking, et al) assure you your
preempt-kernel protection, too.

	Robert Love




