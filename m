Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVCDAsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVCDAsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVCDApU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:45:20 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:30469 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262750AbVCDAkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:40:20 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][3/26] IB/mthca: improve CQ locking part 1
X-Message-Flag: Warning: May contain useful information
References: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
	<4227AD34.4050002@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 16:40:14 -0800
In-Reply-To: <4227AD34.4050002@pobox.com> (Jeff Garzik's message of "Thu, 03
 Mar 2005 19:35:00 -0500")
Message-ID: <52mztknt01.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 00:40:14.0706 (UTC) FILETIME=[BB05E520:01C52052]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -783,6 +777,11 @@
>  			  cq->cqn & (dev->limits.num_cqs - 1));
>  	spin_unlock_irq(&dev->cq_table.lock);
>  +	if (dev->mthca_flags & MTHCA_FLAG_MSI_X)
> +		synchronize_irq(dev->eq_table.eq[MTHCA_EQ_COMP].msi_x_vector);
> +	else
> +		synchronize_irq(dev->pdev->irq);
> +

    Jeff> Tangent: I think we need a pci_irq_sync() rather than
    Jeff> putting the above code into each driver.

The problem with trying to make it generic is that mthca has multiple
MSI-X vectors, and only the driver author could know that we only need
to synchronize with the completion event vector.

 - R.
