Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVBPRBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVBPRBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 12:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVBPRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 12:01:45 -0500
Received: from alog0310.analogic.com ([208.224.222.86]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262078AbVBPRBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 12:01:43 -0500
Date: Wed, 16 Feb 2005 12:00:53 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Martin Bogomolni <martinbogo@gmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: NTFS - Kernel memory leak in driver for kernel 2.4.28?
In-Reply-To: <712fce1050216082847bec092@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0502161151370.10018@chaos.analogic.com>
References: <712fce1050216082847bec092@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Martin Bogomolni wrote:


[SNIPPED...]

> after the 'find' command is run.   malloc( ) fails to allocate
> afterwards. so the kernel does not free any of the missing RAM for
> malloc( ).
>

Whatever program is using malloc() is either corrupting
its buffers or has a memory leak.

Malloc() will always succeed even if the kernel has no
memory available. This is because the actual allocation
only occurs when the program attempts to write to one
of those pages malloc() "promised".

When you look at kernel memory after using `find` everything,
the directory of everything you have accessed remains in
memory until the kernel needs page(s) to give to processes.

So, the bottom line is, if malloc() returns NULL, you have
a problem with your program. It has nothing to do with
the kernel and "discovering" that the kernel has used
all available RAM for temporary buffers is not interesting.


[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
