Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTIEUlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTIEUlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:41:22 -0400
Received: from fmr09.intel.com ([192.52.57.35]:60120 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262881AbTIEUlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:41:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] idle using PNI monitor/mwait (take 2)
Date: Fri, 5 Sep 2003 13:41:07 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF0D@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] idle using PNI monitor/mwait (take 2)
Thread-Index: AcNz1WPx/s5HCVrCSCOIOaM5jCRGWgABNj+g
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 05 Sep 2003 20:41:08.0742 (UTC) FILETIME=[0907C260:01C373EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are doing this as defensive programming (because of bogus device
drivers, for example), like the other idle routines (default_idle, and
poll_idle) always do. 

BTW, I'm not sure that local_irq_disable() is really required below (as
you know, "sti" is hiding in safe_halt()).

void default_idle(void)
{
	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
=>		local_irq_disable();
		if (!need_resched())
			safe_halt();
		else
			local_irq_enable();
	}
}

Thanks,
Jun


> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Friday, September 05, 2003 10:14 AM
> To: Nakajima, Jun
> Cc: linux-kernel@vger.kernel.org; Saxena, Sunil; Mallick, Asit K;
> Pallipadi, Venkatesh
> Subject: Re: [PATCH] idle using PNI monitor/mwait (take 2)
> 
> "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> >
> > Attached is a patch that enables PNI (Prescott New Instructions)
> > monitor/mwait in the kernel idle.
> 
> Thanks, looks good.
> 
> Why is there a local_irq_enable() on entry to mwait_idle()?

