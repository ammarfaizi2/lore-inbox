Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTJURmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbTJURmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:42:00 -0400
Received: from fmr06.intel.com ([134.134.136.7]:54407 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263197AbTJURl5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:41:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPIP-state driver
Date: Tue, 21 Oct 2003 10:41:30 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007791B@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPIP-state driver
Thread-Index: AcOXrsiFyT62vLzZS4OIa/kIUEWklQASSUlg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <arjanv@redhat.com>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Dominik Brodowski" <linux@brodo.de>
X-OriginalArrivalTime: 21 Oct 2003 17:41:31.0993 (UTC) FILETIME=[9096DC90:01C397FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We can have a userspace governor and take decisions using
top, /proc/interrupts etc. But issue is mostly the rate
at which we want to monitor. In kernel governor can afford
to do more frequent checks and use the low latency P-state 
change feature quite effectively.

The patch does take care of all kinds of loads, process or irq
as we look at the cpu idle time in kstat. However it waits until
scheduled work (schedule_work()) gets to run. As you say, 
another advantage of having this in kernel is, kernel has 
all the information to take such decisions quickly. At present,
The patch tries to keep this governor simple and cover the 
common cases. However, once we have the infrastructure in place,
further optimizations with more advanced things can be done 
based on actual performance data.

Thanks,
-Venkatesh

> -----Original Message-----
> From: Arjan van de Ven [mailto:arjanv@redhat.com] 
> Sent: Tuesday, October 21, 2003 1:39 AM
> To: Pallipadi, Venkatesh
> Cc: cpufreq@www.linux.org.uk; linux-kernel@vger.kernel.org; 
> linux-acpi; Mallick, Asit K; Nakajima, Jun; Dominik Brodowski
> Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates 
> to ACPIP-state driver
> 
> 
> On Tue, 2003-10-21 at 04:56, Pallipadi, Venkatesh wrote:
> > Patch 3/3: New dynamic cpufreq driver (called 
> > DemandBasedSwitch driver), which periodically monitors CPU 
> > usage and changes the CPU frequency based on the demand.
> 
> 
> it's all nice code and such, but I still wonder why this can't be done
> by a userland policy daemon. The 2.6 kernel has the infrastructure to
> give very detailed information to userspace (eg top etc) about idle
> percentages...... I didn't see anything in this driver that 
> couldn't be
> done from userspace.
> 
> Note that I'm not totally against doing some of this in the kernel; I
> can well see the point of say, detecting an IRQ overload and based on
> that, go to max speed in the kernel because it's a situation where
> userspace doesn't even run; but the patch as is doesn't do any such
> advanced things...
> 
