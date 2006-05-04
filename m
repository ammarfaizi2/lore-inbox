Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWEDQOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWEDQOk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEDQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:14:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:13708 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932346AbWEDQOj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:14:39 -0400
X-IronPort-AV: i="4.05,89,1146466800"; 
   d="scan'208"; a="32395270:sNHT5681018357"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Fix CONFIG_PRINTK_TIME hangs on some systems
Date: Thu, 4 May 2006 09:14:06 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0667FF31@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix CONFIG_PRINTK_TIME hangs on some systems
Thread-Index: AcZvZO3TZzGKOZtKSKOZbtNxHNcrOgALzIfQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Tony Lindgren" <tony@atomide.com>, <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Nick Piggin" <nickpiggin@yahoo.com.au>
X-OriginalArrivalTime: 04 May 2006 16:14:07.0156 (UTC) FILETIME=[C4F0BF40:01C66F95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This issue has been discussed earlier on LKML, but AFAIK
> there has not been any better solution available:
> 
> http://lkml.org/lkml/2005/8/18/173

I thought that this had been fixed:

ia64 now has a "printk_clock()" defined in arch/ia64/kernel/time.c
which overrides the "weak" symbol defined in kernel/printk.c.  This
calls ia64_printk_clock() ... which defaults to a jiffie based
routine, but might be an ITC based routine if running on a system
where the clocks do not drift on different cpus.  Platform code
can also override this function pointer (which SGI does in their
sn_setup() routine).

The ITC based routine still uses sched_clock(), but tries to avoid
the original problems by not calling sched_clock() until the MMU
has been set up to map the per-cpu areas (checks whether one of the
AR.K registers has been set).  Most of this in commit:

  http://tinyurl.com/ltexa


Do you still see a problem on some platform?

-Tony
