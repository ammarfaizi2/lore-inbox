Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWE2IJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWE2IJz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWE2IJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:09:55 -0400
Received: from mga05.intel.com ([192.55.52.89]:41108 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750767AbWE2IJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:09:54 -0400
X-IronPort-AV: i="4.05,183,1146466800"; 
   d="scan'208"; a="43796140:sNHT14624974"
Subject: Re: pci_walk_bus race condition
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1148863271.4377.521.camel@ymzhang-perf.sh.intel.com>
References: <1148625315.4377.518.camel@ymzhang-perf.sh.intel.com>
	 <20060526135039.GA13280@kroah.com>
	 <1148863271.4377.521.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1148889932.4377.537.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 29 May 2006 16:05:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 08:41, Zhang, Yanmin wrote:
> On Fri, 2006-05-26 at 21:50, Greg KH wrote:
> > On Fri, May 26, 2006 at 02:35:16PM +0800, Zhang, Yanmin wrote:
> > > pci_walk_bus has a race with pci_destroy_dev. In the while loop,
> > > when the callback function is called, dev pointed by next might be
> > > freed and erased. So later on access to dev might cause kernel panic.
> > 
> > Have you seen this happen?  The only user of this function is the PPC64
> > EEH handler, which last time I checked, didn't run on Intel based
> > processors :)
> I am enabling PCI-Express AER in kernel and want to use it. After
> double-checking, I found the lock is not good.
How about changing pci_bus_lock to a sema? I think it's the thorough
approach. As the write lock is used only when initializing and uninitializing,
the performance won't be hurted severely.

Thanks,
Yanmin
