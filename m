Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967553AbWLAIe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967553AbWLAIe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 03:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967555AbWLAIe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 03:34:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:52579 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S967553AbWLAIe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 03:34:56 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,483,1157353200"; 
   d="scan'208"; a="171527383:sNHT25462675"
Subject: Re: [patch]VMSPLIT_2G conflicts with PAE
From: Shaohua Li <shaohua.li@intel.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061201075520.GD5400@kernel.dk>
References: <1164944925.1918.5.camel@sli10-conroe.sh.intel.com>
	 <20061201075520.GD5400@kernel.dk>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 16:34:17 +0800
Message-Id: <1164962057.3299.6.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 08:55 +0100, Jens Axboe wrote:
> On Fri, Dec 01 2006, Shaohua Li wrote:
> > PAGE_OFFSET is 0x78000000 with VMSPLIT_2G, this address is in the middle
> > of the second pgd entry with pae enabled. This breaks assumptions
> > (address is aligned to pgd entry's address) in a lot of places like
> > pagetable_init. Fixing the assumptions is hard (eg, low mapping). SO I
> > just changed the address to 0x80000000.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > 
> > diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> > index 8ff1c6f..fddfb26 100644
> > --- a/arch/i386/Kconfig
> > +++ b/arch/i386/Kconfig
> > @@ -532,7 +532,7 @@ endchoice
> >  config PAGE_OFFSET
> >  	hex
> >  	default 0xB0000000 if VMSPLIT_3G_OPT
> > -	default 0x78000000 if VMSPLIT_2G
> > +	default 0x80000000 if VMSPLIT_2G
> >  	default 0x40000000 if VMSPLIT_1G
> >  	default 0xC0000000
> 
> 0x78000000 was chosen since it gives you the full 2G as low memory, if
> you mave it 0x80000000 then you still have a little highmem and need
> that turned on.
Ok, Maybe the x86 relocatable patch (it seems removed the low identity
mapping) can help here. With it, we just need to fix pagetable_init.

Thanks,
Shaohua
