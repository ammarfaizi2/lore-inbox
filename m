Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTJ2WuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJ2WuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:50:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60150 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261940AbTJ2WuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:50:12 -0500
Message-ID: <3FA0441E.9000205@mvista.com>
Date: Wed, 29 Oct 2003 14:50:06 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: Is there a kgdb for Opteron for linux-2.6?
References: <1066678923.1007.164.camel@new.localdomain>	<20031024135112.GE2286@wotan.suse.de>	<3F9EF206.1040105@mvista.com>	<20031029002517.47d8f329.ak@suse.de>	<3FA02DCF.4080906@mvista.com> <20031029222454.7ec07a9e.ak@suse.de>
In-Reply-To: <20031029222454.7ec07a9e.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, 29 Oct 2003 13:14:55 -0800
> George Anzinger <george@mvista.com> wrote:
> 
> 
>>Andi Kleen wrote:
>>
>>>On Tue, 28 Oct 2003 14:47:34 -0800
>>>George Anzinger <george@mvista.com> wrote:
>>>
>>>
>>>
>>>
>>>>I see that Andrew has not picked up my latest kgdb.  In the latest version I 
>>>>have the dwarf2 stuff working in entry.S.  Just ask, off list.
>>>
>>>
>>>Do you use the .cfi* mnemonics in newer binutils? Without that it would get ugly.
>>
>>I use asm mnemonics .uleb*, .sleb*, .byte and .long.  For operands I use the 
>>defines in dwarf2.h (after fixing them to work with asm).  These are, for the 
>>most part DW_CFA_* and other DW_* things.  I put this together to build macros 
>>(CCP) so that I can code things like:
> 
> 
> The latest binutils has new .cfi_* mnemonics in gas that make writing such a table
> much cleaner and easier. My plan was to use that. It would require new binutils,
> but make future mainteance much easier. When people don't have the new binutils
> it can be defined away.
> 
> See http://www.logix.cz/~mic/devel/gas-cfi/

Looks like good stuff if you want to do a blow by blow.  I decided against this 
in the register save and restore code as it is hardly ever needed.  An asm 
function is another matter and this looks good for that.

An observation:  Once you have the register save info in a CFI call frame, you 
can refer to it from anyplace you do the same save order.  For example, in my 
code, the trap save and the system call save as well as the interrupt saves are 
all covered by the one cfi entry.  This does not work if you want to do a blow 
by blow on the save and restore of the registers.  Also, I don't see the entries 
to do expression evaluation (yet).

> 
> 
>>Which allows "bt" through entry.S code.  I did not try to allow you to get the 
>>correct answer if you stop in the middle of the register save or restore code.
> 
> 
> On x86-64 it is unfortunately more complicated because it has a separate interrupt
> or exception stack. The backtracker has to read the old stack pointer from the 
> frame. This can be expressed in dwarf2, but is a bit tricky.

Yes, the expression stuff...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

