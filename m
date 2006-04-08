Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWDHADc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWDHADc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 20:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWDHADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 20:03:32 -0400
Received: from nproxy.gmail.com ([64.233.182.191]:39173 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751363AbWDHADb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 20:03:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LZumlH8LbBLlBR6ypZD9UG38I3Uk/ueQdx/4VLKXSM2tmIYJYpO6wQdcQvy550G7bM7fMJXFoU0/5JDKRw+hdIDFsWi2pKRxqupipThv6xs9ltKBNxuH2S5b1HWLKxDWoOIBdHnAxXVPwmNblNcjzCL3h/YTi+Ot7i+VErkYewM=
Date: Sat, 8 Apr 2006 04:03:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
Message-ID: <20060408000339.GE7167@mipter.zuzino.mipt.ru>
References: <20060406222359.GA30037@austin.ibm.com> <20060406224643.GA6278@kroah.com> <20060407231134.GN25225@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407231134.GN25225@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 06:11:34PM -0500, Linas Vepstas wrote:
> --- linux-2.6.17-rc1.orig/drivers/net/e100.c
> +++ linux-2.6.17-rc1/drivers/net/e100.c

> + * @state: The current pci conneection state

connection

> +static pci_ers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +
> +	/* Similar to calling e100_down(), but avoids adpater I/O. */

adapter

> +static pci_ers_result_t e100_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct nic *nic = netdev_priv(netdev);
> +
> +	if (pci_enable_device(pdev)) {
> +		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	pci_set_master(pdev);
> +
> +	/* Only one device per card can do a reset */
> +	if (0 != PCI_FUNC(pdev->devfn))

Wrong order.

