Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263111AbUB1Ctf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 21:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbUB1Ctf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 21:49:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16801 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263111AbUB1Csi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 21:48:38 -0500
Subject: Re: 2.6.3-mm3 (ioremap failure w/ _X86_4G and _NUMA)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040227160613.17be31cb.akpm@osdl.org>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077924860.10076.49.camel@cog.beaverton.ibm.com>
	 <20040227160613.17be31cb.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1077936504.10076.63.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 27 Feb 2004 18:48:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 16:06, Andrew Morton wrote:
> john stultz <johnstul@us.ibm.com> wrote:
> >
> > When running -mm3 (plus the one-line fix to the expanded-pci-config
> > patch) to on an x440  w/ 4G enabled, the tg3 driver cannot find my
> > network card. 
> > 
> > When booting I get:
> > tg3.c:v2.7 (February 17, 2004)                
> > tg3: Cannot map device registers, aborting.
> > tg3: probe of 0000:01:04.0 failed with error -12
> > 
> > Otherwise the system seems to come up fine. 
> > 
> > Disabling CONFIG_ACPI (or CONFIG_X86_4G) makes the problem go away.
> 
> Beats me.  Maybe acpi is returning some monstrous reosurce length and we're
> running out of kernel virtual space only with the 4g split?
> 
> 'twould be appreciated if you could stick a few printk's in there and work
> out what's happening please.  Check out the pci space base address and
> length with and without ACPI?

The base address and length are the same either way, instead its
__ioremap that's failing at "if(!PageReserved(page))"[ioremap.c:142].

I've also narrowed down the issue to only occur w/ (CONFIG_X86_4G=y &&
CONFIG_NUMA=y) so it looks like its a propblem w/ 4G and discontigmem
together. 

I've also finally moved to -mm4 and reproduced the problem there.

Martin: Any ideas?

-john

