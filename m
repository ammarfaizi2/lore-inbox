Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSGWXyX>; Tue, 23 Jul 2002 19:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSGWXyV>; Tue, 23 Jul 2002 19:54:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52180 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316043AbSGWXwy>;
	Tue, 23 Jul 2002 19:52:54 -0400
Date: Wed, 24 Jul 2002 01:54:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] big IRQ lock removal, 2.5.27-G0
In-Reply-To: <Pine.LNX.4.44.0207240137190.3812-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207240153550.5581-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Ingo Molnar wrote:

> > local_bh_disable() is rare (i think), and do_softirq() checks
> > in_interrupt().
> 
> but still we dont want to call do_softirq() all the time. local_bh_enable
> is used in quite performance-sensitive networking code.

in fact the in_interrupt() check in do_softirq() should never trigger with
the latest patch applied - i'll put a debugging printk there and we can
remove it after some time. This will speed things up a bit.

	Ingo

