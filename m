Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTENUa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbTENUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:30:29 -0400
Received: from fmr02.intel.com ([192.55.52.25]:63983 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261222AbTENUa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:30:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
Date: Wed, 14 May 2003 13:43:15 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56401E451DE@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC Proposal to enable MSI support in Linux kernel
Thread-Index: AcMaU+U543/3MAAzSeqap8RlnFTsuwAAzqhw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
X-OriginalArrivalTime: 14 May 2003 20:43:15.0486 (UTC) FILETIME=[717BDBE0:01C31A59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ISA devices typically use hard-coded IRQs (< 16), and the drivers for those also assume such IRQs. You can break the driver if you provide the vector number instead of the IRQ for them. Unfortunately, vectors <16 are used for the processor, and thus not available. Good news is that vectors assigned to I/O are equal to or higher than FIRST_DEVICE_VECTOR (> 16), so there are no conflicts between the IRQ and vector space, i.e. you don't need to check if it's vector or IRQ at do_IRQ() time, for example.

Non legacy drivers are all drivers but such legacy drivers. Included are PCI, USB drivers, etc.

Thanks,
Jun


> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Wednesday, May 14, 2003 12:54 PM
> To: Nakajima, Jun
> Cc: Nguyen, Tom L; linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick,
> Asit K; Carbonari, Steven
> Subject: RE: RFC Proposal to enable MSI support in Linux kernel
> 
> On Wed, 14 May 2003, Nakajima, Jun wrote:
> 
> > That's a good idea, and that's the way we did this (we added MSI
> > support on top of the vector-based indexing). If people are interested
> in
> > the vector-based indexing (i.e. provide the vector number to device
> > drivers (non-legacy drivers only) instead of IRQ) for some other uses,
> we
> > would like to discuss possible cleaner implementations.
> >
> > Long will post a patch containing the vector-based indexing part only.
> 
> Thanks! It'd be a lot easier to test the core changes too. What do you
> mean by non legacy?
> 
> 	Zwane
> --
> function.linuxpower.ca
