Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTKFJh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTKFJh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:37:59 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:27407 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263489AbTKFJho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:37:44 -0500
Date: Thu, 6 Nov 2003 09:36:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b6).
Message-ID: <20031106093600.A14526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linux-SCSI <linux-scsi@vger.kernel.org>
References: <B179AE41C1147041AA1121F44614F0B060ED62@AVEXCH02.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B179AE41C1147041AA1121F44614F0B060ED62@AVEXCH02.qlogic.org>; from andrew.vasquez@qlogic.com on Tue, Nov 04, 2003 at 05:15:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	o Slab cache allocations for driver SRBs.

this one is broken.  You kall kmem_cache_alloc and kmem_cache_free
under a spinlock which is not wrong (at least with GFP_ATOMIC) but useless.
You don't have a mempool so you will deadlock under load.
You have a kmem_cache_t per host which is unessecary, one in the driver is
enough.

> the source-type tarball format.  It's not worth the extra effort of
> building a separate drop-in kernel tarball, given the varying release
> periods of the driver.  Similar drop-in-kernel-tarball results can be
> had by:


Would be nice to unpack into a directory instead of CWD, like almost any
tarball does..

> Failover functionality is present in this distribution, at this time I
> do not foresee a policy change regarding its presence in the 8.x
> series driver.  The next beta release of 8.x will be failover-feature
> resync'd with our latest 6.x beta (6.07.xx).

So it won't get merged into 2.6.x.  Not that it would be likely given your
complete ignorance of the other TODO items.  Sometimes I really wish to
get some funding to work on a mergeable qla2xxx driver as it seems impossible
to get one from qlogic..

--
Christoph Hellwig <hch@lst.de>		-	Freelance Hacker
Contact me for driver hacking and kernel development consulting
