Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265100AbUEYVbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUEYVbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUEYVbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:31:38 -0400
Received: from mail.ccur.com ([208.248.32.212]:20491 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265100AbUEYVb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:31:29 -0400
Date: Tue, 25 May 2004 17:31:28 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: markh@compro.net, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-ID: <20040525213128.GA26323@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040525124715.5f7e61b6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525124715.5f7e61b6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 03:47:15PM -0400, Andrew Morton wrote:

>>>>> 2.6.0-test6: the use of mlockall(2) in a process that has mmap(2)ed
>>>>> the registers of an IO device will hang that process uninterruptibly.
>>>>> The task runs in an infinite loop in get_user_pages(), invoking
>>>>> follow_page() forever.

>>>> I know this is an old thread but can anyone tell me if this problem is
>>>> resolved in the current 2.6.6 kernel? 

>>> There's an utterly ancient patch in -mm which might fix this.

> That patch had its first birthday last week.  I wrote it in response to
> some long-forgotten problem, failed to changelog it at the time then forgot
> why I wrote it.  I kept it in the hope that I'd remember why I wrote it.  I
> subsequently wrote a best-effort changelog but am unconvinced by it.  Ho
> hum.
> 
> Let me genuflect a bit.  I guess we can be reasonably confident it won't
> break anything.

How about this for a ChangeLog (also created from memory and from some
of your inlined comments):

    Do not follow pagetables for VM_IO regions, they might
    not have pageframes.

    Discovered when an mlockall'ed program tried to mmap
    some device's registers (using /dev/mem); the program
    hangs on the mmap, looping forever in get_user_pages(),
    trying to do a follow_page() that never succeeds.

-- 
Joe
"Money can buy bandwidth, but latency is forever" -- John Mashey
