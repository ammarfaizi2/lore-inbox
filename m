Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbTHTEnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 00:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTHTEnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 00:43:22 -0400
Received: from fmr01.intel.com ([192.55.52.18]:54681 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S261701AbTHTEnU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 00:43:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][5/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 18:28:40 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CE@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][5/5]Support for HPET based timer
Thread-Index: AcNmowFrgR0gdHE3Tt6Pb9Nj02Z6ogADcn8g
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 20 Aug 2003 01:28:40.0633 (UTC) FILETIME=[62EFAA90:01C366BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I experimented with HPET in native APIC routing mode. But, there 
are couple of issues in that space:

1) During boot up kernel expects to receive timer interrupt much before
the 
IO-APIC initialization is done. If HPET uses native mode, it cannot
generate 
timer interrupts till IOAPICs are initialized. So, we need to have some
sort of 
Workarounds in generic kernel to avoid dependency on timer interrupt
during the 
early boot.

2) More important question is, do we really want to share timer
interrupt with 
other PCI devices? This potentially can add some delay in the timer
interrupt 
processing, and thus we may end up getting inaccurate time (and
inaccurate 
timer interrupts) in the kernel.

Thanks,
-Venkatesh
> -----Original Message-----
> From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
> Sent: Tuesday, August 19, 2003 3:41 PM
> To: Pallipadi, Venkatesh
> Cc: linux-kernel@vger.kernel.org; torvalds@osdl.org; 
> Nakajima, Jun; Mallick, Asit K
> Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
> 
> 
> On Tue, Aug 19, 2003 at 12:20:22PM -0700, Pallipadi, Venkatesh wrote:
> 
> > 5/5 - hpet5.patch - This can be a standalone patch. Without this
> >                     patch we loose interrupt generation capability
> >                     of RTC (/dev/rtc), due to HPET. With this patch
> >                     we basically try to emulate RTC interrupt
> >                     functions in software using HPET counter 1.
> > 
> 
> This is very wrong IMO. We shouldn't try to emulate the RTC interrupt
> for the kernel, instead the HPET should use native APIC interrupt
> routing. This way the RTC will keep working and the 'legacy mode' of
> HPET doesn't need to be used. I must admit I was a bit lazy when I was
> implementing the x86_64 variant and the native IRQ for HPET 
> is still on
> my to-do list.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 
