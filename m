Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266716AbSKUPIh>; Thu, 21 Nov 2002 10:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSKUPIh>; Thu, 21 Nov 2002 10:08:37 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:19859 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266716AbSKUPIf>;
	Thu, 21 Nov 2002 10:08:35 -0500
Date: Thu, 21 Nov 2002 15:13:44 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: erich@uruk.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Athlon testers needed.
Message-ID: <20021121151344.GA12660@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, erich@uruk.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021120185311.GB10698@suse.de> <E18EbCB-0003Z9-00@trillium-hollow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18EbCB-0003Z9-00@trillium-hollow.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 12:11:35PM -0800, erich@uruk.org wrote:
 > In any case, here's the result from my recently acquired Athlon
 > XP 2600+:
 > 
 > 			31       23       15       7 
 > MSR: 0x0000002a=0x00000000 : 00000000 00000000 00000000 00000000
 > MSR: 0xc0000080=0x00000000 : 00000000 00000000 00000000 00000000
 > MSR: 0xc0010010=0x00160604 : 00000000 00010110 00000110 00000100
 > MSR: 0xc0010015=0x080b9008 : 00001000 00001011 10010000 00001000
 > MSR: 0xc001001b=0x6003d22f : 01100000 00000011 11010010 00101111
 > 
 > Family: 6 Model: 8 Stepping: 1
 > CPU Model : Athlon XP (Thoroughbred)[B0]

Bingo, this has the bug.

 > For comparison, here is the output from an Athlon XP 1800+:
 > 
 > 			31       23       15       7 
 > MSR: 0x0000002a=0x00000000 : 00000000 00000000 00000000 00000000
 > MSR: 0xc0000080=0x00000000 : 00000000 00000000 00000000 00000000
 > MSR: 0xc0010010=0x00168604 : 00000000 00010110 10000110 00000100
 > MSR: 0xc0010015=0x01001008 : 00000001 00000000 00010000 00001000
 > MSR: 0xc001001b=0x6003d22f : 01100000 00000011 11010010 00101111
 > 
 > Family: 6 Model: 6 Stepping: 2
 > CPU Model : Athlon MP (palomino)

This one is ok.
The bug is that c001001b are being programmed the same way.
They need different programming on newer models, which older
BIOSes are unaware of.

I'll cook up a patch and send a complete description after a quick
compile test. Thanks for the report.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
