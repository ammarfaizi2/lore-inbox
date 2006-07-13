Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWGMPBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWGMPBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWGMPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:01:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30620 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030201AbWGMPBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:01:09 -0400
Message-ID: <44B65F8B.2020309@redhat.com>
Date: Thu, 13 Jul 2006 10:58:19 -0400
From: Bhavana Nagendra <bnagendr@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "shin, jacob" <jacob.shin@amd.com>, linux-kernel@vger.kernel.org
CC: "Deguara, Joachim" <joachim.deguara@amd.com>, Pavel Machek <pavel@suse.cz>,
       Andi Kleen <ak@suse.de>, "Langsdorf, Mark" <mark.langsdorf@amd.com>,
       discuss@x86-64.org, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to changepstate
 at same time
References: <B3870AD84389624BAF87A3C7B831499302935A88@SAUSEXMB2.amd.com>
In-Reply-To: <B3870AD84389624BAF87A3C7B831499302935A88@SAUSEXMB2.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some results without changing frequencies on a system whose 
BIOS does not support Power Now! on MP systems:

Basically the system booted up with "nohpet, nopmtimer"i.e. using TSC as 
the GTOD time source and system stayed idle for 13 hours.   There 
appears to be drift of 20 secs in the CPU 2 readings.    This TSC drift 
could worsen when
the system is active and doing GTOD operations and/or when system is up 
a lot longer. 

CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -108 cycles, maxerr 826 
cycles)
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -119 cycles, maxerr 845 
cycles)

*** CPUs go offline ***

*** back online ***

CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -117 cycles, maxerr 846 
cycles)
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -117 cycles, maxerr 845 
cycles)

shin, jacob wrote:

>On Thursday, July 13, 2006 9:32 AM Deguara, Joachim wrote:
>
>  
>
>>parallel sounds fun, but I don't get it.  Two machine or trying to go
>>online and offline at the same time?  Firestorming two busy parallel
>>while loops, one turning the core offline and the other online, did
>>not bring an oops so I guess this kernel is in the clear in that
>>regard. 
>>
>>I can't get it to crash again and I am afraid that it crashed under an
>>old devel kernel.  After another ~20 hour test with heavy freq changes
>>with the tscsync patch
>>    
>>
>
>There were several different issues w/ powernow + cpu hotplug in the
>past.  Good to hear that the latest kernel doesn't oops.. I believe 
>cpu hotplug is needed for suspend to work..
>
>
>  
>

