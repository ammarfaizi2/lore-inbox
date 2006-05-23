Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWEWRBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWEWRBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWEWRBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:01:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:17064 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750985AbWEWRBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:01:09 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: Yann.LEPROVOST@wavecom.fr
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <OF75506F98.64DD61BC-ONC1257177.005A42A4-C1257177.005AF51F@wavecom.fr>
References: <OF75506F98.64DD61BC-ONC1257177.005A42A4-C1257177.005AF51F@wavecom.fr>
Content-Type: text/plain
Date: Tue, 23 May 2006 13:00:42 -0400
Message-Id: <1148403642.22855.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 18:27 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> I forgot to say that I let SA_SHIRQ as the IRQ line is shared...
> It seems to work correctly...

What shares it?

Reason I ask, is that this irq is now running in true interrupt context,
and that on PREEMPT_RT the spin_locks are mutexes and can schedule. So
if another device is sharing this irq, then its interrupt handler will
be running in interrupt context, and if it grabs a spin_lock than is not
a raw_spinlock_t then you will have a crash.

This won't be a problem if you only turn on Hard irqs as threads and
don't do the PREEMPT_RT.

-- Steve


