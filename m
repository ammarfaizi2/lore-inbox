Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280762AbRKOHKY>; Thu, 15 Nov 2001 02:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRKOHKP>; Thu, 15 Nov 2001 02:10:15 -0500
Received: from sm14.texas.rr.com ([24.93.35.41]:53656 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S280762AbRKOHKG>;
	Thu, 15 Nov 2001 02:10:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: lists@sapience.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with i820 AGP patch
Date: Thu, 15 Nov 2001 01:14:32 -0600
X-Mailer: KMail [version 1.2]
Cc: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr> <20011115062709.GA2022@sapience.com>
In-Reply-To: <20011115062709.GA2022@sapience.com>
MIME-Version: 1.0
Message-Id: <01111501143205.00746@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this too with Tyan Thunder i860. Adding a new entry to agp.h, eg.

#ifndef PCI_DEVICE_ID_INTEL_860_DP_0
#define PCI_DEVICE_ID_INTEL_860_DP_0     0x2531
#endif

along with appropriate modifcations to agpgart_be.c:

	{ PCI_DEVICE_ID_INTEL_860_DP_0,
	        PCI_VENDOR_ID_INTEL,
	        INTEL_I860,
	        "Intel",
	        "i860",
	        intel_860_setup },

seems to work ok for me. On the other hand, the performance is pretty much 
the same as "agp_try_unsupported=1" :-). How does your /proc/interrupts look?

-- 
Marvin Justice
Software Developer
BOXX Technologies, Inc.
www.boxxtech.com
512-235-6318 (V)
512-835-0434 (F)

On Thursday 15 November 2001 12:27 am, lists@sapience.com wrote:
>   I have a similar problem with i860 - using 2.4.15-pre4.
>
>   I get on a dell 530 dual p4 + radeon video:
>
> Nov 14 00:31:40 flash kernel: Linux agpgart interface v0.99 (c) Jeff
> Hartmann Nov 14 00:31:40 flash kernel: agpgart: Maximum main memory to use
>                 for agp memory: 816M
> Nov 14 00:31:40 flash kernel: agpgart: Unsupported Intel chipset (device
> id: 2531), you might want to try agp_try_unsupported=1.
>
>
>    agp.h has 850 id as 2530 and 860 as 8532.
>
>    My 860 claims 2531 ... ...
>
>    Regards
>
>    Gene/
>
> lspci -v:
> 00:00.0 Host bridge: Intel Corporation 82850 860 (Wombat) Chipset Host
> Bridge (MCH) (rev 04) Subsystem: Dell Computer Corporation: Unknown device
> 00d8
>         Flags: bus master, fast devsel, latency 0
>         Memory at e8000000 (32-bit, prefetchable) [size=128M]
>         Capabilities: [a0] AGP version 2.0
>
> 00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge
> (rev 04) (prog-if 00 [Normal decode]) Flags: bus master, 66Mhz, fast
> devsel, latency 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         I/O behind bridge: 0000e000-0000efff
>         Memory behind bridge: ff900000-ffafffff
>         Prefetchable memory behind bridge: f0000000-f7ffffff
>
> 00:02.0 PCI bridge: Intel Corporation 82860 860 (Wombat) Chipset AGP Bridge
> (rev 04) (prog-if 00 [Normal decode])
>
>    etc.
>
> On Wed, Nov 14, 2001 at 08:51:41PM +0100, Daniele Venzano wrote:
> > Your patch to add AGP support for i820 chipset doesn't work for me, if I
> > load agpgart module with agp_try_unsupported=1 I get:
> >
> > -
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 262M
> > agpgart: Trying generic Intel routines for device id: 2501
> > 						^^^^^^^^^^^^^
> > agpgart: AGP aperture is 256M @ 0xd0000000
> > -
> >
> > That device id is different from the corresponding line in apg.h:174
> > #define PCI_DEVICE_ID_INTEL_820_0       0x2500
> >
> > I tried to change that line in:
> > #define PCI_DEVICE_ID_INTEL_820_0       0x2501
> >
> > And it worked! But I don't know why the id for your chip is different
> > from mine...
> >
> > My motherboard is an Asus P3C2000 with a P3 500 running kernel 2.4.14
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

