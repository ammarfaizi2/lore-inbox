Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSJYTrg>; Fri, 25 Oct 2002 15:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbSJYTrg>; Fri, 25 Oct 2002 15:47:36 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:12312 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261565AbSJYTrf>;
	Fri, 25 Oct 2002 15:47:35 -0400
Message-ID: <3DB9A163.1050306@acm.org>
Date: Fri, 25 Oct 2002 14:54:11 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog not ticking at the right intervals
References: <200210251802.UAA18166@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

>On Fri, 25 Oct 2002 09:09:10 -0500, Corey Minyard wrote:
>  
>
>>As I have been working on my NMI patch, I have noticed that the NMI 
>>watchdog does not seem to be ticking correctly.  I've tried 2.4 and 2.5 
>>kernels, and I get the same results.  From my reading of the code, it 
>>should tick once a second.  However, I have had the time between ticks 
>>vary from around 33 to over 100 seconds.  Tbe time between ticks is 
>>different on every boot, but is consistent once booted.  Is there some 
>>divider register that's not getting initialized?
>>
>>Here's my cpuinfo:
>>
>>processor    : 0
>>cpu_package    : 0
>>vendor_id    : GenuineIntel
>>cpu family    : 6
>>model        : 11
>>model name    : Intel(R) Pentium(R) III Mobile CPU      1066MHz
>>    
>>
>
>(Me thinks "speedstep?")
>
>Do you boot with nmi_watchdog=1 or 2?
>
It's set to 2 (local APIC).  Actually, when I set it to 1 (in 2.5) the 
code overrides it and sets it to 2.  But 2 is what it is running with now.

>The perfctr + local-APIC driven NMI watchdog is dependent
>on the CPU's clock frequency. If this changes, the NMI rate
>will change accordingly.
>
>The NMI rate may also be affected by APM/ACPI and how often
>the kernel executes HLT.
>
This board is not doing speed stepping.  It's running derated for 
reliability.

But that makes me think of something...

If I put a program into an infinite loop, then it will step every second 
like it is supposed to.  That makes sense now.

Thanks,

-Corey

