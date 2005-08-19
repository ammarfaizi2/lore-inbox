Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVHSQWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVHSQWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVHSQWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:22:11 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:57093 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S964985AbVHSQWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:22:09 -0400
Message-ID: <43060731.10002@pantasys.com>
Date: Fri, 19 Aug 2005 09:22:09 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-git10 test report [x86_64](WITHOUT NVIDIA MODULE)
References: <1124401950.14825.13.camel@home-lap.suse.lists.linux.kernel>	 <p73u0hmsy83.fsf@verdi.suse.de> <1124405533.14825.24.camel@home-lap>	 <20050818230349.GC22993@wotan.suse.de> <1124410753.14825.32.camel@home-lap>	 <4305FCF1.6020905@pantasys.com> <20050819154639.GL22993@wotan.suse.de>	 <4306002F.4000000@pantasys.com> <20050819155332.GM22993@wotan.suse.de>	 <430601C5.5080505@pantasys.com> <1124467902.14825.41.camel@home-lap>
In-Reply-To: <1124467902.14825.41.camel@home-lap>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 16:21:54.0859 (UTC) FILETIME=[1D230FB0:01C5A4DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Bruno wrote:
> Well, there doesn't appear to be any reference to a setting in my BIOS
> for this size(IOMMU).  So I don't think that I can change it!  :(

well, it doesn't really matter since the kernel enables the IOMMU 
anyway. if you want to change the size you can pass that as a parameter 
on the command line.

> The machine is working quite a bit better with pci=noacpi in leu of
> disabling ACPI in the BIOS, but there are still those nasty errors in
> reference to the ACPI tables being broken:
>     ACPI-0362: *** Error: Looking up [\_SB_.PCI0.LNK0] in namespace,
> AE_NOT_FOUND
> search_node ffff8101428572c0 start_node ffff8101428572c0 return_node
> 0000000000000000

since it doesn't look like you'll get a bios fix for this you may want 
to look at building a custom dsdt. the kernel can load a custom dsdt 
from an initrd/initramfs. have a look at the acpi site (acpi.sf.net?). 
they talk about what's needed to do this. basically you can get your 
dsdt from /proc/acpi/dsdt and disassemble it using the iasl tools, fix 
it and then load it with an initrd. note that this is not really a 
trivial task :-(

> And this one about the 8254 timer:
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC

i've seen this before.. i think this may be related to the timer 
override not being done for your system (again strangely a bios bug...). 
why don't you try passing acpi_skip_timer_override on the command line.

> And finally, I think that something else kind of wierd is happening with
> the on-board sensors.  lm_sensors is having trouble detecting the fan
> speeds and temperatures of the main board, but I will take that up with
> their developers.

i think this may well be related to the ACPI issues you are having, 
since this is how the information is normally gathered.

peter
