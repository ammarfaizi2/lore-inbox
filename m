Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWEOXMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWEOXMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWEOXMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:12:42 -0400
Received: from palrel10.hp.com ([156.153.255.245]:4819 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1750738AbWEOXMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:12:41 -0400
Date: Mon, 15 May 2006 16:13:42 -0700
From: Grant Grundler <iod00d@hp.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
Message-ID: <20060515231342.GK29082@esmail.cup.hp.com>
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com> <adad5efuw1o.fsf@cisco.com> <1147728081.2773.25.camel@chalcedony.pathscale.com> <adar72vrn8y.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adar72vrn8y.fsf@cisco.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 02:28:45PM -0700, Roland Dreier wrote:
>     Bryan> Any ideas?  Should this turn from a one-liner into a
>     Bryan> big-refactor-for-2.6.18 patch?
> 
> I don't think there's a quick way to fix this.  What you really want
> to do is override the DMA mapping functions for your device so that
> you can keep track of the kernel mapping.

Or figure out which openib.org interface has to change so the
original virt addresses that were registered/handed to the ULP
are passed down to the low level interface driver too.
Seems like a more obvious way to fix the problem.
Someone did suggest this already, right?

> (cf the ehca driver), and I think patches to do it on x86-64 are
> floating around as part of the "Calgary IOMMU" work.

parisc has been using dma_ops for several years.
I don't expect dma_ops to become part of generic code.
DMA support is inherently arch specific.
Because of that, I don't look forward to a low level
device driver that is mucking with dma_ops.

hth,
grant
