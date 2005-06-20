Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFTOXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFTOXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFTOXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:23:32 -0400
Received: from alog0018.analogic.com ([208.224.220.33]:42624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261256AbVFTOX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:23:26 -0400
Date: Mon, 20 Jun 2005 10:22:58 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <Pine.LNX.4.61.0506201443400.2903@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0506201018460.5458@chaos.analogic.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <Pine.LNX.4.61.0506201443400.2903@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Hugh Dickins wrote:

> Gosh, I thought from the Subject that you'd taken over from Linus,
> and were announcing your new release ;)
>
> On Mon, 20 Jun 2005, Richard B. Johnson wrote:
>>
>> Attempts to run a driver that worked up to 2.6.11.9 shows that
>> it aparently is no longer possible to nest calls to `down`.
>> In other words, a procedure that has taken a semaphore can't
>> then take another semaphore.
>>
>> down(&first_resource);
>> down(&second_resource);
>> ...
>> ...
>> up(&second_resource);
>> up(&first_resource);
>>
>>
>> The error is 'sleeping function called from invalid context....'
>>
>> ------------[ cut here ]------------
>> kernel BUG at mm/memory.c:1112!
>
> No, the error is "kernel BUG at mm/memory.c:1112!", which occurs while
> it's holding page table lock, from which it doesn't recover very well.
>
> It's the BUG_ON(!pte_none(*pte)) in remap_pte_range.  Maybe your page
> table is corrupt, maybe your driver is trying to remap_pfn_range on
> top of something already mapped.
>
> Hugh
>

But of course it is. There is some memory that is mapped into the
driver's address space, used for DMA. It was obtained using
ioremap_nocache(). This memory is then mapped into user-space
when the user executes mmap(). This is how we DMA directly to
user-space. Is this no longer allowed?


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
