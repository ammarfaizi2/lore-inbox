Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVGAUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVGAUkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVGAUir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:38:47 -0400
Received: from alog0205.analogic.com ([208.224.220.220]:40419 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262367AbVGAUgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:36:04 -0400
Date: Fri, 1 Jul 2005 16:34:39 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Christoph Lameter <christoph@lameter.com>
cc: Andi Kleen <ak@suse.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
In-Reply-To: <Pine.LNX.4.62.0507011302090.19234@graphe.net>
Message-ID: <Pine.LNX.4.61.0507011624320.5188@chaos.analogic.com>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel>
 <p73r7emuvi1.fsf@verdi.suse.de> <Pine.LNX.4.62.0506281238320.1734@graphe.net>
 <20050629024903.GA21575@bragg.suse.de> <Pine.LNX.4.62.0507011302090.19234@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Christoph Lameter wrote:

> On Wed, 29 Jun 2005, Andi Kleen wrote:
>
>> On Tue, Jun 28, 2005 at 12:41:59PM -0700, Christoph Lameter wrote:
>>> On Tue, 28 Jun 2005, Andi Kleen wrote:
>>>
>>>> It's unfortunately useless because all the kernel is mapped in the
>>>> same 2 or 4MB page has to be writable because it overlaps with real
>>>> direct mapped memory.
>>>
>>> The question is: Are syscall tables are supposed to be
>>> writable? If no then this patch should go in. If yes then forget about it.
>>
>> I think it would make sense in theory to write protect them
>> together with the kernel code and the modules
>> (just to make root kit writing slightly harder)
>
> Seems that you are evading the question that I asked. Are syscall tables
> supposed to be writable?
>
>> BTW the kernel actually needs to write to code once
>> to apply alternative(), but it would't be a problem to use
>> a temporary mapping for this.
>
> What does this have to do with the syscall table???
>
>>> The ability to protect a readonly section may be another issue.
>>
>> Well, it's the overriding issue here. Just pretending it's readonly
>> when it isn't doesn't seem useful.
>
> This is all are off-topic talking about a different issue. And we are
> already "pretending" that lots of other stuff in the readonly section is
> readonly.
>
> The issue is correct placement of variables. Read only variables are
> placed in a different section and the syscall tables are read only and
> need to be place in the correct section.

I modified my sycall table to put it in ".section .rodata". It appears
as though read-only is not enforced in the kernel. I don't know
why because, at least with ix86, both data and code can be made read-
only.

You just write to it with a segment descriptor that allows R/W, then
use another for R/O.  It is true that kernel code can create any
segment descriptor it wants, dynamically, thus a properly-written
program can ultimately write to what was once R/O data. However,
I think it should default to R/O which should cut down on the
number of cheap hacks that can damage it.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
