Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVGaTSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVGaTSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVGaTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:17:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25336 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261920AbVGaTRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:17:07 -0400
Subject: Re: hashed spinlocks
From: Daniel Walker <dwalker@mvista.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050731.121134.105428216.davem@davemloft.net>
References: <1122827276.18047.26.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050731.114613.119242519.davem@davemloft.net>
	 <1122836811.28450.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050731.121134.105428216.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 12:16:01 -0700
Message-Id: <1122837361.28450.12.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-31 at 12:11 -0700, David S. Miller wrote:
> From: Daniel Walker <dwalker@mvista.com>
> Date: Sun, 31 Jul 2005 12:06:47 -0700
> 
> > The ifdef that switched between the two rt_hash_lock_addr() switched on
> > for CONFIG_SMP or CONFIG_DEBUG_SPINLOCK . I was compiling UP , so I
> > didn't get either.
> > 
> > Seems like you'll need to have an rt_hash_lock(slot) that replaces the
> > spin_lock calls ..
> 
> spin_lock(x) and spin_unlock(x) are both a nop in this case, so what
> is the problem passing in a NULL?  The argument is arbitrary and should
> should just ignored, right?

True.

> If both CONFIG_SMP and CONFIG_DEBUG_SPINLOCK are disabled, we
> end up with these definitions in linux/spinlock.h
> 
> #define spin_lock(lock)		_spin_lock(lock)
> 
> #define _spin_lock(lock)	\
> do { \
> 	preempt_disable(); \
> 	_raw_spin_lock(lock); \
> 	__acquire(lock); \
> } while(0)
> 
> #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
> 
> What kind of warning do you get?

It was an RT kernel, which isn't mainline .. Your right it shouldn't be
a problem .

Daniel

