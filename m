Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVHLNcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVHLNcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVHLNcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:32:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13506 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751180AbVHLNcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:32:51 -0400
Date: Fri, 12 Aug 2005 15:32:48 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
Message-ID: <20050812133248.GN8974@wotan.suse.de>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FCA23C.7040601@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 03:21:00PM +0200, Martin Wilck wrote:
> >Yes, it's broken. In fact I removed it in my physflat32 patch
> >which is needed for 16 core AMD systems. I don't think there
> >is a generic way to fix it because the XAPIC check breaks
> >on AMD systems 
> 
> on the Intel Xeon MP systems, too,

How so? The XAPIC version check should work there.

The problem on AMD happens because it reports an old APIC version.

> 
> >and there is no good way to decide early 
> >on subarchitectures before doing this check. Also it's only
> >a sanity check for broken BIOS, and in this case it causes more problems
> >than it solves.
> 
> agreed.
> 
> >ftp://ftp.firstfloor.org/pub/ak/x86_64/x86_64-2.6.13rc3-1/patches/physflat32
> 
> That is a beautiful patch, thank you.

It'll probably be revamped somewhat before inclusion. In particular
it has been suggested to merge it with bigsmp because the setup
should work on Intel too.

> 
> Only one small point: I wonder whether it is correct to use the number 
> of CPUs as criterion for this architecture. AFAICS, the Specs allow
> having only 4 CPUS, but giving them APIC IDs e.g. 16,17,18,19. In this 
> case, physflat32 should be used as well (in particular, the APIC ID 
> broadcast and mask must be set to 0xff).

I fixed that in the 64bit version already, but not in 32bit yet.
Yes, the value of the APIC IDs must be used as indicator.

-Andi
