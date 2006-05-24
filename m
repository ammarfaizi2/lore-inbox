Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWEXQns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWEXQns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWEXQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:43:47 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:11456 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751120AbWEXQnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:43:47 -0400
Date: Wed, 24 May 2006 18:43:19 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
X-X-Sender: simlo@lifa02.phys.au.dk
To: Steven Rostedt <rostedt@goodmis.org>
cc: Yann.LEPROVOST@wavecom.fr, Daniel Walker <dwalker@mvista.com>,
       <linux-kernel@vger.kernel.org>, <linux-kernel-owner@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
In-Reply-To: <1148475334.24623.45.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605241834220.9777-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, Steven Rostedt wrote:

> On Wed, 2006-05-24 at 10:06 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> [...]
>
> Thomas or Ingo,
>
> Maybe the handling of IRQs needs to handle the case that shared irq can
> have both a NODELAY and a thread.  The irq descriptor could have a
> NODELAY set if any of the actions are NODELAY, but before calling the
> interrupt handler (in interrupt context), check if the action is NODELAY
> or not, and if not, wake up the thread if not done so already.
>
> thoughts?
>

I am working on patchset dealing with this problem. It still needs clean
up. The basic idea is to add a SA_MUSTTHREAD along with SA_NODELAY. Under
PREEMPT_RT all interrupthandlers, which doesn't have SA_NODELAY, will get
SA_MUSTTHREAD unless the driver is changed. In irq_request() it is checked
if the handler has SA_NODELAY and an old has SA_MUSTTHREAD and visa
versa.

I have also made a lock type which can be changed from rt_mutex to
raw_spin_lock runtime. And I have made a system with a call-back from the
irq-layer to the driver so they can change their spinlocks on the fly when
needed.

Esben


> -- Steve
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

