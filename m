Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbUKIUZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbUKIUZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUKIUZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 15:25:29 -0500
Received: from alog0321.analogic.com ([208.224.222.97]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261679AbUKIUZS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 15:25:18 -0500
Date: Tue, 9 Nov 2004 15:25:12 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: More linux-2.6.9 module problems
In-Reply-To: <41911FD4.2060902@sun.com>
Message-ID: <Pine.LNX.4.61.0411091522440.3519@chaos.analogic.com>
References: <Pine.LNX.4.61.0411081148520.5510@chaos.analogic.com>
 <41911FD4.2060902@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> linux-os wrote:
>>
>> I have a memory-test procedure that tests
>> memory on a board, accessed via the PCI bus.
>> There is a lot of RAM and it's bank-switched
>> into some 64k windows so it takes a lot of
>> time to test, about 60 seconds.
>>
>> This is in a module, therefore inside the kernel.
>> When it is invoked via an ioctl() call, the
>> kernel is frozen for the whole test-time. The
>> test procedure does not use any spin-locks nor
>> does it even use any semaphores. It just does a
>> bunch of read/write operations over the PCI/Bus.
>>
>> I thought that I could enable the preemptible-
>> kernel option and the machine would then respond
>> normally. Not so. Even with 4 CPUs, when one
>> ioctl() is busy in the kernel, nothing else
>> happens until its done. Even keyboard activity
>> is gone, no Caps Lock and no Num Lock, no `ping`
>> response over the network. However, the machine
>> comes back to life when the memory-test is done.
>>
>> This is kernel version 2.6.9. Is it possible that
>> somebody left on the BKL when calling a module
>> ioctl() on this version? If not, what do I do
>> to be able to execute a time-consuming procedure
>> from inside the kernel? Do I break it up into
>> sections and execute schedule() periodically
>> (temporary work-around --works)??
>>
>
> The BKL has always been grabbed across ioctls.  Drop the lock when you
> enter your f_op->ioctl call and grab it again open completion.
>

Hmmm. I get 'scheduling while atomic' screaming across the screen!
There are no atomic operations in my ioctl functions so I don't
know what its complaining about. I think I shouldn't have tried
to do anything with BKL because I (my task) doesn't own it.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
