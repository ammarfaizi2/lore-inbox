Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVFQSuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVFQSuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVFQSuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:50:12 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:17591 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262058AbVFQSt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:49:27 -0400
Date: Fri, 17 Jun 2005 11:49:14 -0700
From: Greg KH <gregkh@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: don't override drv->shutdown unconditionally
Message-ID: <20050617184914.GA22107@suse.de>
References: <20050617183057.GA20966@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050617183057.GA20966@lst.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 08:30:57PM +0200, Christoph Hellwig wrote:
> There are many drivers that have been setting the generic driver
> model­level shutdown callback, and pci thus must not override it.
> 
> Without this patch we can have really bad data loss on various
> raid controllers.

Without the kexec patch?

So, why are these drivers setting the shutdown function in the first
place if they don't want it to be called?  My change finally enabled
this call, which is what the driver authors expected in the first place.

Without the change I made, the same data loss would be had as drivers
never know that the box is going down.

The fact that a few drivers never tested their shutdown calls is no
reason to penalize the whole kernel.

So, no, I do not want this change in, the drivers should be fixed
properly.

Care to point me to any drivers that need fixing?

thanks,

greg k-h
