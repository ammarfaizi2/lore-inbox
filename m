Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262962AbTCKQfm>; Tue, 11 Mar 2003 11:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262969AbTCKQfm>; Tue, 11 Mar 2003 11:35:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59399 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262962AbTCKQfm>; Tue, 11 Mar 2003 11:35:42 -0500
Date: Tue, 11 Mar 2003 08:44:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/rcupdate.c microcleanup
In-Reply-To: <20030311140249.GB756@pazke>
Message-ID: <Pine.LNX.4.44.0303110843340.2664-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Andrey Panin wrote:
> 
> attached patch (2.5.64) contains small cleanup of RCU code:
>     - move smp_processor_id() outside of irq disabled region in call_rcu();

That looks wrong, and is likely to break with preemption, since the caller 
could potentially be moved to another CPU between the smp_processor_id() 
and the irq disable.

		Linus

