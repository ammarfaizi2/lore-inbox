Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWIRU3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWIRU3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWIRU3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:29:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7644 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964893AbWIRU3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:29:01 -0400
Message-ID: <450F0180.1040606@us.ibm.com>
Date: Mon, 18 Sep 2006 13:28:48 -0700
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
References: <20060917143623.GB15534@elte.hu>	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>	 <1158594491.6069.125.camel@localhost.localdomain>	 <20060918152230.GA12631@elte.hu>	 <1158596341.6069.130.camel@localhost.localdomain>	 <20060918161526.GL3951@redhat.com>	 <1158598927.6069.141.camel@localhost.localdomain>	 <450EEF2E.3090302@us.ibm.com> <1158608981.6069.167.camel@localhost.localdomain>
In-Reply-To: <1158608981.6069.167.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Ar Llu, 2006-09-18 am 12:10 -0700, ysgrifennodd Vara Prasad:
>  
>
>>I am not sure i quiet understand your line number part of the proposal. 
>>Does this proposal assume we have access to source code while generating 
>>dynamic probes?
>>    
>>
>
>Its one route - or we dump it into an ELF section in the binary.
>  
>
Source code access is not a good solution but ELF section could work.

>  
>
>>This still doesn't solve the problem of compiler optimizing such that a 
>>variable i would like to read in my probe not being available at the 
>>probe point.
>>    
>>
>
>Then what we really need by the sound of it is enough gcc smarts to do
>something of the form
>
>	.section "debugbits"
>	
>	.asciiz 'hook_sched'
>	.dword l1	# Address to probe
>	.word 1		# Argument count
>	.dword gcc_magic_whatregister("next"); [ reg num or memory ]
>	.dword gcc_magic_whataddress("next"); [ address if exists]
>
>
>Can gcc do any of that for us today ?
>
>  
>
No, gcc doesn't do that today.


