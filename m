Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317909AbSGKVNn>; Thu, 11 Jul 2002 17:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317912AbSGKVNm>; Thu, 11 Jul 2002 17:13:42 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:56841 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317909AbSGKVNi>;
	Thu, 11 Jul 2002 17:13:38 -0400
Message-ID: <3D2DF64D.838BD6D6@tv-sign.ru>
Date: Fri, 12 Jul 2002 01:19:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Robert Love <rml@tech9.net>
Subject: Re: Q: preemptible kernel and interrupts consistency.
References: <3D2DEB91.57FA34E6@tv-sign.ru> <1026420107.1178.279.camel@sinai>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Robert Love wrote:
> However, the only places that set need_resched like that are the
> scheduler and they do so also under lock so we are safe.

Safe? Look, if process does not hold any spinlock and interrupts
disabled, then any distant implicit call to resched_task() silently
enables irqs. At least, this must be documented.

> Also, in your example, being in an interrupt handler bumps the
> preempt_count so even the scenario you give will not cause a
> preemption.  If we did not bump the unlock, then your example would give
> a lot of "scheduling in interrupt" BUGs so we would know it ;-)

No, I meant process context in both scenarios! Note also, that it
happens even in UP case.

> All that said, there is a bug: the send_reschedule IPI can set
> need_resched on another CPU.  If the other CPU happens to have
> interrupts disabled, we can in fact preempt.

I can't see, how this can happen. Can you explain?
But it seems unrelated...

Oleg.
