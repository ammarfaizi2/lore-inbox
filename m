Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUAANFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 08:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUAANFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 08:05:18 -0500
Received: from pD9E56CE4.dip.t-dialin.net ([217.229.108.228]:24197 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S261464AbUAANFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 08:05:14 -0500
To: "Brad House" <brad_mssw@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: Andi Kleen <ak@muc.de>
Date: Tue, 30 Dec 2003 06:26:43 +0100
In-Reply-To: <18kst-5Av-1@gated-at.bofh.it> ("Brad House"'s message of "Tue,
 30 Dec 2003 06:20:05 +0100")
Message-ID: <m34qviyiy4.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <18kst-5Av-1@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brad House" <brad_mssw@gentoo.org> writes:
>
> diff -ruN linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c
> linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c
> --- linux-2.6.0-gentoo-r1.old/drivers/scsi/megaraid.c	2003-12-29
> 23:51:43.000000000 -0500
> +++ linux-2.6.0-gentoo-r1/drivers/scsi/megaraid.c	2003-12-29
> 23:54:01.005469936 -0500
> @@ -1292,7 +1292,7 @@
>
>  			/* Calculate Scatter-Gather info */
>  			mbox->m_out.numsgelements = mega_build_sglist(adapter, scb,
> -					(u32 *)&mbox->m_out.xferaddr, (u32 *)&seg);
> +					(dma_addr_t *)&mbox->m_out.xferaddr, (u32 *)&seg);

I'm pretty sure it's completely broken. You're changing the layout of 
a data structure that is shared with the firmware. Using a 32bit
int here is fine when the driver sets the correct dma mask or 
only stuffs pci_alloc_consistent() memory in there (i think it's
the later here)

Even though the driver prints lots of warnings at compile time it
actually works on AMD64 as is. But in many cases you should
use megaraid2.c instead of megaraid.c.

-Andi
