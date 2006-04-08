Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWDHINl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWDHINl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 04:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWDHINl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 04:13:41 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27537 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751401AbWDHINk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 04:13:40 -0400
Date: Sat, 8 Apr 2006 10:12:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH] PCI Error Recovery: e100 network device driver
Message-ID: <20060408081231.GA29323@electric-eye.fr.zoreil.com>
References: <20060406222359.GA30037@austin.ibm.com> <20060406224643.GA6278@kroah.com> <20060407231134.GN25225@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407231134.GN25225@austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas <linas@austin.ibm.com> :
> Index: linux-2.6.17-rc1/drivers/net/e100.c
> ===================================================================
> --- linux-2.6.17-rc1.orig/drivers/net/e100.c	2006-04-07 16:21:46.000000000 -0500
> +++ linux-2.6.17-rc1/drivers/net/e100.c	2006-04-07 18:10:52.411266545 -0500
[...]
> +static pci_ers_result_t e100_io_error_detected(struct pci_dev *pdev, pci_channel_state_t state)

80 cols limit.

[...]
> +static pci_ers_result_t e100_io_slot_reset(struct pci_dev *pdev)
> +{
> +	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct nic *nic = netdev_priv(netdev);
> +
> +	if (pci_enable_device(pdev)) {
> +		printk(KERN_ERR "e100: Cannot re-enable PCI device after reset.\n");

- The driver supports {get/set}_msglevel. Please consider using netif_msg_xxx
  (see include/linux/netdevice.h).

- s/e100/DRV_NAME/ (or netdev->name, or pci_name(...) depending on the
  context).

[...]
> +static struct pci_error_handlers e100_err_handler = {
> +	.error_detected = e100_io_error_detected,
> +	.slot_reset = e100_io_slot_reset,
> +	.resume = e100_io_resume,
> +};

Nit: I'd rather follow the style in the declaration of e100_driver.

-- 
Ueimor
