Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbTHURMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTHURMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:12:09 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:31975 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262800AbTHURKU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:10:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 'noapic' already handled elsewhere
Date: Thu, 21 Aug 2003 13:09:54 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCA0@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 'noapic' already handled elsewhere
Thread-Index: AcNoA+kErlP0Fp5iTDWaX2gUUoEbogAAazbA
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, <torvalds@osdl.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, <zwane@linuxpower.ca>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Aug 2003 17:09:55.0716 (UTC) FILETIME=[0B1F3440:01C36807]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,
This won't work.
acpi_boot_init() is called from setup_arch(), which is called from
start_kernel() _before_ parse_options().  Ie. ACPI needs to consume this
flag before __setup() is invoked.

-Len

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Thursday, August 21, 2003 12:15 PM
> To: torvalds@osdl.org
> Cc: Brown, Len; Grover, Andrew; zwane@linuxpower.ca; 
> linux-kernel@vger.kernel.org
> Subject: [PATCH] 'noapic' already handled elsewhere
> 
> 
> I sent a previous patch to s/LOCAL_APIC/IO_APIC/, as Zwane noticed
> my first patch needed that.  In that patch, I commented __setup()
> would be better.
> 
> Well... line 718 of arch/i386/kernel/io_apic.c _already_ handles this
> case, using __setup() properly.
> 
> Word of warning... patch only compile tested, but seems obvious from
> looking at io_apic.c.
> 
> BTW, why isn't ACPI using __setup() as well?  I don't see that ACPI
> needs to patch arch/i386/kernel/setup.c at all.
> 
> 
> ===== arch/i386/kernel/setup.c 1.94 vs edited =====
> --- 1.94/arch/i386/kernel/setup.c	Thu Aug 21 01:32:04 2003
> +++ edited/arch/i386/kernel/setup.c	Thu Aug 21 12:09:13 2003
> @@ -544,12 +544,6 @@
>  			if (!acpi_force) acpi_disabled = 1;
>  		}
>  
> -#ifdef CONFIG_X86_LOCAL_APIC
> -		/* disable IO-APIC */
> -		else if (!memcmp(from, "noapic", 6)) {
> -			skip_ioapic_setup = 1;
> -		}
> -#endif /* CONFIG_X86_LOCAL_APIC */
>  #endif /* CONFIG_ACPI_BOOT */
>  
>  		/*
> 
