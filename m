Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTHZXvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbTHZXvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:51:10 -0400
Received: from fmr09.intel.com ([192.52.57.35]:19416 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262971AbTHZXvH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:51:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][2/5]Support for HPET based timer
Date: Tue, 26 Aug 2003 16:50:59 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1F9@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][2/5]Support for HPET based timer
Thread-Index: AcNsKjH9V5kc6qmsRMGYcCxS4EG9uQAAKQ6Q
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "john stultz" <johnstul@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <vojtech@suse.cz>, "Andi Kleen" <ak@suse.de>,
       "Dave H" <haveblue@us.ibm.com>, <mikpe@csd.uu.se>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Aug 2003 23:50:59.0608 (UTC) FILETIME=[E6627980:01C36C2C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: john stultz [mailto:johnstul@us.ibm.com] 
> 
> Well, the difficult part is deciding in time_init() if we are going to
> use HPET without touching the hardware (to say, check if its actually
> there).
> 

Yes. But, currently we are using ACPI early table parse to look at HPET.
So we should be OK here.
Even if accessing HPET hardware fails later, in the late_time_init(), 
we can fallback to PIT, as long as calibrate_delay() is done after 
late_time_init().

> We could pick a simple time source (ie: PIT) that would get us through
> early boot, then choose the real time source in late_time_init(). That
> would also make implementing the ACPI PM time-source much simpler as
we
> could wait until after ACPI is up, letting us avoid having to parse
the
> tables by hand.
> 
> However I'm not sure it would be trivial and bug free. ;)
> 

Depending on multiple time sources may not be good idea, IMO. May be, 
one day we will have a fully-legacy-free system with no PIT. :)

Thanks,
-Venkatesh
