Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWJENVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWJENVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWJENVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:21:17 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6497 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750716AbWJENVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:21:17 -0400
Date: Thu, 5 Oct 2006 15:20:06 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ashok Raj <ashok.raj@intel.com>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: Re: [PATCH] drivers/base: error handling fixes
Message-ID: <20061005132006.GD6920@osiris.boeblingen.de.ibm.com>
References: <20061004130554.GA25974@havoc.gtf.org> <20061004172434.1a2ddb71@gondolin.boeblingen.de.ibm.com> <20061005081705.GA6920@osiris.boeblingen.de.ibm.com> <4524E983.6010208@garzik.org> <20061005124848.GB6920@osiris.boeblingen.de.ibm.com> <20061005151546.31b73ab5@gondolin.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005151546.31b73ab5@gondolin.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	for_each_online_cpu(cpu) {
> > +		sys_dev = get_cpu_sysdev(cpu);
> > +		rc = topology_add_dev(sys_dev);
> > +		if (rc)
> > +			return rc;
> >  	}
> >  
> >  	register_hotcpu_notifier(&topology_cpu_notifier);
> 
> Shouldn't the added attribute groups be removed again in the failure
> case?
> 
> Also, it might be a bit overkill to fail the whole initialization
> because of one "bad" cpu. (And the "bad" cpu wouldn't matter if we
> could safely remove non-existent groups :)

This is initcall stuff. The only sane reason why this would fail, would
be an out of memory situation . If we are that early short on memory, we
are in serious trouble anyway. So I doubt it's worth the extra code.
