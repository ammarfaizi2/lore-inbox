Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSGJJDA>; Wed, 10 Jul 2002 05:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGJJC7>; Wed, 10 Jul 2002 05:02:59 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:35510 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S317512AbSGJJC6> convert rfc822-to-8bit; Wed, 10 Jul 2002 05:02:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) scheduler "complex" macros
Date: Wed, 10 Jul 2002 11:05:29 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
References: <Pine.LNX.4.44.0207102049510.15332-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207102049510.15332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207101105.29317.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

thanks for the quick response!

> the best solution might be to just lock the 'next' task - this needs a new
> per-task irq-safe spinlock, to avoid deadlocks. This way whenever a task
> is in the middle of a context-switch it cannot be scheduled on another
> CPU.

We tested this and it looked good. But inserting a udelay(100) like:
	...
	prepare_arch_switch(rq, next);
	udelay(100);
	prev = context_switch(prev, next);
	...
leads to a crash after 10 minutes. Again this looks like accessing an
empty page.

Does anything speak against such a test? It is there just to show up
quickly problems which we might normally get only after hours of running.

Regards,
Erich
 
