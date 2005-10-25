Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbVJYHR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbVJYHR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 03:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVJYHR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 03:17:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15071 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751478AbVJYHR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 03:17:27 -0400
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<20051021133306.GC3799@in.ibm.com>
	<m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
	<20051022145207.GA4501@in.ibm.com>
	<m11x2deft5.fsf@ebiederm.dsl.xmission.com>
	<20051024130311.GA5853@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 25 Oct 2005 01:17:03 -0600
In-Reply-To: <20051024130311.GA5853@in.ibm.com> (Vivek Goyal's message of
 "Mon, 24 Oct 2005 18:33:11 +0530")
Message-ID: <m1mzkycbgw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:
> I have attached a patch with the mail which is now using
> boot_cpu_physical_apicid to hard set presence of boot cpu instead of
> hard_smp_processor_id(). But the interesting questoin remains why BIOS is
> not reporting the boot cpu.


Ok.  I don't know if we care but I do know why we were not seeing
the report from the bios about your boot processor.  We record
information about cpus for up to NR_CPUS, and since you had
a UP kernel NR_CPUS was one.

>From your earlier boot log.

> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
> Processor #3 6:10 APIC version 17
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 6:10 APIC version 17
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> Processor #1 6:10 APIC version 17
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.
> ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
> Processor #2 6:10 APIC version 17
> WARNING: NR_CPUS limit of 1 reached.  Processor ignored.

So it looks like we have this problem completely fixed.  

I don't see a good way to ensure that we always record our boot
apicid when we boot a multiple processor system and only use one
processor.

Eric



