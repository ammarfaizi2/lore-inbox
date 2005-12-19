Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVLSI7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVLSI7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 03:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVLSI7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 03:59:02 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:44960 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932203AbVLSI7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 03:59:00 -0500
Message-ID: <43A6773A.6060306@aitel.hist.no>
Date: Mon, 19 Dec 2005 10:02:50 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Lee Revell <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de> <43A1DB18.4030307@wolfmountaingroup.com> <1134688488.12086.172.camel@mindpipe> <43A1E451.2090703@wolfmountaingroup.com> <1134689197.12086.176.camel@mindpipe> <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>On Thu, 15 Dec 2005, Lee Revell wrote:
>
>  
>
>>On Thu, 2005-12-15 at 14:46 -0700, Jeff V. Merkey wrote:
>>    
>>
>>>Lee Revell wrote:
>>>
>>>      
>>>
>>>>On Thu, 2005-12-15 at 14:07 -0700, Jeff V. Merkey wrote:
>>>>
>>>>
>>>>        
>>>>
>>>>>When you are on the phone with an irrate customer at 2:00 am in the
>>>>>morning, and just turning off your broken 4K stack fix
>>>>>and getting the customer running matters.
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>Bugzilla link please.  Otherwise STFU.
>>>>
>>>>
>>>>        
>>>>
>>>??????
>>>
>>>Jeff
>>>      
>>>
>>You imply that your customer's problem was due to a kernel bug triggered
>>by CONFIG_4KSTACKS.  I am asking you to provide a link to the bug report
>>or get lost.
>>
>>Lee
>>    
>>
>
>Throughout the past two years of 4k stack-wars, I never heard why
>such a small stack was needed (not wanted, needed). It seems that
>everybody "knows" that smaller is better and most everybody thinks
>that one page in ix86 land is "optimum". However I don't think
>anybody ever even tried to analyze what was better from a technical
>perspective. Instead it's been analyzed as religious dogma, i.e.,
>keep the stack small, it will prevent idiots from doing bad things.
>
>I'm fairly sure that if you started from scratch and decided to
>write a new operating system, your choice of a stack-size would
>probably be something like 64k. I have no clue why somebody
>decided to use a 4k stack and force their choice upon others.
>And, yes, I am well aware that each system-call requires a
>seperate stack upon entry and it even needs to keep that stack
>while sleeping.
>  
>
No.  If writing an os from scratch, then using 4k stacks would
be absolutely trivial.  The problems now happens only because
we're switching away from the 8k stacks people were used to having.
Design with 4k stacks from the start, and you'll see people writing
code with the assumption that they can't stick more than a handful
of ints/pointers on the stack.

If you design with 64k stacks then people _use_ that memory, and
soon you hear someone wanting 128k stacks to be "safe".  That
way you end up with windows.  Note that 64k is 16 pages, and they
have to be _consecutive_.  It don't take much fragmentation before
you can't get that many consecutive pages - you can easily have 3/4 of your
memory unused, ready to be taken, but still be unable to get 16 
consecutive pages.

To see this - create a small kernel module that tries to allocate 64k
of consecutive memory when loaded.  Try loading it after a few days
of normal use, and see how often your server fails to do it.

Helge Hafting
