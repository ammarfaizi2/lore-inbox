Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbTH2QM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTH2QM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:12:57 -0400
Received: from fmr09.intel.com ([192.52.57.35]:47350 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261423AbTH2QMz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:12:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Date: Fri, 29 Aug 2003 09:12:52 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D222@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Thread-Index: AcNt32DxvpwbcwluQO+R+xvVgUyb4wAZqtIg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "David Mosberger-Tang" <David.Mosberger@acm.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Aug 2003 16:12:53.0088 (UTC) FILETIME=[66619E00:01C36E48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The part of the patch that does the HPET initialization for timer
interrupt, and general HPET registers read/write/programming can be
common across architectures.
However, different archs diverge, when it comes to gettimeofday-timer
implementation (tsc, pit, itc, hpet, ) and we may still have to keep
that part architecture specific. 

Thanks,
Venkatesh

> -----Original Message-----
> From: David Mosberger-Tang [mailto:David.Mosberger@acm.org] 
> Sent: Thursday, August 28, 2003 8:41 PM
> To: Pallipadi, Venkatesh
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCHSET][2.6-test4][0/6]Support for HPET based 
> timer - Take 2
> 
> 
> >>>>> On Fri, 29 Aug 2003 01:50:09 +0200, "Pallipadi, 
> Venkatesh" <venkatesh.pallipadi@intel.com> said:
> 
>   Venkatesh> Resending the patch. A major change from previous version
>   Venkatesh> is elimination of fixmap for HPET. Based on Andrew
>   Venkatesh> Morton's suggestion, we have a new hook in init/main.c
>   Venkatesh> for late_time_init(), at which time we can use ioremap,
>   Venkatesh> in place of fixmap.  Impact on other archs:
>   Venkatesh> Calibrate_delay() (and hence loops_per_jiffy calculation)
>   Venkatesh> has moved down in main.c, from after time_init() to after
>   Venkatesh> kmem_cache_init().
> 
>   Venkatesh> All comments/feedbacks welcome.
> 
> How much is really architecture-specific?  HPET isn't x86-only so
> sooner or later, we'll have to move it out of arch/i386 anyhow.
> 
> 	--david
> 
