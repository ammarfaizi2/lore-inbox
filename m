Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVCJAot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVCJAot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCIXzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:55:40 -0500
Received: from alog0211.analogic.com ([208.224.220.226]:45696 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262265AbVCIXr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:47:58 -0500
Date: Wed, 9 Mar 2005 18:44:00 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andrew Morton <akpm@osdl.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, blaisorblade@yahoo.it,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org,
       amitg@calsoftinc.com, gud@eth.net
Subject: Re: [patch 1/1] unified spinlock initialization arch/um/drivers/port_kern.c
In-Reply-To: <20050309145044.764bc056.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503091840210.22633@chaos.analogic.com>
References: <20050309094234.8FC0C6477@zion> <20050309171231.H25398@flint.arm.linux.org.uk>
 <200503092052.24803.blaisorblade@yahoo.it> <20050309224259.J25398@flint.arm.linux.org.uk>
 <20050309145044.764bc056.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005, Andrew Morton wrote:

> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>>
>>  I'm not convinced about the practicality of converting all static
>>  initialisations to code-based initialisations though
>
> This is the first one I recall seeing.  All the other conversions were replacing
>
> 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
>
> with
> 	static DEFINE_SPINLOCK(lock);
>
> and replacing
>
> 	{
> 		lock = SPIN_LOCK_UNLOCKED;
> 	}
>
> with
>
> 	{
> 		spin_lock_init(lock);
> 	}

We need to retain the spin_lock_init(&lock) because not all spin-locks
are allocated at compile-time. They might be allocated from kmalloc()
on startup, probably in a structure, along with other so-called
global data.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
