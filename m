Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTLOKhk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTLOKhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:37:39 -0500
Received: from mail.mppmu.mpg.de ([134.107.24.11]:59604 "EHLO
	mail.mppmu.mpg.de") by vger.kernel.org with ESMTP id S263460AbTLOKhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:37:38 -0500
Date: Mon, 15 Dec 2003 11:37:36 +0100 (CET)
From: Peter Breitenlohner <peb@mppmu.mpg.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.23 dual Xeon detection problem + patch (fwd)
In-Reply-To: <Pine.LNX.4.58.0312141814550.23752@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0312151134580.1027@pcl321.mppmu.mpg.de>
References: <Pine.LNX.4.58.0312141309280.1027@pcl321.mppmu.mpg.de>
 <Pine.LNX.4.58.0312141814550.23752@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Dec 2003, Zwane Mwaikambo wrote:

> On Sun, 14 Dec 2003, Peter Breitenlohner wrote:
>
> > -------------------- start of patch ------------------
> > --- linux-2.4.23/include/asm-i386/smpboot.h.orig	2003-08-25 13:44:43.000000000 +0200
> > +++ linux-2.4.23/include/asm-i386/smpboot.h	2003-12-02 16:49:46.000000000 +0100
> > @@ -73,11 +73,9 @@
> >   */
> >  static inline int cpu_present_to_apicid(int mps_cpu)
> >  {
> > -	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
> > -		return raw_phys_apicid[mps_cpu];
> >  	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
> >  		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
> > -	return mps_cpu;
> > +	return raw_phys_apicid[mps_cpu];
> >  }
>
> What was NR_CPUS in your kernel config?

I tried 4, 8, and 32; that didn't make any difference. The problem really is
a physical vs. logigal apic-id confusion!

regards
Peter Breitenlohner <peb@mppmu.mpg.de>
