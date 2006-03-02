Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752009AbWCBQa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWCBQa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWCBQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:30:58 -0500
Received: from fmr21.intel.com ([143.183.121.13]:21192 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751095AbWCBQa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:30:58 -0500
Date: Thu, 2 Mar 2006 08:30:38 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302083038.A11407@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>; from len.brown@intel.com on Wed, Mar 01, 2006 at 09:49:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 09:49:53PM -0800, Brown, Len wrote:
> 
> >sysfs gets it right.
> >
> >(23:11:01:davej@nemesis:~)$ ls /sys/devices/system/cpu/
> >cpu0/  cpu1/
> >(23:11:07:davej@nemesis:~)$ ls /proc/acpi/processor/
> >CPU1/  CPU2/  CPU3/
> 
> This is because the BIOS has three "Processor" objects in the DSDT.
> 

I have a dual core + HT platform. I disabled HT to have the same situation
as Dave.

ACPI DSDT dump shows 4 objects in \_PR scope as below.

    Scope (\_PR)
    {
        Processor (CPU0, 0x01, 0x00000410, 0x06) {}
        Processor (CPU1, 0x02, 0x00000410, 0x06) {}
        Processor (CPU2, 0x03, 0x00000410, 0x06) {}
        Processor (CPU3, 0x04, 0x00000410, 0x06) {}
    }

Only 2 are marked enabled in the ACPI MADT..

>From boot log

ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)

But proc/acpi/processor also lists just 2 entries.

[root@araj-sfield-2 tmp]# ls /proc/acpi/processor/
CPU0  CPU2

I suspect that the BIOS is goofy and sending a valid acpiid when we try
to evaluate the processor object.

Could you see what comes out of the /proc/acpi/processor/CPUx/info for all the
3 listed in your system?

Also if you can send DSDT dump just to look over.

Cheers,
ashok
