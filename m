Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbTCJIn1>; Mon, 10 Mar 2003 03:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbTCJInV>; Mon, 10 Mar 2003 03:43:21 -0500
Received: from rzserv1.gsi.de ([140.181.96.11]:40626 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id <S262749AbTCJIll>;
	Mon, 10 Mar 2003 03:41:41 -0500
Message-ID: <3E6C5234.8090505@GSI.de>
Date: Mon, 10 Mar 2003 09:52:04 +0100
From: ChristopherHuhn <c.huhn@gsi.de>
Organization: GSI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-de, en-us, fr-fr
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-smp <linux-smp@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Walter Schoen <w.schoen@GSI.de>, support-gsi@credativ.de
Subject: Re: Kernel Bug at spinlock.h ?!
References: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos> <3E637CDC.3030409@GSI.de> <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com> <3E64B0EA.4080109@GSI.de> <Pine.LNX.4.50.0303042133170.5867-100000@montezuma.mastecende.com> <3E674A13.5020203@GSI.de> <Pine.LNX.4.50.0303071043580.18716-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0303071043580.18716-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Thu, 6 Mar 2003, ChristopherHuhn wrote:
>
>  
>
>>Hi again,
>>
>>    
>>
>>>It looks like a possible race with rpc_execute and possibly the timer, 
>>>although i can't be certain where the other cpus are. Do the other oopses 
>>>look somewhat similar? Could you supply them?
>>> 
>>>
>>>      
>>>
>>below are some oopses I gathered yesterday and today, all on different 
>>machines.
>>I'd like to remark that we experience massive NFS problems at the moment 
>>that seem to be caused by our mixed potato 2.2/ woody 2.4 environment, 
>>i. e. linking apps on a woody system with the sources  mounted via nfs 
>>from a potato box leads to obscure IO failures like "no space left on 
>>device" (This never happens with woddy only). So this might be a clue 
>>here as well.
>>
>>The oopses are all written down from the screen, I hopefully made little 
>>"transmission" errors.
>>    
>>
>
>Some of these are a bit worrying seeing as they are bit flips, also they 
>all appear to come from a UP machine(?) this would change things with 
>respect to my previous comment about races. Regarding weird io failures 
>are you mounting with the 'soft' option?
>
>	Zwane
>  
>
The machines all all DP Xeons, our SP machines run the same kernel, but 
these oopses only occur on DP machines under heavy load.
The machines are recognized as SMP:
# uname -a
Linux lxb000 2.4.20 #2 SMP Tue Dec 17 10:43:29 CET 2002 i686 unknown

but the e7500 chipset seems not to be supported 100%:

Jan 27 15:26:34 lxb000 kernel: found SMP MP-table at 000f6710
Jan 27 15:26:34 lxb000 kernel: hm, page 000f6000 reserved twice.
Jan 27 15:26:34 lxb000 kernel: hm, page 000f7000 reserved twice.
Jan 27 15:26:34 lxb000 kernel: hm, page 0009f000 reserved twice.
Jan 27 15:26:34 lxb000 kernel: hm, page 000a0000 reserved twice.
Jan 27 15:26:34 lxb000 kernel: On node 0 totalpages: 262016
Jan 27 15:26:34 lxb000 kernel: zone(0): 4096 pages.
Jan 27 15:26:34 lxb000 kernel: zone(1): 225280 pages.
Jan 27 15:26:34 lxb000 kernel: zone(2): 32640 pages.
Jan 27 15:26:34 lxb000 kernel: ACPI: Searched entire block, no RSDP was 
found.
Jan 27 15:26:34 lxb000 kernel: ACPI: Searched entire block, no RSDP was 
found.
Jan 27 15:26:34 lxb000 kernel: ACPI: System description tables not found
Jan 27 15:26:34 lxb000 kernel: Intel MultiProcessor Specification v1.4
Jan 27 15:26:34 lxb000 kernel:     Virtual Wire compatibility mode.
Jan 27 15:26:34 lxb000 kernel: OEM ID:   Product ID: Kings Canyon APIC 
at: 0xFEE00000
Jan 27 15:26:34 lxb000 kernel: Processor #0 Pentium 4(tm) XEON(tm) APIC 
version 20
Jan 27 15:26:34 lxb000 kernel: Processor #6 Pentium 4(tm) XEON(tm) APIC 
version 20
Jan 27 15:26:34 lxb000 kernel: Processor #1 Pentium 4(tm) XEON(tm) APIC 
version 20
Jan 27 15:26:34 lxb000 kernel: Processor #7 Pentium 4(tm) XEON(tm) APIC 
version 20
Jan 27 15:26:34 lxb000 kernel: I/O APIC #2 Version 32 at 0xFEC00000.
Jan 27 15:26:34 lxb000 kernel: I/O APIC #3 Version 32 at 0xFEC80000.
Jan 27 15:26:34 lxb000 kernel: I/O APIC #4 Version 32 at 0xFEC80400.
Jan 27 15:26:34 lxb000 kernel: I/O APIC #5 Version 32 at 0xFEC81000.
Jan 27 15:26:34 lxb000 kernel: I/O APIC #8 Version 32 at 0xFEC81400.
Jan 27 15:26:34 lxb000 kernel: Processors: 4
...

There might be (are) severe flaws in our NFS configuration and network 
performance, but that should not crash the box, should it?

BTW: I just received a link to a bux incl. fix that sounds similar to 
our problem: http://marc.theaimsgroup.com/?l=linux-nfs&m=104716581307294&w=2

With kind regards,

Christopher


