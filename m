Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291213AbSBLWQB>; Tue, 12 Feb 2002 17:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291215AbSBLWPw>; Tue, 12 Feb 2002 17:15:52 -0500
Received: from air-2.osdl.org ([65.201.151.6]:2688 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S291213AbSBLWPi>;
	Tue, 12 Feb 2002 17:15:38 -0500
Date: Tue, 12 Feb 2002 14:15:33 -0800
From: Bob Miller <rem@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.4 Can't use spin_lock_* with wait_queue_head_t object.
Message-ID: <20020212141533.A7653@doc.pdx.osdl.net>
In-Reply-To: <20020212120100.A7619@doc.pdx.osdl.net> <Pine.LNX.3.95.1020212162231.10673A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020212162231.10673A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 04:23:39PM -0500, Richard B. Johnson wrote:

> On Tue, 12 Feb 2002, Bob Miller wrote:
> 
> > There is code in sched.c that uses the spin_lock_* interfaces to acquire and
> > release the lock in the wait_queue_head_t embedded in the struct completion.
> > 
> Isn't it just that the spin_lock wasn't initialized at the start?
> 

No.  The DECLARE_COMPLETION() macro was called in the case that oops'd.

The problem is that when wait.h:USE_RW_WAIT_QUEUE_SPINLOCK is set
the type of lock in the wait_queue_head_t changes from being a
spinlock_t to a rwlock_t.

If you also set CONFIG_DEBUG_SPINLOCK, the wq_lock_t in the
wait_queue_head_t is initialized with a rwlock_t magic number
(0xdeaf1eed), but the spin_lock_XXX() code checks for the spinlock_t
magic number (0xdead4ead) and calls BUG() when the check fails.


-- 
Bob Miller					Email: rem@osdl.org
Open Software Development Lab			Phone: 503.626.2455 Ext. 17
