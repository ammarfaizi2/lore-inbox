Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUCWVqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUCWVqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:46:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64240 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262882AbUCWVpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:45:47 -0500
Message-ID: <4060B005.4020804@mvista.com>
Date: Tue, 23 Mar 2004 13:45:41 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Call frame debug info for 2.6 kernel
References: <1AR5s-75I-27@gated-at.bofh.it> <1CHY0-1Uw-9@gated-at.bofh.it> <m3n0685nfp.fsf@averell.firstfloor.org>
In-Reply-To: <m3n0685nfp.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> George Anzinger <george@mvista.com> writes:
> 
> 
>>This patch adds call frame debug record generation for entry.S frames.
> 
> 
> [...]
> 
> Sorry, but that's quite ugly and will be hard to maintain (kinda like
> maintaining an own assembler on your own) I think it would be far
> better to require recent binutils for DEBUG_INFO builds and use the
> .cfi_* mnemonics. They make dwarf2 code *much* simpler and cleaner.
> 
> Overall I think it's a good idea to add full dwarf2 annotation to
> the i386 kernel, but not without assembler please.

Hi Andi,

I just knew you would say that :).

I think I have said before that the current .cfi support in the assembler is not 
up to the job.  In fact gdb 6.0 also has a nasty bug that this code works 
around.  The main issue is the ability to use the dwarf2 cfi expression to build 
a call frame that determines if the interrupt/ trap frame returns to user space 
or to the kernel.  I think (I confess I have not tried) this may be doable with 
the .cfi escape op code, but I suspect the result would be just as ugly as this 
patch is.  You would have to roll your own .uleb128 and .sleb128 numbers, for 
example.   Also, you would need to be able to define labels in the dwarf code 
(or intuit how var the assembler is going to put your target and use that offset).

The long and short of it is, to do it at all, you need to have a fair knowledge 
of dwarf2.  Once you get to that, I suspect one way is as good as another.

At this point, the code works with kgdb, which, itself is not in the kernel.  I 
welcome any one who wants to help do it correctly.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

