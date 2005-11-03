Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbVKCXwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbVKCXwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbVKCXwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:52:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:36871 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030547AbVKCXwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:52:08 -0500
Message-ID: <436AA1FD.3010401@vmware.com>
Date: Thu, 03 Nov 2005 15:49:17 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl> <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2005 23:49:10.0093 (UTC) FILETIME=[2F93CFD0:01C5E0D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>On Thu, 3 Nov 2005, Zachary Amsden wrote:
>
>  
>
>>>disables code to retrieve the actual value of CR4 on 486-class systems
>>>(which may or may not implement the register, depending on the exact CPU
>>>type and stepping).  This seems suspicious to me, but I have to admit I
>>>haven't followed the discussion on the issue if there was any.
>>> 
>>>
>>>      
>>>
>>This was deliberate.  CR4 doesn't exist on standard 486 class systems, 
>>and I'm not sure how you could make use of it anyway, since the features 
>>used by Linux - machine check, page size extensions, time stamp counter, 
>>global pages, are only available in Pentium and later class systems, and 
>>identified by CPUID, which also doesn't exist on 486.
>>    
>>
>
> Later Intel i486DX2 and i486DX4 processors (the so called "write-back
>enhanced" ones) did support page size extensions (4MB pages) and as far as
>I know we do use them on such chips.  They did implement the CPUID
>instruction, too (as well as late i486SX and i486SX2 chips that did not
>support PSE).  That's a counter-example that proves the actual value of
>CR4 is going to be useful on these systems.  These chips also implemented
>the VME feature (the PVI and VME bits of CR4), but they may not be
>terribly useful for us.
>
> I used quite a few of such chips myself in mid 90s -- you may search
>archives of various mailing lists for examples of "cpuinfo" dumps for such
>processors.
>

Finally got the relevant information from Intel. The embedded i486DX-2/4 
series does support CPUID, and PSE, and thus CR4. Ugh. Also just found 
this guy:

$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 4
model           : 7
model name      : 486 DX/2-WB
stepping        : 0
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme pse
bogomips        : 32.25


He won't like me too much. I'll write up a proper patch for this, a la 
mode de rdmsr_safe / wrmsr_safe. At least it's not a bug, just missing 
information.

Zach
