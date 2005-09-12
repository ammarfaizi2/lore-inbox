Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVILTvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVILTvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVILTvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:51:51 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:45065 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751049AbVILTvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:51:51 -0400
Date: Mon, 12 Sep 2005 15:51:12 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Grant Grundler <iod00d@hp.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
       Asit.K.Mallick@intel.com
Subject: Re: [patch 2.6.13 4/6] swiotlb: support syncing DMA_BIDIRECTIONAL mappings
Message-ID: <20050912195110.GC19644@tuxdriver.com>
Mail-Followup-To: Grant Grundler <iod00d@hp.com>,
	linux-kernel@vger.kernel.org, discuss@x86-64.org,
	linux-ia64@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
	Asit.K.Mallick@intel.com
References: <09122005104851.31056@bilbo.tuxdriver.com> <09122005104851.31120@bilbo.tuxdriver.com> <20050912185120.GD21820@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912185120.GD21820@esmail.cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 11:51:20AM -0700, Grant Grundler wrote:
> On Mon, Sep 12, 2005 at 10:48:51AM -0400, John W. Linville wrote:

> > +	case SYNC_FOR_DEVICE:
> > +		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> > +			memcpy(dma_addr, buffer, size);
> > +		else if (dir != DMA_FROM_DEVICE && dir != DMA_NONE)
> > +			BUG();
> > +		break;
> > +	default:

> Isn't "DMA_NONE" expected to generate a warning or panic?

True enough...I'll follow-up w/ an additive patch to account for that.
As you pointed-out, the higher-level functions in swiotlb filter that
out anyway, so this really isn't a big issue.

John
-- 
John W. Linville
linville@tuxdriver.com
