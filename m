Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTHTRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTHTRC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:02:29 -0400
Received: from fmr09.intel.com ([192.52.57.35]:35537 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262064AbTHTRCE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:02:04 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][2/5]Support for HPET based timer
Date: Wed, 20 Aug 2003 10:01:53 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1D6@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][2/5]Support for HPET based timer
Thread-Index: AcNnCHCu9ngPWo70Q2ORc/h2Z0t5xgAMjVFQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, "Andi Kleen" <ak@suse.de>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Aug 2003 17:01:54.0023 (UTC) FILETIME=[C198EF70:01C3673C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes. I hadn't thought about early_ioremap option. There seems to be
multiple ways of doing early ioremap: bt_ioremap() and boot_ioremap(). I
will look at them closer and work on changing HPET code to use one of
these in place of fixmap.

Thanks,
-Venkatesh  

> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
> Sent: Wednesday, August 20, 2003 3:47 AM
> To: Andi Kleen
> Cc: Vojtech Pavlik; linux-kernel@vger.kernel.org; Pallipadi, Venkatesh
> Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
> 
> 
> Andi Kleen writes:
>  > Vojtech Pavlik <vojtech@suse.cz> writes:
>  > 
>  > > On Tue, Aug 19, 2003 at 05:18:50PM -0700, Pallipadi, 
> Venkatesh wrote:
>  > > 
>  > > > Fixmap is for HPET memory map address access. As the timer
>  > > > initialization happen 
>  > > > early in the boot sequence (before vm initialization), 
> we need to have
>  > > > fixmap() 
>  > > > and fix_to_virt() to access HPET memory map address.
>  > > 
>  > > Ahh, yes, you're right. You can't use ioremap at that 
> time. Actually I
>  > > did the same on x86_64 not only because of vsyscalls.
>  > 
>  > iirc i386 has an ioremap_early or somesuch.
> 
> bt_ioremap(). I wrote it to support early DMI scan so DMI data
> could be used to blacklist BIOSen that break local APICs.
> This was done pretty much just to handle Dell laptops.
> 
