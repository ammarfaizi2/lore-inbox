Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWKFI6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWKFI6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 03:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWKFI6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 03:58:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:61848 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161205AbWKFI6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 03:58:18 -0500
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt
	rt_mutex_slowlock()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
References: <20061105193457.GA3082@oleg>
	 <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 19:57:51 +1100
Message-Id: <1162803471.28571.303.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes. On x86 (and x86-64) you'll never see this, because writes are always 
> seen in order regardless, and in addition, the spin_lock is actually 
> totally serializing anyway. On most other architectures, the spin_lock 
> will serialize all the writes too, but it's not guaranteed, so in theory 
> you're right. I suspect no actual architecture will do this, but hey, 
> when talking memory ordering, safe is a lot better than sorry.

PowerPC doesn't serialize the writes on spin_lock, only on spin_unlock.

(That is, previous writes can "leak" into the lock, but writes done
before the unlock can't leak out of the spinlock).

Now, I've just glanced at the thread, so I don't know if that's relevant
to the problems you guys are talking about :-)

Ben.


