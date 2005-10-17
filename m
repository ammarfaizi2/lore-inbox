Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVJQSiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVJQSiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVJQSiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:38:46 -0400
Received: from science.horizon.com ([192.35.100.1]:57919 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932248AbVJQSip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:38:45 -0400
Date: 17 Oct 2005 14:38:34 -0400
Message-ID: <20051017183834.32695.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - "timer API" vs "timeout API": I got absolutely no acknowlegement that 
> this might be a little confusing and in consequence "process timer" may be 
> a better name.

I have to disagree.  Once you grasp the desirability of having two kinds
of timers, one optimized for the case where it does expire, and one
optimized for the case where it is aborted or rescheduled before its
expiration time, the timer/timeout terminology seems quite intuitive
to me.

In particular, knowing that there are these two kinds of timers, and
they are called "timer" and "timeout", it's immediately obvious to me
which is which.  I have no idea which one a "process timer" is.

The word "timeout" is already understood to refer to an error-recovery
mechanism.  The common and desired case is that a timeout does not occur,
but rather the device responds, the packet is acknowledged, or what
have you.

Also, a common use case is that a timeout is continuously active, but its
expiration time keeps getting postponed.  And great accuracy in timing is
not required; if the timeout expires 10% late, very little harm is done.

Finally, timeouts are always relative to some triggering event, not
absolute.

Given this, a specialized timer implementation that optimizes timer
scheduling at the expense of timer expiration makes all sorts of sense.


Note that the network stack can make good use of both kinds.  Timeouts
for all the usual network timeouts, but high-resolution timers are very
desirable for transmission rate control.
