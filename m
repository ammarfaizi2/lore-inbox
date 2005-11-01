Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVKAHmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVKAHmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 02:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVKAHmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 02:42:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15574 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932555AbVKAHmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 02:42:54 -0500
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: <vgoyal@in.ibm.com>, "Andrew Morton" <akpm@osdl.org>, <fastboot@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04E00@USRV-EXCH4.na.uis.unisys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 01 Nov 2005 00:41:57 -0700
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04E00@USRV-EXCH4.na.uis.unisys.com> (Natalie
 Protasevich's message of "Mon, 31 Oct 2005 12:31:56 -0600")
Message-ID: <m1k6fs95mi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> writes:

>> The first cpu is brought online much earlier than the rest.  
>> So we just need to setup a table for boot cpu earlier.  From 
>> the looks of it mach-es700 won't work if you compile a 
>> uniprocessor kernel for it right now.
>
> Yea, I didn't even try this - but I think it will produce the same
> result with regard to timer IOAPIC rte.
>
>> We need to do this a little later than in mptable but this 
>> should be a fairly simple one or two line change.
>
> Yes, it is maybe something like running map_cpu_to_logical_apicid() from
> APIC_init() just before the setup_IO_APIC().

The core piece of the puzzle is cpu_mask_to_apicid().  At the
time we setup the io_apic TARGET_CPUS will just be the bootstrap
processor.    So we might be able to get away with hard coding
the bootstrap processor in the non-SMP sections of the ioapic
startup code.

setup_ioapic_dest is going to fix things after we start the
cpus anyway so it should not be a problem.

Does that sound like a sane thing to do?

This code appears to affect all of the subarchitectures but the
default x86 one.  So it is clearly not just an ES7000 problem.

Now to figure out why Linus's laptop hates this patch...

Eric

