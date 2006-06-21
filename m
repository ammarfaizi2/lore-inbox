Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWFUCWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWFUCWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWFUCWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:22:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14240 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751272AbWFUCWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:22:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 11/25] i386 irq:  Dynamic irq support
References: <11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<1150842520235-git-send-email-ebiederm@xmission.com>
	<11508425201406-git-send-email-ebiederm@xmission.com>
	<1150842520775-git-send-email-ebiederm@xmission.com>
	<11508425213394-git-send-email-ebiederm@xmission.com>
	<115084252131-git-send-email-ebiederm@xmission.com>
	<11508425213795-git-send-email-ebiederm@xmission.com>
	<11508425222427-git-send-email-ebiederm@xmission.com>
	<20060620185015.F10402@unix-os.sc.intel.com>
Date: Tue, 20 Jun 2006 20:21:00 -0600
In-Reply-To: <20060620185015.F10402@unix-os.sc.intel.com> (Rajesh Shah's
	message of "Tue, 20 Jun 2006 18:50:16 -0700")
Message-ID: <m1mzc79rlf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah <rajesh.shah@intel.com> writes:

> On Tue, Jun 20, 2006 at 04:28:24PM -0600, Eric W. Biederman wrote:
>> The current implementation of create_irq() is a hack but it is the
>> current hack that msi.c uses, and unfortunately the ``generic'' apic
>> msi ops depend on this hack.  Thus we are stuck this hack of assuming
>> irq == vector until the depencencies in the generic msi code are removed.
>> 
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>> arch/i386/kernel/io_apic.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 48 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
>> index 16966f4..04f78ff 100644
>> --- a/arch/i386/kernel/io_apic.c
>> +++ b/arch/i386/kernel/io_apic.c
>> @@ -2497,6 +2497,54 @@ static int __init ioapic_init_sysfs(void
>>  
>>  device_initcall(ioapic_init_sysfs);
>>  
>> +#ifdef CONFIG_PCI_MSI
>> +/*
>
> It would be really good to decouple MSI implementation from IO
> APICs, since there's really no real hardware dependence here.
> This code can actually go to arch/xxx/pci/msi-apic.c

I agree in theory.  In practice however msi interrupts look like io_apics.
with a different register set and the use all of the same support facilities.
So until that part of the architecture is refactored it doesn't make much
sense.  There is a slightly better case for moving the code into a separate
file.  Namely I think I know of a second common implementation for x86_64.
At which point the files will probably be named msi-intel.c and msi-amd.c
Or something like that.  

The name msi-apic.c is at least as bad as putting the code in io_apic.c


Eric

