Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTD2M2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbTD2M2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:28:46 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:5907 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261849AbTD2M2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:28:44 -0400
Date: Tue, 29 Apr 2003 13:41:00 +0100
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429134100.A30251@infradead.org>
Mail-Followup-To: hch@infradead.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
	linux-kernel@vger.kernel.org
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru> <wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org> <20030429162322.B5767@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030429162322.B5767@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, Apr 29, 2003 at 04:23:22PM +0400
From: Christoph Hellwig <hch@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 04:23:22PM +0400, Ivan Kokshaysky wrote:
> Agreed, but what if your EISA-PCI bridge has only 30 address lines wired
> to PCI? Yes, we can check this for EISA device because it has *real*
> PCI parent (thanks, Marc :-), but what about ISA/legacy/whatever drivers?
> I doubt that all of them bother to set dma_mask pointer (so you can have
> an oops there).

If you have a struct device for them you need to set the dma_mask
and it should better have some parent (real or fake, at least the
data structures must be setup).  The old NULL argument will stay for
while.  If at some point all drivers doing that are converted (or
go away :)) it could be dropped.

