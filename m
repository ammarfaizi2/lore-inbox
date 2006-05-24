Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932731AbWEXMzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbWEXMzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 08:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWEXMzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 08:55:51 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:20370 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932731AbWEXMzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 08:55:51 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: Yann.LEPROVOST@wavecom.fr
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
References: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
Content-Type: text/plain
Date: Wed, 24 May 2006 08:55:34 -0400
Message-Id: <1148475334.24623.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 10:06 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> The debug serial unit is part of the mainline kernel, this is the common
> link to work with the CSB637 Cogent board.
> I don't know about others AT91RM9200 based board.
> 
> AT91RM9200 also have others USART, but there are no available output
> connectors on the CSB637 board.
> 

Hi Yann,

OK, do you only get the prints from the serial? If so than that is OK,
but if you also log in through the serial, then that is a problem.  In
other words, do you have something like mgetty running to log in through
the serial? 

Looking at the at91_interrupt it can call mutex spin_locks if receiving
data. So this needs care.

Thomas or Ingo,

Maybe the handling of IRQs needs to handle the case that shared irq can
have both a NODELAY and a thread.  The irq descriptor could have a
NODELAY set if any of the actions are NODELAY, but before calling the
interrupt handler (in interrupt context), check if the action is NODELAY
or not, and if not, wake up the thread if not done so already.

thoughts?

-- Steve


