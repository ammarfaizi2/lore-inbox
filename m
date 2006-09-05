Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWIETBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWIETBW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWIETBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:01:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:696 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030233AbWIETBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:01:19 -0400
Date: Tue, 5 Sep 2006 14:01:15 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Yanmin Zhang <yanmin.zhang@intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: pci error recovery procedure
Message-ID: <20060905190115.GE7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com> <20060901212548.GS8704@austin.ibm.com> <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com> <1157360592.22705.46.camel@localhost.localdomain> <1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 10:32:08AM +0800, Zhang, Yanmin wrote:
> Is it the exclusive reason to have multi-steps?

I don't understand the question. A previous email explained the reason
to have mutiple steps.

> 1) Here link reset and hard reset are hardware operations, not the
> link_reset and slot_reset callback in pci_error_handlers.

I don't understand the comment.

> 2) Callback error_detected will notify drivers there is PCI errors. Drivers
> shouldn't do any I/O in error_detected.

It shouldn't matter. If it is truly important for a particular platform
to make sure that there is no i/o, then the low-level i/o routines
could be modified to drop any accidentally issued i/o on the floor.
This doesn't require a change to either the API or the policy.

> 3) If both the link and slot are reset after all error_detected are called,
> the device should go back to initial status and all DMA should be stopped
> automatically. Why does the driver still need a chance to stop DMA? 

As explained previously, not all drivers may want to have a full
electrical device reset.

> The
> error_detected of the drivers in the latest kernel who support err handlers
> always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.

Just because the current drivers do it this way does not mean that this is
the best way to do things. A full reset is time-consuming. Some drivers
may want to implement a faster and quicker reset.

--linas
