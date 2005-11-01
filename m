Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVKAE6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVKAE6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVKAE6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:58:12 -0500
Received: from verein.lst.de ([213.95.11.210]:6317 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932575AbVKAE6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:58:10 -0500
Date: Tue, 1 Nov 2005 05:58:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, openib-general@openib.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH/RFC] IB: Add SCSI RDMA Protocol (SRP) initiator
Message-ID: <20051101045800.GA25519@lst.de>
References: <52wtjtk3d1.fsf@cisco.com> <20051101110409V.fujita.tomonori@lab.ntt.co.jp> <52irvdge6c.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52irvdge6c.fsf@cisco.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 08:55:23PM -0800, Roland Dreier wrote:
> Anyway, looking at drivers/scsi/ibmvscsi/srp.h, the main problem I see
> is that the file has a bunch of bitfields that are big-endian only
> (which makes sense because the driver can only be compiled for pSeries
> or iSeries anyway).
> 
> But I have no objection to moving the file to include/scsi/srp.h,
> adding a bunch of
> 
>     #if defined(__LITTLE_ENDIAN_BITFIELD)
>     #elif defined(__BIG_ENDIAN_BITFIELD)
>     #endif
> 
> and adding a few missing defines, and then converting ib_srp to use
> the same file.
> 
> Does that seem like the right thing to do?

No. Bitfields for accessing hardware/wire datastructures are wrong and
will always break in some circumstances.  Your header is much better.

> 
> Thanks,
>   Roland
> _______________________________________________
> openib-general mailing list
> openib-general@openib.org
> http://openib.org/mailman/listinfo/openib-general
> 
> To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general
---end quoted text---
