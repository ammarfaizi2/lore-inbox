Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbUDFVH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUDFVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:07:27 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:65473 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264016AbUDFVEO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:04:14 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Tue, 6 Apr 2004 23:04:11 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <200404062237.02210.volker.hemmann@heim10.tu-clausthal.de> <20040406204843.GC1100@redhat.com>
In-Reply-To: <20040406204843.GC1100@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404062304.12089.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 22:48, Dave Jones wrote:
> On Tue, Apr 06, 2004 at 10:37:02PM +0200, Hemmann, Volker Armin wrote:
>  >         Capabilities: [c0] AGP version 3.0
>
> Ok, so your system is fully AGP v3 compliant, (both host and gfx card).
> The missing check highlighted in your diff means that we only do
> AGPv3 stuff if we have an AGP 3.5 host bridge. You have a 3.0 bridge,
> so it was falling back to AGP v2.  My suspicion now is that the 648 and
> 746 chipsets vary too much for them to both use the generic routines,
> so I'll reinstate the check.  It'll still report that it finds an
> AGP v3.0 device, but until someone comes forward with chipset docs,
> it looks like it'll be limited to AGP v2. (I'm amazed that it works
> at all, really).
>
> It survives a testgart run too ?
>
> 		Dave

I am amazed, too, that may box is running... ;o)

testgart works,  I did a fresh reboot, to be sure:

version: 0.100
bridge id: 0x7461039
agp_mode: 0x1f004e1b
aper_base: 0xd0000000
aper_size: 128
pg_total: 112384
pg_system: 112384
pg_used: 0
entry.key : 0
entry.key : 1
Allocated 8 megs of GART memory
MemoryBenchmark: 1444 mb/s
MemoryBenchmark: 1474 mb/s
MemoryBenchmark: 1477 mb/s
Average speed: 1465 mb/s
Testing data integrity (1st pass): passed on first pass.
Testing data integrity (2nd pass): passed on second pass.

and dmesg:

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 746 chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xd0000000
<snip>
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: sis 648 agp fix - giving bridge time to recover
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode

Glück Auf
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
