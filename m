Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWIRTLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWIRTLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWIRTLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:11:03 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:16042 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751604AbWIRTLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 15:11:01 -0400
Message-ID: <450EEF2E.3090302@us.ibm.com>
Date: Mon, 18 Sep 2006 12:10:38 -0700
From: Vara Prasad <prasadav@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       systemtap <systemtap@sourceware.org>
Subject: Re: tracepoint maintainance models
References: <20060917143623.GB15534@elte.hu>	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>	 <1158594491.6069.125.camel@localhost.localdomain>	 <20060918152230.GA12631@elte.hu>	 <1158596341.6069.130.camel@localhost.localdomain>	 <20060918161526.GL3951@redhat.com> <1158598927.6069.141.camel@localhost.localdomain>
In-Reply-To: <1158598927.6069.141.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Ar Llu, 2006-09-18 am 12:15 -0400, ysgrifennodd Frank Ch. Eigler:
>  
>
>>>[...] So its L1 misses more register reloads and the like. Sounds
>>>more and more like wasted clock cycles for debug. [...]
>>>      
>>>
>>But it's not just "for debug"!  It is for system administrators,
>>end-users, developers.
>>    
>>
>
>It is for debug. System administrators and developers also do debug,
>they may just use different tools. The percentage of schedule() calls
>executed across every Linux box on the planet where debug is enabled is
>so close to nil its noise. Even with traces that won't change.
>  
>

Precisely the reason this huge thread is arguing why we shouldn't be 
including only static marker mechanism in the kernel tree. We are using 
dynamic probe mechanism which doesn't alter the execution flow or 
prevent compiler in making good optimizations for the most part but 
there are few code paths that are critical in understanding that we are 
not able to use this dynamic method for which we need static markers. As 
Martin pointed out if one is critical about performance they can be 
compiled out.

It is also important to note the amount of $s lost by taking long time 
to find a solution to a problem due to lack of good debugging tools is 
also significant compared to few additional clock cycles machines spend 
due to these static markers.

>  
>
>>Indeed, there will be some non-zero execution-time cost.  We must be
>>willing to pay *something* in order to enable this functionality.
>>    
>>
>
>There is an implementation which requires no penalty is paid. Create a
>new elf section which contains something like
>
>	[address to whack with int3]
>	[or info for jprobes to make better use]
>	[name for debug tools to find]
>	[line number in source to parse the gcc debug data]
>  
>
I am not sure i quiet understand your line number part of the proposal. 
Does this proposal assume we have access to source code while generating 
dynamic probes?

>
>  
>
This still doesn't solve the problem of compiler optimizing such that a 
variable i would like to read in my probe not being available at the 
probe point.

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


