Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVAJKNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVAJKNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVAJKNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:13:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:64656
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262194AbVAJKM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:12:57 -0500
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050110094624.A24919@flint.arm.linux.org.uk>
References: <20050110013508.1.patchmail@tglx>
	 <1105318406.17853.2.camel@tglx.tec.linutronix.de>
	 <20050110010613.A5825@flint.arm.linux.org.uk>
	 <1105319915.17853.8.camel@tglx.tec.linutronix.de>
	 <20050110094624.A24919@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Linutronix
Message-Id: <1105351977.3058.2.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 Jan 2005 11:12:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 10:46, Russell King wrote:
> On Mon, Jan 10, 2005 at 02:18:35AM +0100, Thomas Gleixner wrote:
> > On Mon, 2005-01-10 at 01:06 +0000, Russell King wrote:
> > > On Mon, Jan 10, 2005 at 01:53:26AM +0100, Thomas Gleixner wrote:
> > > > This patch adjusts the ARM entry code to use the fixed up
> > > > preempt_schedule() handling in 2.6.10-mm2
> > > 
> > > Looks PPCish to me.
> > 
> > Sorry I messed that up. Call me the idiot of today.
> > 
> > This patch adjusts the ARM entry code to use the fixed up
> > preempt_schedule() handling in 2.6.10-mm2
> 
> Are you sure ARM suffers from this race condition?  It sets preempt count
> before enabling IRQs and doesn't use preempt_schedule().

There is no race for arm, but using the preempt_schedule() interface is
the approach which Ingo suggested for common usage, but his x86
implementation was racy, so I fixed this first before modifying arm to
use the interface. Ingo pointed out that he will change it to
preempt_schedule_irq, but I'm not religious about the name.

tglx


