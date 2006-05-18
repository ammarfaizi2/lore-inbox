Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWERQq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWERQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWERQq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:46:26 -0400
Received: from fmr19.intel.com ([134.134.136.18]:57783 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751375AbWERQqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:46:25 -0400
Message-ID: <446CA4D3.80105@linux.intel.com>
Date: Thu, 18 May 2006 09:46:11 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Konrad Rzeszutek <konradr@us.ibm.com>
CC: linux-kernel@vger.kernel.org, konradr@redhat.com
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
 e820 table.
References: <200605172153.35878.konradr@us.ibm.com> <446C70A8.5050909@linux.intel.com> <20060518155642.GC7617@andromeda.dapyr.net>
In-Reply-To: <20060518155642.GC7617@andromeda.dapyr.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Rzeszutek wrote:
>>> Also the ACPI spec v3.0 (pg 405 of PDF, section 14.2, titled:
>>> "E820 Assumptions and Limitations") agrees with this:
>>>
>>> "The BIOS does not return a range description for the memory mapping
>>> of PCI devices, ISA Option ROMs, and the ISA PNP cards because the OS
>>> has mechanisms available to detect them."
>> MCFG is none of these...
> 
> This is a bit of gray area. 

How? The segment you quoted basically says "no need to put any "MEM" resources
into E820 because the OS will know about those from its PCI scan".
And for an OS to map pci devices like cardbus or hotplug PCI anywhere, it obviously
needs to know about PCI so this is entirely a fair assumption.

MCFG is new. It's not traditional and it generally isn't a MEM region on any
PCI device. The result is that OSes that do not know about MCFG (like Windows XP)
do not at all know that there is something there already in the address space.
Neither the wording of the spec pieces you quoted nor common sense can lead to
a "but it doesn't have to be marked reserved" interpretation... the OS just has
to know what address space is free for mapping things into, via one way or another.


> If the MMCONFIG falls in that assumed memory mapped 256MB - then 
> the quote from section 14.2 can apply to that particular situation 
> "The BIOS does not return a range for the memory mapping of PCI devices ...";

yes this is the MEM BARs. Different animal.

> 
>>> If this is not a specification issue, I was wondering if perhaps for the 
>>> machines you refer to, their BIOS bug is that the E820 have memory ranges
>>> which also encompass what MMCONF points to?
>> no their bug is mostly that MCFG is garbage in those bioses. It points 
>> plain to
>> the wrong place. They even reserved the correct range, just pointed mcfg at 
>> the
>> wrong place.
>>
> 
> That is definitely a problem - and the "sanity-check" can definitly bail
> out on those BIOSes and not crash Linux. The other side of the coin is that 
> BIOSes that do implement the MCFG/E820 correctly are penalized:

I hereby contest that it's implemented correctly if it's not marked reserved...

> the 
> MMCONFIG capability on those machines is turned off when using Linux
> 2.6.17. 
> 
> Could you provide more details on the BIOS? Did the vendor released an updated BIOS? 

there were several, some I can't talk about.
Let me ask you a counter question: could you provide more details on the opposite case, and did the
vendor release an updated, fixed BIOS ?

