Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWIRUVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWIRUVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWIRUVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:21:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751917AbWIRUVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:21:50 -0400
Date: Mon, 18 Sep 2006 13:21:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: linas@austin.ibm.com (Linas Vepstas)
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "bibo,mao" <bibo.mao@intel.com>, Auke Kok <sofar@foo-projects.org>,
       Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH] please include in 2.6.18: e100 disable device on PCI
 error
Message-Id: <20060918132102.d850c1c2.akpm@osdl.org>
In-Reply-To: <20060918200122.GD29167@austin.ibm.com>
References: <20060918200122.GD29167@austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2006 15:01:22 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> 
> Hi,
> 
> Please apply the following one-liner patch to  
> what will become the stable 2.6.18.  This patch is 
> low-risk because it affects only the PCI error 
> recovery code, which dosn't run on most platforms
> (in particular, isn't invoked on current x86/ia64).
> 
> This patch was originally sent on 29 June 2006
> to fix a bug that showed up in an -mm build.
> The code from -mm made it into mainline, but 
> this patch did not, and so we're unhappy. :-(
> 
> Here's the original patch description:
> 
> A recent patch in -mm3 titled 
> gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch
> causes pci_enable_device() to be a no-op if the kernel thinks
> that the device is already enabled.  This change breaks the
> PCI error recovery mechanism in the e100 device driver, since, 
> after PCI slot reset, the card is no longer enabled. This is 
> a trivial fix for this problem. Tested.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>
> 
> ----
>  drivers/net/e100.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6.18-rc7-git1/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.18-rc7-git1.orig/drivers/net/e100.c	2006-09-18 14:21:49.000000000 -0500
> +++ linux-2.6.18-rc7-git1/drivers/net/e100.c	2006-09-18 14:24:50.000000000 -0500
> @@ -2799,6 +2799,7 @@ static pci_ers_result_t e100_io_error_de
>  	/* Detach; put netif into state similar to hotplug unplug. */
>  	netif_poll_enable(netdev);
>  	netif_device_detach(netdev);
> +	pci_disable_device(pdev);
>  
>  	/* Request a slot reset. */
>  	return PCI_ERS_RESULT_NEED_RESET;

hm.  I don't have this patch queued, but I _do_ have an equivalent patch
for e1000 queued; what's up with that?  Nobody seems to have paid much
attention to the e1000 fix.

If we can gather the appropriate acks quickly then I expect we can get both
of these into 2.6.18.
