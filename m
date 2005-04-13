Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVDMTVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDMTVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDMTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:21:21 -0400
Received: from alog0229.analogic.com ([208.224.220.244]:49639 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261252AbVDMTVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:21:04 -0400
Date: Wed, 13 Apr 2005 15:20:38 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Hacksaw <hacksaw@hacksaw.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before
 using it
In-Reply-To: <20050413183742.GA5252@thunk.org>
Message-ID: <Pine.LNX.4.61.0504131507280.21367@chaos.analogic.com>
References: <200504131159.j3DBxsoa010918@hacksaw.org>
 <Pine.LNX.4.61.0504130818300.12518@chaos.analogic.com> <20050413183742.GA5252@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Theodore Ts'o wrote:

> On Wed, Apr 13, 2005 at 08:40:05AM -0400, Richard B. Johnson wrote:
>> The kernel does NOT have to copy data from user-space before
>> using it.
>
> Incorrect.  It must, or the kernel code in question is by definition
> buggy.
>

What? Explain why a memory-mapped buffer can't be DMAed directly?

>> In fact, user-mode pointers are valid in kernel-space
>> when the kernel is performing a function on behalf of the user-
>> mode code.
>
> On some architectures, this is true.  But not all architectures, and
> not in all circumstances.  For example, even on the x86 architecture,
> in the 4G/4G mode, a user-mode pointer is *not* valid when kernel code
> is running.  You must use copy_to_user()/copy_from_user().  Simply
> dereferencing a user-mode pointer is a BUG.  It might work sometimes,
> on some architectures, but not everywhere.  Therefore, for correctly
> written kernel code, you must not do it.

You apparently didn't even bother to read my explanation why the
copy/to/from user was necessary unless the buffer(s) were memory-
mapped, marked reserved, and set to no-cache. In that case
you can DMA directly to/from user-space. Perhaps you just wanted
to argue?

> 						- Ted

Again, as long as you can guarantee that the RAM you are using
is reserved so the kernel won't use it for paged RAM, and as
long as it's accessible in both user-mode and kernel-mode,
which means memory-mapped, either the kernel or the user can
use it as it sees fit. If it can't, the kernel is buggy. In
fact, there is no way the kernel could prevent it from being
used in this manner. Since, by definition, the kernel
will leave reserved memory alone, and memory-mapped space
will not fault, there is no way for the kernel to even know
how it is being accessed.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
