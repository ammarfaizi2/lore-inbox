Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUCDAjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCDAjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:39:19 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4854 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261340AbUCDAhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:37:12 -0500
Message-ID: <40467A1B.9040204@mvista.com>
Date: Wed, 03 Mar 2004 16:36:43 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, amit@av.mvista.com
Subject: Re: [Kgdb-bugreport] [KGDB][RFC] Send a fuller T packet
References: <20040302220233.GG20227@smtp.west.cox.net> <404518AD.40606@mvista.com> <20040302233635.GM20227@smtp.west.cox.net> <20040303105246.GA342@elf.ucw.cz> <20040303150802.GP20227@smtp.west.cox.net>
In-Reply-To: <20040303150802.GP20227@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Wed, Mar 03, 2004 at 11:52:47AM +0100, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>
>>>>I would really like to keep this stuff out of kgdb.h since it may be 
>>>>included by the user to pick up the BREAKPOINT() (which, by the way we 
>>>>should standardize as I note that here it has () while not on the current 
>>>>x86).
>>>
>>>It's BREAKPOINT() everywhere:
>>>$ grep BREAKPOINT include/asm-*/kgdb.h
>>>include/asm-i386/kgdb.h:#define BREAKPOINT() asm("   int $3");
>>>include/asm-ppc/kgdb.h:#define BREAKPOINT()             asm(".long 0x7d821008") /* twge r2, r2 */
>>>include/asm-x86_64/kgdb.h:#define BREAKPOINT() asm("   int $3");
>>
>>Notice how it ends with ';' on everything but ppc. Perhaps it needs do
>>{ } while (0) wrapping?
> 
> 
> ... not that PPC works right now :)  But yes, you're right.
> 
I agree, lets force the ";".
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

