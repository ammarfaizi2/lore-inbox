Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280752AbRKOG1b>; Thu, 15 Nov 2001 01:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280755AbRKOG1V>; Thu, 15 Nov 2001 01:27:21 -0500
Received: from cogent.ecohler.net ([216.135.202.106]:23960 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S280752AbRKOG1R>; Thu, 15 Nov 2001 01:27:17 -0500
Date: Thu, 15 Nov 2001 01:27:09 -0500
From: lists@sapience.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Subject: Re: Problem with i820 AGP patch
Message-ID: <20011115062709.GA2022@sapience.com>
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011114205141.A1065@renditai.milesteg.arr>
User-Agent: Mutt/1.3.23.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I have a similar problem with i860 - using 2.4.15-pre4.

  I get on a dell 530 dual p4 + radeon video:

Nov 14 00:31:40 flash kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Nov 14 00:31:40 flash kernel: agpgart: Maximum main memory to use 
                for agp memory: 816M
Nov 14 00:31:40 flash kernel: agpgart: Unsupported Intel chipset (device id: 2531), 
                you might want to try agp_try_unsupported=1.


   agp.h has 850 id as 2530 and 860 as 8532.

   My 860 claims 2531 ... ...

   Regards

   Gene/

lspci -v:
00:00.0 Host bridge: Intel Corporation 82850 860 (Wombat) Chipset Host Bridge (MCH) (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Flags: bus master, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: ff900000-ffafffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

00:02.0 PCI bridge: Intel Corporation 82860 860 (Wombat) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])

   etc.




On Wed, Nov 14, 2001 at 08:51:41PM +0100, Daniele Venzano wrote:
> Your patch to add AGP support for i820 chipset doesn't work for me, if I
> load agpgart module with agp_try_unsupported=1 I get:
> 
> -
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 262M
> agpgart: Trying generic Intel routines for device id: 2501
> 						^^^^^^^^^^^^^
> agpgart: AGP aperture is 256M @ 0xd0000000
> -
> 
> That device id is different from the corresponding line in apg.h:174
> #define PCI_DEVICE_ID_INTEL_820_0       0x2500
> 
> I tried to change that line in:
> #define PCI_DEVICE_ID_INTEL_820_0       0x2501
> 
> And it worked! But I don't know why the id for your chip is different
> from mine... 
> 
> My motherboard is an Asus P3C2000 with a P3 500 running kernel 2.4.14
> 
> 
