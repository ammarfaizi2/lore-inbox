Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUBFRXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUBFRX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:23:29 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24830 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265560AbUBFRXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:23:10 -0500
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm
	subsystem	involving X  (fwd)
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Keith Mannthey <kmannth@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <5450000.1076082574@[10.10.2.4]>
References: <51080000.1075936626@flay>
	 <Pine.LNX.4.58.0402041539470.2086@home.osdl.org><60330000.1075939958@flay>
	 <64260000.1075941399@flay><Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
	 <20040204165620.3d608798.akpm@osdl.org>
	 <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
	 <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com>
	 <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
	 <98220000.1076051821@[10.10.2.4]> <1076061476.27855.1144.camel@nighthawk>
	 <5450000.1076082574@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1076088169.29478.2928.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Feb 2004 09:22:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-06 at 07:49, Martin J. Bligh wrote:
> >> +#ifdef CONFIG_NUMA
> >> +	#ifdef CONFIG_X86_NUMAQ
> >> +		#include <asm/numaq.h>
> >> +	#else	/* summit or generic arch */
> >> +		#include <asm/srat.h>
> >> +	#endif
> >> +#else /* !CONFIG_NUMA */
> >> +	#define get_memcfg_numa get_memcfg_numa_flat
> >> +	#define get_zholes_size(n) (0)
> >> +#endif /* CONFIG_NUMA */
> > 
> > We ran into a bug with #ifdefs like this before.  It was fixed in some
> > of the code that you're trying to remove.
> 
> What bug?

With a regular PC config, plus CONFIG_NUMA turned on:
  CC      arch/i386/kernel/process.o
In file included from include/asm/mmzone.h:17,
                 from include/linux/mmzone.h:318,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:31,
                 from include/linux/module.h:10,
                 from init/do_mounts.c:1:
include/asm/srat.h:31: #error CONFIG_ACPI_SRAT not defined, and srat.h
header has been included
In file included from include/asm/mmzone.h:17,
                 from include/linux/mmzone.h:318,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/rcupdate.h:42,
                 from include/linux/dcache.h:10,
                 from include/linux/fs.h:17,
                 from init/do_mounts_initrd.c:3:

I can post the config if you like.  You were the one who made me go fix
it in the first place.  That's why I added that #error. :)

--dave

