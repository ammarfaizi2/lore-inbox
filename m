Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSJMTPF>; Sun, 13 Oct 2002 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJMTPF>; Sun, 13 Oct 2002 15:15:05 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:27282 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261579AbSJMTPE>;
	Sun, 13 Oct 2002 15:15:04 -0400
Message-ID: <3DA9C79E.7010307@colorfullife.com>
Date: Sun, 13 Oct 2002 21:21:02 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: in_atomic() & spin_lock / spin_unlock in different functions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is it that in_atomic counts? Obviously spinlocks and
> get_cpu/put_cpu. Anything else?
> 

preempt_disable(), local_irq_disable(), local_bh_disable().

 > I'm doing spin_lock_irqsave() then in another function
 > spin_unlock_irqrestore. Is that okay? If no, can it cause "scheduling
 > in atomic"?

It's not okay, but shouldn't cause scheduling in atomic messages.

The problem is sparc: the 'unsigned long flags' parameter used by 
_irqsave and _irqrestore contains the stack frame, which means that you 
cannot pass it between functions.

--
	Manfred

