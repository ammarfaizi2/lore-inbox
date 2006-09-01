Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWIAVdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWIAVdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWIAVdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:33:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43480 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750925AbWIAVcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:32:54 -0400
Date: Fri, 1 Sep 2006 16:32:51 -0500
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Yanmin Zhang <yanmin.zhang@intel.com>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: pci error recovery procedure
Message-ID: <20060901213251.GT8704@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com> <20060831175001.GE8704@austin.ibm.com> <1157082169.20092.174.camel@ymzhang-perf.sh.intel.com> <1157101449.20092.180.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157101449.20092.180.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 05:04:09PM +0800, Zhang, Yanmin wrote:
> One more comment: The second parameter of error_detected also could be deleted
> because recovery procedures will save error to pci_dev->error_state.

Yes, I beleive so.

> So, the err_handler pci_error_handlers could be:
> struct pci_error_handlers
> {
>         pci_ers_result_t (*error_detected)(struct pci_dev *dev);
>         pci_ers_result_t (*error_resume)(struct pci_dev *dev);
> };

No, as per other email, we still need a multi-step process for
multi-function cards, and for cards that may not want to get
a full electrical reset. Finally, there might be platforms 
that cannot perform a per-slot electrical reset, and would 
therefore require drivers that can recover on thier own.

--linas


-- 
VGER BF report: H 8.89398e-05
