Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWCUJLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWCUJLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWCUJLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:11:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:50441 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751227AbWCUJLs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:11:48 -0500
X-IronPort-AV: i="4.03,113,1141632000"; 
   d="scan'208"; a="14270549:sNHT45378277"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 21 Mar 2006 17:11:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B417863@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZMxEo5N5/po3v4SQKdu12duTJuKAAAWAwQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 21 Mar 2006 09:11:31.0186 (UTC) FILETIME=[716DC520:01C64CC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>With _TMP faked in the kernel and one whole zone ignored, this 
>is what I
>get:
>
>Zone to ignore	|	Result
>---------------------------------------------------------------
>---------
>THM0			OK (10 cycles)
>THM2			"kernel panic! attempted to kill init"

I guess, if you fake DSDT by completely removing THM2
you won't see this.

>THM6			Hangs (4th cycle)
Is it still hang at SMPI?

>THM7			OK (8 cycles)
>
>So THM6 seems healthy, but THM0 and THM7 (and maybe THM2) interact
>badly.  If I unload THM2, THM6, and THM7, then it's okay (previous
>experiments with faking _TMP but with only THM0 loaded).  But unloading
>THM6 is not enough.

Please try to remove THM2 judge if it is JUST the 
problem of THM0 && THM7.

>
>The kernel panic for the don't-load-THM2 kernel is very strange.  I had
>another kernel panic while doing another set of tests, which I also
>couldn't explain.  The only difference between the no-THM0 and the
>no-THM2 kernels is:

Could you just printk device->pnp? it could be null point (due to 
you hack?)

>
>diff -r b7ad6c906aba -r 213308f0ec31 drivers/acpi/thermal.c
>--- a/drivers/acpi/thermal.c	Tue Mar 21 02:23:30 2006 -0500
>+++ b/drivers/acpi/thermal.c	Tue Mar 21 02:36:42 2006 -0500
>@@ -1324,7 +1324,7 @@ static int acpi_thermal_add(struct acpi_
> 
> 	if (!device)
> 		return_VALUE(-EINVAL);
>-	if (strcmp("THM2", device->pnp.bus_id) == 0) {
>+	if (strcmp("THM0", device->pnp.bus_id) == 0) {
> 	    printk(KERN_INFO PREFIX "thermal_add: ignoring %s\n",
> 		   device->pnp.bus_id);
> 	    return_VALUE(-EINVAL);
>
>
