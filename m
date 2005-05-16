Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVEPRrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVEPRrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVEPRrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:47:43 -0400
Received: from quark.didntduck.org ([69.55.226.66]:51641 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261460AbVEPRri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:47:38 -0400
Message-ID: <4288DCE7.9070508@didntduck.org>
Date: Mon, 16 May 2005 13:48:23 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Parpart <trapni@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: I'm having 4GB RAM, but Linux sees just 3GB???
References: <200505161604.10881.trapni@gentoo.org> <4288B1BC.5050207@didntduck.org> <200505161701.06558.trapni@gentoo.org>
In-Reply-To: <200505161701.06558.trapni@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Parpart wrote:
> On Monday 16 May 2005 4:44 pm, Brian Gerst wrote:
> 
>>Christian Parpart wrote:
>>
>>>Hi all,
>>>
>>>I was asking this in gentoo-server mailing list before, however, they
>>>finally pointed me to this place as it could also be a bug in the kernel.
>>>
>>>I'm having a TYAN board with two AMD Opteron 248 and 4x 1GB ECC RAM on
>>>it. The BIOS reflects what I've plugged in, however, the operating system
>>>does not.
>>>
>>>my `uname -a` output is:
>>>Linux battousai 2.6.11-gentoo-r8 #1 SMP Sat May 14 02:42:15 CEST 2005
>>>x86_64 AMD Opteron(tm) Processor 248 AuthenticAMD GNU/Linux
>>>
>>>and my `dmidecode` output is located at [0]. For ANY reason, dmidecode
>>>even knows about my 4GB RAM, but `free -m` nor `kinfocenter` of KDE
>>>claims to see just 3GB.
>>>
>>>free -m:
>>>             total       used       free     shared    buffers     cached
>>>Mem:          3015       2993         22          0         15       2638
>>>-/+ buffers/cache:        338       2677
>>>Swap:          511          1        510
>>>
>>>This is rather sad to see 1GB RAM plugged in for nothing.
>>>
>>>Has anyone a hint for my WHY this is happening and HOW I could get rid of
>>>it?
>>>
>>>Thanks in advance,
>>>Christian Parpart.
>>>
>>>[0] http://dev.gentoo.org/~trapni/dmidecode.txt
>>
>>Are you running a 64-bit kernel?  What does "dmesg | grep e820" show?
> 
> 
>  BIOS-e820: 0000000000000000 - 0000000000094800 (usable)
>  BIOS-e820: 0000000000094800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000bff20000 (usable)
>  BIOS-e820: 00000000bff20000 - 00000000bff2e000 (ACPI data)
>  BIOS-e820: 00000000bff2e000 - 00000000bff80000 (ACPI NVS)
>  BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
>  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 
> hmm... what does this mean?

It means that there is a hole at 00000000c0000000 - 0000000100000000 
(3GB-4GB) for PCI memory-mapped devices.  The 4th GB of RAM should be 
remapped by the BIOS to 4GB-5GB, but isn't.  Your BIOS is either buggy 
or misconfigured.

--
				Brian Gerst
