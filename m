Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVCDAoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVCDAoY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCDAl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:41:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40127 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262724AbVCDAfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:35:38 -0500
Message-ID: <4227AD34.4050002@pobox.com>
Date: Thu, 03 Mar 2005 19:35:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][3/26] IB/mthca: improve CQ locking part 1
References: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
In-Reply-To: <2005331520.cHJfJcRbBu1fFgB6@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> @@ -783,6 +777,11 @@
>  			  cq->cqn & (dev->limits.num_cqs - 1));
>  	spin_unlock_irq(&dev->cq_table.lock);
>  
> +	if (dev->mthca_flags & MTHCA_FLAG_MSI_X)
> +		synchronize_irq(dev->eq_table.eq[MTHCA_EQ_COMP].msi_x_vector);
> +	else
> +		synchronize_irq(dev->pdev->irq);
> +


Tangent:  I think we need a pci_irq_sync() rather than putting the above 
code into each driver.

	Jeff


