Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVGaTLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVGaTLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVGaTLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:11:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60086
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261843AbVGaTLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:11:36 -0400
Date: Sun, 31 Jul 2005 12:11:34 -0700 (PDT)
Message-Id: <20050731.121134.105428216.davem@davemloft.net>
To: dwalker@mvista.com
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: hashed spinlocks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122836811.28450.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <1122827276.18047.26.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	<20050731.114613.119242519.davem@davemloft.net>
	<1122836811.28450.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <dwalker@mvista.com>
Date: Sun, 31 Jul 2005 12:06:47 -0700

> The ifdef that switched between the two rt_hash_lock_addr() switched on
> for CONFIG_SMP or CONFIG_DEBUG_SPINLOCK . I was compiling UP , so I
> didn't get either.
> 
> Seems like you'll need to have an rt_hash_lock(slot) that replaces the
> spin_lock calls ..

spin_lock(x) and spin_unlock(x) are both a nop in this case, so what
is the problem passing in a NULL?  The argument is arbitrary and should
should just ignored, right?

If both CONFIG_SMP and CONFIG_DEBUG_SPINLOCK are disabled, we
end up with these definitions in linux/spinlock.h

#define spin_lock(lock)		_spin_lock(lock)

#define _spin_lock(lock)	\
do { \
	preempt_disable(); \
	_raw_spin_lock(lock); \
	__acquire(lock); \
} while(0)

#define _raw_spin_lock(lock)	do { (void)(lock); } while(0)

What kind of warning do you get?
