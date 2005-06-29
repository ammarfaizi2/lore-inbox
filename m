Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVF2UzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVF2UzD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVF2Uyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:54:33 -0400
Received: from alog0075.analogic.com ([208.224.220.90]:7568 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262640AbVF2Uv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:51:27 -0400
Date: Wed, 29 Jun 2005 16:50:27 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Sreeni <sreeni.pulichi@gmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Forcing loader to load a prog at a fixed memory location
In-Reply-To: <94e67edf05062913272899af73@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0506291633490.10538@chaos.analogic.com>
References: <94e67edf05062810586d6141f3@mail.gmail.com>
 <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com> <94e67edf050629083745bb4183@mail.gmail.com>
 <Pine.LNX.4.61.0506291245170.22243@chaos.analogic.com>
 <17090.65093.315260.889211@smtp.charter.net> <94e67edf05062913272899af73@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Sreeni wrote:

> Hello,
>
> May I know the possible ways of instrcuting the compiler/loader to
> place a process's 'data segments (data, stack, heap bss etc)' at a
> *fixed*  physical/virtual addresses?
>
> Thanks
> Sreeni
>

.org	ADDRESS

Starts code or data at the OFFSET specified. However, you would
need to know where `ld` put the beginning of that segment to
know what the offset referred to.

If the code is in the kernel, You can tell the linker set fixups
for some load address as the kernel does. Look at linux-`uname 
-r`/arch/i386/boot/compressed/Makefile to see a possible syntax.

In user-space, you can check where the loader put label '_start' and
'_end' using. You can make code that is supposed to execute at
an offset from there. However, it will never be a physical location
that you can count on.

The way a user-mode program accesses physical memory is by using
mmap() MAP_FIXED.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
