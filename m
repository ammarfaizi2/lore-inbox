Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965835AbWKEERp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965835AbWKEERp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965837AbWKEERp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:17:45 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:15781 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965835AbWKEERo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:17:44 -0500
Message-ID: <454D65E8.3000409@vmware.com>
Date: Sat, 04 Nov 2006 20:17:44 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <454CE576.3000709@vmware.com> <20061105035556.GQ9057@kvack.org>
In-Reply-To: <20061105035556.GQ9057@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Sat, Nov 04, 2006 at 11:09:42AM -0800, Zachary Amsden wrote:
>   
>> Every processor I've ever measured it on, popf is slower.  On P4, for 
>> example, pushf is 6 cycles, and popf is 54.  On Opteron, it is 2 / 12.  
>> On Xeon, it is 7 / 91.
>>     
>
> pushf has to wait until all flag dependancies can be resolved.  On the 
> P4 with >100 instructions in flight, that can take a long time.  Popf 
> on the other hand has no dependancies on outstanding instructions as it 
> resets the machine state.
>   

Yes, but as Linus points out popf is most likely microcoded, thus much 
slower.  Flag dependency is not unique to pushf, many much more common 
instructions (adc, jcc, sbc, cmovcc, movs, stos, ...) have flag 
dependencies, which can still be pipeline forwarded.  I think the raw 
cycle counts speak for themselves, despite the fact that I only measured 
instruction latency, not throughput.  Using a branch to eliminate a 
pushf is thus probably not a win in most cases.

Zach
