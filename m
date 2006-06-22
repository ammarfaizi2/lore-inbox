Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWFVJ2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWFVJ2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWFVJ2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:28:23 -0400
Received: from fmr17.intel.com ([134.134.136.16]:10192 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161020AbWFVJ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:28:22 -0400
Message-ID: <449A629F.9000401@linux.intel.com>
Date: Thu, 22 Jun 2006 11:27:59 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Rajesh Shah <rajesh.shah@intel.com>
CC: Andi Kleen <ak@suse.de>, Brice Goglin <brice@myri.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because
 of e820
References: <44907A8E.1080308@myri.com> <4491029D.4060002@linux.intel.com> <20060621151942.A17228@unix-os.sc.intel.com> <200606220032.19388.ak@suse.de> <20060621171536.A17560@unix-os.sc.intel.com>
In-Reply-To: <20060621171536.A17560@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah wrote:
> On Thu, Jun 22, 2006 at 12:32:19AM +0200, Andi Kleen wrote:
>> On Thursday 22 June 2006 00:19, Rajesh Shah wrote:
>>> On Wed, Jun 14, 2006 at 11:47:57PM -0700, Arjan van de Ven wrote:
>>>>> We need to improve this "mmconfig disabled" anyhow. Having the extended
>>>>> config space unavailable on lots of machines is also far from a viable
>>>>> solution :)
>>>> it's unlikely to be many machines though.
>>>>
>>> I just noticed today - this check killed PCI Express on 3 of the 4
>>> machines I normally use for testing.
>> What do you mean with killed PCI Express? PCI Express should
>> work even without extended config space, except error handling.
>>
> Yes, I meant it killed extended config space. Note that we are
> about to send out code that enables PCI Express error handling,
> so this will become more visible now.
> 
>> You're saying that you have lots of machines where the mmconfig
>> aperture is not fully reserved in e820?
>>
> Yes, I saw this in 3 out of 4 systems I checked. I'll go check
> some more systems too.
> 
>> Is it partially reserved (not for all busses) or not at all?
>>
> The MMCFG resources are not listed at all in the BIOS provided
> memory map.
> 
>> If someone does a patch to double check it against the ACPI name space
>> I'm not opposed to let it overrule the e820 heuristic.
>>
>> The point of this code is to pragmatically detect BIOS with obviously 
>> broken setups. It's not about standards lawyering.
>>
> Oh I agree with you that booting is more important. My point with
> the spec statement was that most BIOS developers may not even know
> they are doing something "wrong" by not listing these resources in
> the int15 E820 table, since the document they normally refer to
> doesn't say so. I suspect there are many more systems out there
> which do the same thing and will fail the check, but we never notice
> since most users don't try to ever access the extended space today.

well... it's sort of common sense though.. if you want non-ACPI OSes to 
work properly (like the older 2.4 based distros...)


