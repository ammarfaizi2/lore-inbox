Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTHUU4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbTHUU4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:56:38 -0400
Received: from fmr09.intel.com ([192.52.57.35]:8140 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262888AbTHUU4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:56:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][5/5]Support for HPET based timer
Date: Thu, 21 Aug 2003 13:56:32 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1DF@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][5/5]Support for HPET based timer
Thread-Index: AcNnwf2rqcojdBWfQXipgbK5SLhQSQAYcAbQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 21 Aug 2003 20:56:33.0044 (UTC) FILETIME=[B3C2CD40:01C36826]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> -----Original Message-----
> From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
> Indeed. The main problem, however, for me was to decide which 
> IRQ to use
> for the HPET. The HPET has a big mask of allowable IRQs, the APIC has
> many pins - so how to decide which one to use and if possible 
> not share
> it with a PCI device?

This possibly can be done by selecting the pin that is not already
programmed by 
setup_IO_APIC_irqs(), and do a manual setup_IO_APIC_irqs() on that, for
HPET
usage.

> That'd work probably. I don't believe there will ever be systems with
> HPET and without a working IOAPIC. But, well, insane things do happen.
> 
> As for the user disabling it, we could disable HPET then, 
> too. Anyway, I
> agree with your proposal of first going for legacy mode and 
> doing native
> mode later. 

Thanks for all the comments/suggestions. I will work on using early
ioremap in 
place of fixmap and resend the patch.

> (PS. It's a pretty stupid thing in the HPET spec to only be able to
>  gobble up BOTH the PIT and RTC interrupts and not separately.)

I totally agree with you. Just one additional bit would have solved the 
these problems. Also, I do not understand why RTC interrupts were
overridden 
at all, when HPET cannot provide complete RTC functionality and it does
not 
know anything about RTC time.


Thanks,
-Venkatesh



> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 
