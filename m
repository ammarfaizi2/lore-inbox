Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVCaBhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVCaBhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVCaBhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:37:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56053 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262442AbVCaBgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:36:51 -0500
Message-ID: <424B542F.9090308@mvista.com>
Date: Wed, 30 Mar 2005 17:36:47 -0800
From: Frank Rowand <frowand@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Rowand <frowand@mvista.com>, Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu> <423F691E.200@mvista.com>
In-Reply-To: <423F691E.200@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Rowand wrote:
> Ingo Molnar wrote:
> 
>> hi Frank - sorry about the late reply, was busy with other things. Your
> 
> 
> My turn to be late, but now I'm back from vacation :-).
> 
> 
>> ppc patches look mostly mergeable, with some small details still open:
>>
>> * Frank Rowand <frowand@mvista.com> wrote:
>>
>>
>>> The patches are:
>>>
>>> 1/5 ppc_rt.patch          - the core realtime functionality for PPC
>>
>>
>>
>> what is the rationale behind the rt_lock.h changes? The #ifdef
>> CONFIG_PPC32 changes in generic code are not really acceptable, the -RT
>> tree tries to keep a single spinlock definition and debugging
>> primitives, across all architectures.

< stuff deleted >

> The second "#ifdef CONFIG_PPC32" is in raw_rwlock_t, making the lock
> field signed instead of unsigned.  The PPC code uses the value of
> -1 to mean write locked, 0 to mean unlocked, and >0 to mean read
> locked.  With one minor exception, all of the PPC raw_rwlock_t related
> code will work properly with an unsigned type because the code that
> checks the value of lock is assembly and treats lock as signed.  The
> one non-assembly code that examines lock as a signed object is in
> arch/ppc/lib/locks.c and is disabled unless CONFIG_DEBUG_SPINLOCK is
> defined.  If CONFIG_DEBUG_SPINLOCK is ever enabled this will be
> very evident as each call to __raw_write_unlock() will result in a
> printk() warning.  The strongest reason I could advance for making
> lock signed for PPC32 is that any future C code that checks for a
> lock value less than zero will not function correctly and might not
> be very obvious.
> Thus it is also OK that you left this chunk out of your patch.

< more stuff deleted >

I'm working on the architecture support for realtime on PPC64 now.
If the lock field of struct raw_rwlock_t is a long instead of int
then /proc/meminfo shows MemFree decreasing from 485608 kB to 485352 kB.

Do you have a preference for lock to be long instead of int?

Do you know if any of the other 64 bit architectures would have an
issue with int?


-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

