Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCHR7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCHR7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVCHR7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:59:42 -0500
Received: from alog0177.analogic.com ([208.224.220.192]:28032 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261457AbVCHR7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:59:32 -0500
Date: Tue, 8 Mar 2005 12:57:23 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Imanpreet Arora <imanpreet@gmail.com>
cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: Question regarding thread_struct
In-Reply-To: <c26b959205030809271b8a5886@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503081244390.12076@chaos.analogic.com>
References: <c26b959205030809044364b923@mail.gmail.com> 
 <1110302000.23923.14.camel@betsy.boston.ximian.com> <c26b959205030809271b8a5886@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Imanpreet Arora wrote:

> On Tue, 08 Mar 2005 12:13:20 -0500, Robert Love <rml@novell.com> wrote:
>> On Tue, 2005-03-08 at 22:34 +0530, Imanpreet Arora wrote:
>>
>>>       I am wondering if someone could provide information as to how
>>> thread_struct is kept in memory. Robert Love mentions that it is kept
>>> at the "lowest"  kernel address in case of x86 based platform. Could
>>> anyone answer these questions.
>>
>> Kernel _stack_ address for the given process.
>>
>>> a)    When a stack is resized, is the thread_struct structure copied onto
>>> a new place?
>>
>> This is the kernel stack, not any potential user-space stack.  Kernel
>> stacks are not resized.
>
> This has been a doubt for a couple of days, and I am wondering if this
> one could also be cleared. When you say kernel stack, can't be resized
>

Every task (process) has its own stack which can be as large as
necessary. It grows down towards the user data.

When a user calls the kernel, the kernel code switches to
a 'kernel stack' which is a separate stack and there is a
different one for each and every task on the system. Since,
with thousands of tasks, there will be thousands of kernel stacks,
it is essential to make the kernel stack as small as possible.
In the ix86, this has meant either 1 or two pages of PAGE_SIZE
length (0x1000 currently).

>
> a)       Does it mean that the _whole_ of the kernel is restricted to
> that 8K or 16K of memory?
>

All code that executes in the kernel must use the stack that has
already been allocated for it. If you have code that cares about
the size of the kernel stack, the code is broken. If you have
an array, allocated in the kernel, that's longer than a few
hundred bytes, you use kmalloc() or other kernel allocators
for that array.

> b)        Or does it mean that a particular stack for a particular
> process, can't be resized?
>

Stacks are never resized and, in fact, this isn't a Unix/Linux
thing, it's just never done because it's stupid and, if necessary,
is used to cover up something equally stupid, like excessive
recursion.

> c)         And for that matter how exactly do we define a kernel stack?
>

You don't.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
