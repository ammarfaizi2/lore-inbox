Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbTHUVe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbTHUVe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:34:27 -0400
Received: from fmr09.intel.com ([192.52.57.35]:21491 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262917AbTHUVeJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:34:09 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 'noapic' already handled elsewhere
Date: Thu, 21 Aug 2003 17:33:50 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCA7@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 'noapic' already handled elsewhere
Thread-Index: AcNoKtAPV+XdVBamTLSaP907sgaD2gAAES5g
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <torvalds@osdl.org>, "Grover, Andrew" <andrew.grover@intel.com>,
       <zwane@linuxpower.ca>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Aug 2003 21:33:52.0450 (UTC) FILETIME=[EA8D0A20:01C3682B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: config
Yes, I fixed this they way you suggested yesterday, both in 2.4 and 2.6.
The 2.4 tree is being tested, and the 2.6 patch is being buttoned up
now.


Thanks,
-Len

Ps   I sent a note on this to acpi-devel yesterday, but just got a
message from "Mail Delivery System [Mailer-Daemon@vasoftware.com]" that
my message has been waiting to go out for over 8 hours...


> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Thursday, August 21, 2003 5:11 PM
> To: Brown, Len
> Cc: torvalds@osdl.org; Grover, Andrew; zwane@linuxpower.ca; 
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 'noapic' already handled elsewhere
> 
> 
> Brown, Len wrote:
> > Jeff,
> > This won't work.
> > acpi_boot_init() is called from setup_arch(), which is called from
> > start_kernel() _before_ parse_options().  Ie. ACPI needs to 
> consume this
> > flag before __setup() is invoked.
> 
> 
> Thanks for the correction.  I'll resend the earlier 
> s/LOCAL_APIC/IO_APIC/ patch then.
> 
> Just found another ACPI bug in 2.6:
> 
> > config ACPI_HT
> >         bool "ACPI Processor Enumeration for HT"
> >         depends on (X86 && X86_LOCAL_APIC)
> >         default y
> [...]
> > config ACPI
> >         bool "Full ACPI Support"
> >         depends on !X86_VISWS
> >         depends on !IA64_HP_SIM
> >         depends on IA64 || (X86 && ACPI_HT)
> 
> 
> So CONFIG_ACPI is not allowed on uniprocessor anymore, _and_ 
> it requires 
> HyperThreading code?  ;-)  No wonder CONFIG_ACPI didn't appear for my 
> uniprocessor Pentium3 'make oldconfig'  ;-)
> 
> (ACPI requires ACPI_HT, which requires LOCAL_APIC)
> 
> Another reason why I was saying that CONFIG_ACPI should be 
> the toplevel 
> config option (even if CONFIG_ACPI never actually appears in 
> any code, 
> but only in Kconfig)...
> 
> 	Jeff
> 
> 
> 
> 
