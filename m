Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbTA2QIi>; Wed, 29 Jan 2003 11:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbTA2QIi>; Wed, 29 Jan 2003 11:08:38 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29891 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266286AbTA2QIg>;
	Wed, 29 Jan 2003 11:08:36 -0500
Date: Wed, 29 Jan 2003 16:14:46 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-ID: <20030129161446.GB32294@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030129162354.55f2ace4.skraw@ithnet.com> <Pine.LNX.4.44.0301291025240.18828-100000@coffee.psychology.mcmaster.ca> <20030129164552.182e0cb8.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129164552.182e0cb8.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 04:45:52PM +0100, Stephan von Krawczynski wrote:
 
 > # cat /proc/mtrr
 > reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
 > reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
 > reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
 > reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
 > reg04: base=0xf0000000 (3840MB), size= 128MB: write-back, count=1
 > reg05: base=0xf7000000 (3952MB), size=  16MB: uncachable, count=1

Due to this 16MB hole, your BIOS has to set up a write-back range
covering 2048-16 (2032MB). Due to limitations on the way MTRRs work,
you can't do this all in 1, so you have to split it up over several.
The result is that you use up 5 MTRRs covering 1 range + 1 for the
unmapped 16MB. Leaving just two for..
 
 > reg06: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
 > reg07: base=0x200000000 (8192MB), size=8192MB: write-back, count=1

So you really are out of MTRRs (There are only 8 on this CPU).
Does your BIOS have any option to disable this hole in low memory ?
I've seen similar things on laptops that use shared memory between
CPU & Graphics card, but I was unaware of anything like this on
desktop/server motherboards.

If this has onboard VGA, and theres a way to disable it, perhaps that
will work. (Even if it means plugging in a PCI/AGP video card)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
