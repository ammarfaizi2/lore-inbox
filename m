Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWGZNpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWGZNpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWGZNpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:45:10 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:24986
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750730AbWGZNpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:45:08 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "gmu 2k6" <gmu2006@gmail.com>
Subject: Re: hwrng on 82801EB/ER (ICH5/ICH5R) fails rngtest checks
Date: Wed, 26 Jul 2006 15:44:39 +0200
User-Agent: KMail/1.9.1
References: <20060725222209.0048ed15.akpm@osdl.org>
In-Reply-To: <20060725222209.0048ed15.akpm@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607261544.39532.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 July 2006 07:22, Andrew Morton wrote:
> with latest HEAD of Linus' tree I got /dev/hwrng but although the device
> exists rngtest does not pass as if hwrng does not work correctly.
> actually this case is documented in the README supplied by Debian
> but I'm surprised to hit the problem.
> 
> I'm just curious whether there's a bug in the driver, the hwrng is bad
> or if it is falsely detected and made accessible via /dev/hwrng.
> 
> rngtest 2-unofficial-mt.10
> Copyright (c) 2004 by Henrique de Moraes Holschuh
> This is free software; see the source for copying conditions.  There
> is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> PARTICULAR PURPOSE.
> 
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 200032
> rngtest: FIPS 140-2 successes: 0
> rngtest: FIPS 140-2 failures: 10
> rngtest: FIPS 140-2(2001-10-10) Monobit: 10
> rngtest: FIPS 140-2(2001-10-10) Poker: 10
> rngtest: FIPS 140-2(2001-10-10) Runs: 10
> rngtest: FIPS 140-2(2001-10-10) Long run: 10
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 10
> rngtest: input channel speed: (min=1.132; avg=2.157; max=2.794)Mibits/s
> rngtest: FIPS tests speed: (min=202.909; avg=206.647; max=211.928)Mibits/s
> rngtest: Program run time: 89804 microseconds
> 
> 
> lspci
> 00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
> 00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev
> 0c)
> 00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c)
> 00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Contr
> oller #1 (rev 02)
> 00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Contr
> oller #2 (rev 02)
> 00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Contr
> oller #3 (rev 02)
> 00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Contr
> oller #4 (rev 02)
> 00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Cont
> roller (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
> 00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Brid
> ge (rev 02)
> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller
> (rev 02)
> 01:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> 01:04.0 System peripheral: Compaq Computer Corporation Integrated Lights Out Con
> troller (rev 01)
> 01:04.2 System peripheral: Compaq Computer Corporation Integrated Lights Out  Pr
> ocessor (rev 01)
> 02:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 0
> 9)
> 02:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 0
> 9)
> 03:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethe
> rnet (rev 10)
> 03:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethe
> rnet (rev 10)
> 04:03.0 RAID bus controller: Compaq Computer Corporation Smart Array 64xx (rev 0
> 1)
> 05:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A (rev 0
> 9)
> 05:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B (rev 0
> 9)
> 0a:01.0 PCI bridge: IBM PCI-X to PCI-X Bridge (rev 03)
> 0b:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 64xx (rev 0
> 1)


I guess you are running the Intel ICH RNG, right?
As the FIPS test is a hardware test, I would simply say it's
failing hardware. But let's not do this. :) Let's check what
actually comes out of the RNG.
Could you do a
hexdump /dev/hwrng
So we can see what actually comes ot of the device. Let's see
if it's all zeros or something.

Does the RNG work, if you use 2.6.17 or earlier?

-- 
Greetings Michael.
