Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264880AbRFYQxr>; Mon, 25 Jun 2001 12:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbRFYQxh>; Mon, 25 Jun 2001 12:53:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18306 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264880AbRFYQxb>; Mon, 25 Jun 2001 12:53:31 -0400
Date: Mon, 25 Jun 2001 12:52:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Timur Tabi <ttabi@interactivesi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Making a module 2.4 compatible
In-Reply-To: <SjK-9.A.sEE.jd2N7@dinero.interactivesi.com>
Message-ID: <Pine.LNX.3.95.1010625123838.9515A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Timur Tabi wrote:

> ** Reply to message from James Lamanna <jlamanna@its.caltech.edu> on Sat, 23
> Jun 2001 22:10:58 -0700
> 
> 
> > It would be nice to have it working under 2.4, so is there someplace
> > that outlines some of the major things that would have changed so I can
> > update the module accordingly?
> 
> Unfortunately, no.  But if it turns out I'm wrong, please let me know what you
> find.
> 

As a start:

wait_queue_head_t	Now defined.
You can do '#if !defined(...)` and make code changes backwards compatible.


Macro, THIS_MODULE	is now the first member of struct file_operations.


Include <linux/init.h>	__init data type for one-time initialization code
			or data.
This is new, hense not backwards compatible.


Explicit initialization of spin-locks, SPIN_LOCK_UNLOCKED and/or
			spin_lock_init(spinlock_t *);
If you fix this, it's backwards compatible.


ioremap() and friends is now required even for low memory stuff.
You can no longer access this with a simple pointer, you must
use readl()/writel(), etc., for proper defererence. If you fix
this, it's backwards compatible.


These changes should get your module to compile (or nearly so).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


