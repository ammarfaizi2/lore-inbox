Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVASWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVASWIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVASWHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 17:07:48 -0500
Received: from alog0085.analogic.com ([208.224.220.100]:13440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261925AbVASWBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 17:01:42 -0500
Date: Wed, 19 Jan 2005 17:01:23 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andrew Morton <akpm@osdl.org>
cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1 hang
In-Reply-To: <20050119133136.7a1c0454.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501191658020.11665@chaos.analogic.com>
References: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
 <20050119133136.7a1c0454.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Andrew Morton wrote:

> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>>
>> I was playing with kexec+kdump and ran into this on 2.6.10-mm1.
>>  I have seen similar behaviour on 2.6.10.
>>
>>  I am using a 4-way P-III machine. I have a module which tries
>>  gets same spinlock twice. When I try to "insmod" this module,
>>  my system hangs. All my windows froze, no more new logins,
>>  console froze, doesn't respond to sysrq. I wasn't expecting
>>  a system hang. Why ? Ideas ?
>>
>
> Maybe all the other CPUs are stuck trying to send an IPI to this one?  An
> NMI watchdog trace would tell.
>
>>  #include <linux/init.h>
>>  #include <asm/uaccess.h>
>>  #include <linux/spinlock.h>
>>  spinlock_t mylock = SPIN_LOCK_UNLOCKED;
>>  static int __init panic_init(void)
>>  {
>>          spin_lock_irq(&mylock);
>>          spin_lock_irq(&mylock);
>>         return 1;
>>  }
> -

What would you expect this to do? After the first lock is
obtained, the second MUST fail forever or else the spin-lock
doesn't work. The code, above, just proves that spin-locks
work!


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
