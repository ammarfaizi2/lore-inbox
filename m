Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUAVWzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUAVWzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:55:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64498 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266466AbUAVWzc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:55:32 -0500
Message-ID: <401054BF.2080701@mvista.com>
Date: Thu, 22 Jan 2004 14:54:55 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org,
       Daniel Jacobowitz <drow@mvista.com>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
References: <200401161759.59098.amitkale@emsyssoft.com> <200401211916.49520.amitkale@emsyssoft.com> <400F0490.6000209@mvista.com> <200401221039.14979.amitkale@emsyssoft.com> <20040122172035.GI15271@stop.crashing.org>
In-Reply-To: <20040122172035.GI15271@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Jan 22, 2004 at 10:39:14AM +0530, Amit S. Kale wrote:
> 
>>On Thursday 22 Jan 2004 4:30 am, George Anzinger wrote:
>>
>>>Amit S. Kale wrote:
>>>
>>>>Now back to gdb problem of not being able to locate registers.
>>>>schedule results in code of this form:
>>>>
>>>>schedule:
>>>>framesetup
>>>>registers save
>>>>...
>>>>...
>>>>save registers
>>>>change esp
>>>>call switchto
>>>>restore registers
>>>>...
>>>
>>>I have not analyzed this as yet.  However, it does seem to me to be the
>>>same problem as trying to bt through an interrupt frame.  The correct way
>>>to do this is to build the dwarf frame descriptors.  I have done this for
>>>the interrupt frame and intend to send said patch out in a day or so.
>>
>>Great! I had to do it this ackward way:
>>
>>i386 ->
> 
> [snip]
> 
>>I guess your patch will fix this problem for i386 only. Any ideas on doing it 
>>for powerpc too?
> 
> 
> Maybe I'm missing something, but aside from having to re-write the
> solution in PPC asm, if it's in i386 asm, why wouldn't this work for PPC
> as well?
> 
I think the asm is not the issue.  the only stuff used is constant and pointer 
generation code, no machine instructions.  All that would have to be done is to 
describe, in the dwarft language, the interrupt frame.  This is different for 
different archs so this is where the work would be needed.

Daniel has suggested that we could just use the new bin tools where in the gas 
program will build the call frames.  I am not sure it can handle expressions, 
however.  And they are needed if you want to tie off the frame if the next step 
is user land.

By the way, I don't try to build a blow by blow of the frame.  Rather I assume 
it is only of interest at those points where calls are made out of the interrupt 
/trap code.  (Or, in some cases, jumps are made back into it.)


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

