Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVCDBEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVCDBEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVCDBBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:01:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:5023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262841AbVCDA67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:58:59 -0500
Date: Thu, 3 Mar 2005 16:58:24 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Roland Dreier <roland@topspin.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][3/26] IB/mthca: improve CQ locking part 1
Message-ID: <20050304005824.GA18411@kroah.com>
References: <2005331520.cHJfJcRbBu1fFgB6@topspin.com> <4227AD34.4050002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4227AD34.4050002@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 07:35:00PM -0500, Jeff Garzik wrote:
> Roland Dreier wrote:
> >@@ -783,6 +777,11 @@
> > 			  cq->cqn & (dev->limits.num_cqs - 1));
> > 	spin_unlock_irq(&dev->cq_table.lock);
> > 
> >+	if (dev->mthca_flags & MTHCA_FLAG_MSI_X)
> >+	 synchronize_irq(dev->eq_table.eq[MTHCA_EQ_COMP].msi_x_vector);
> >+	else
> >+		synchronize_irq(dev->pdev->irq);
> >+
> 
> 
> Tangent:  I think we need a pci_irq_sync() rather than putting the above 
> code into each driver.

Sure, I have no problem accepting that into the pci core.

thanks,

greg k-h
