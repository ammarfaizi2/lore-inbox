Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRICUv4>; Mon, 3 Sep 2001 16:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271813AbRICUvp>; Mon, 3 Sep 2001 16:51:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:955 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271814AbRICUvb>; Mon, 3 Sep 2001 16:51:31 -0400
Date: Mon, 3 Sep 2001 14:51:55 -0600
Message-Id: <200109032051.f83Kpt428276@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Zach Brown <zab@zabbo.net>
Cc: pmhahn@titan.lahn.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuid/msr + devfs
In-Reply-To: <20010903163448.A22633@erasmus.off.net>
In-Reply-To: <Pine.LNX.4.33.0108121020050.1068-100000@titan.lahn.de>
	<200109032007.f83K73H27504@vindaloo.ras.ucalgary.ca>
	<20010903163448.A22633@erasmus.off.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown writes:
> > Better to have a central place which creates per-CPU directories,
> > which you can call into and grab a directory for a CPU.
> 
> I talked with arjan and rmk about this when playing around with per cpu
> statistics stuff.  Is the proc_cpu.c stuff in the patch useful?
> 
> 	http://www.osdlab.org/sw_resources/cpustat/cpustat-2.4.7.pre5-1.diff

Well, it can be used as a guide for where things have to be patched.
It's not really suited to creating devfs directories which can be used
by random CPU drivers, since you're using an initcall.

However, the per-CPU structures you seem to be creating appears to be
a logical place to add a devfs entry. As part of the CPU detection
process, that entry should be initialised. Then drivers can simply
reference that entry.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
