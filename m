Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVA1TYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVA1TYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVA1TRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:17:22 -0500
Received: from alog0284.analogic.com ([208.224.222.60]:59008 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262775AbVA1TO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:14:59 -0500
Date: Fri, 28 Jan 2005 14:14:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jeff.Fellin@rflelect.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Verify system io addresses
In-Reply-To: <OF9D8C9A4F.B7F39615-ON85256F97.005DDD20@teal.com>
Message-ID: <Pine.LNX.4.61.0501281359270.28268@chaos.analogic.com>
References: <OF9D8C9A4F.B7F39615-ON85256F97.005DDD20@teal.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 Jeff.Fellin@rflelect.com wrote:

> I want to develop a device driver that would allow access to board
> registers and memory that is addressable
> on the system bus.  The reason for this is to allow hardware developers to
> access board registers while the system
> is running to determine what is wrong with a board. The problem I'm having
> is attempting to determine if an address
> is addressable and would not cause a system panic when accessing. I'm
> looking for functions similar to the

>From within the kernel, on Intel machines, all addresses that are
mapped (using ioremap_nocache()) are addressable even if there is
no hardware at that address. It cannot cause a system panic. A
read from non-existent hardware will simply return a value with
all bits set (0xffffffff for a size_t). A write will go to
hyper-space, doing nothing.

> verify_access for user addresses, or if that is not available a method to
> determine that an address fault in the
> kernel is actually due to a bad board address being used.
>

There will be no such faults. You to use ioremap_nocache() first.
Remember to iounmap() when you are through.

> The driver has a user program that allows the hardware developers to peek
> and poke at address locations.
> So it is possible for them to mistype the address.
>
> Thank you in advance for your help.
>

If the access is through a port (in and out instructions), you
don't have to do anything, ports are always available in kernel
space.


BBBBUUUTTT!  If you write to somebody else's address-space like
a hard-disk controller, you can destroy all your data requiring
a complete re-installation of everything. That's why what you
want to do is NOT what you should do.

You need to have a competent programmer make a driver and
its attendant test-program to thoroughly test your board(s)
with no possibility of somebody entering wrong information.

> Jeff Fellin
> RFL Electronics
> Jeff.Fellin@rflelect.com
> 973 334-3100, x 327

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
