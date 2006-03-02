Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWCBSt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWCBSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWCBSt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:49:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751671AbWCBSt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:49:28 -0500
Date: Thu, 2 Mar 2006 19:49:02 +0100
From: Jens Axboe <axboe@suse.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Ju, Seokmann" <Seokmann.Ju@lsil.com>,
       "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: Question: how to map SCSI data DMA address to virtual address?
Message-ID: <20060302184902.GW4329@suse.de>
References: <9738BCBE884FDB42801FAD8A7769C2651420C1@NAMAIL1.ad.lsil.com> <Pine.LNX.4.61.0603021203280.14257@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603021203280.14257@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, linux-os (Dick Johnson) wrote:
> 
> On Thu, 2 Mar 2006, Ju, Seokmann wrote:
> 
> > Hi,
> >
> > In the 'scsi_cmnd' structure, there are two entries holding address
> > information for data to be transferred. One is 'request_buffer' and the
> > other one is 'buffer'.
> > In case of 'use_sg' is non-zero, those entries indicates the address of
> > the scatter-gather table.
> >
> > Is there way to get virtual address (so that the data could be accessed
> > by the driver) of the actual data in the case of 'use_sg' is non-zero?
> >
> > Any comments would be appreciated.
> >
> >
> > Thank you,
> >
> > Seokmann
> > -
> 
> There is a macro for this purpose. However, for experiments, in
> the kernel, you can add PAGE_OFFSET (0xC00000000) to get the virtual
> address. The macro is __va(a), its inverse is __pa(a).
> 
> Careful. These things can change.

Bzzt no, this wont work if an iommu is involved. It also wont work if
the page doesn't have a virtual address mapping (think highmem).

-- 
Jens Axboe

