Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTEIIrX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbTEIIrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:47:23 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:1711 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262390AbTEIIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:47:17 -0400
Date: Fri, 9 May 2003 04:58:06 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: desc v0.61 found a 2.5 kernel bug
To: paubert <paubert@mrt-lx16.iram.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305090459_MC3-1-381B-CA56@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paubert wrote:

>>   invalid FS,GS -> 0
>>      "    DS,ES -> __USER_DS
>>           CS,SS -> panic?
>
> It's still racy on SMP if a thread with the same MM is modifying the LDT
> between the time you check whether the selectors are valid and the iret
> instruction restoring the previous stack.

 Probably nothing can be done about that, either.  Handling invalid segment
with another hardware task doesn't help since the trap occurs in the context
of the new task and there's no way to tell what happened by then.

>> 
>>  Bad things can happen if a debug fault happens in certain places... for now
>> the solution is to only support int3 breakpoints and avoid those places.
>
> Can you elaborate a bit, in which places?

 I never even implemented the above checks; there is just a comment in the code
where they belong. It ran for five days that way, then generated a string
of segfaults while trying to shut down.

>> 
>>  Given the above, I hope to be able to put int3 instructions in either
>> kernel or user code and get snapshots of CPU state in the kernel TSS.
>
> And what about the little bit called TS in CR0 which is always set by 
> a task switch.

 Forgot all about that one.  Maybe pushing cs:eip and flags onto the kernel's
stack and returning to an iret in the kernel task would work?
