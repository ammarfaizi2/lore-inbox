Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265780AbUGHF1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUGHF1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGHF1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:27:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:38116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265780AbUGHF1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:27:44 -0400
Date: Wed, 7 Jul 2004 22:26:04 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040708052603.GA548@kroah.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <20040707211656.GA4105@kroah.com> <20040707164739.I21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707164739.I21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 04:47:39PM -0500, linas@austin.ibm.com wrote:

> ===== drivers/pci/hotplug/rpaphp.h 1.9 vs edited =====
> --- 1.9/drivers/pci/hotplug/rpaphp.h	Fri Jul  2 11:14:11 2004
> +++ edited/drivers/pci/hotplug/rpaphp.h	Wed Jul  7 15:44:35 2004
> @@ -124,7 +124,8 @@
>  extern int register_pci_slot(struct slot *slot);
>  extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
>  extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
> -extern struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev);
> +extern void init_eeh_handler (void);
> +extern void exit_eeh_handler (void);

This belongs in the eeh header file, not the rpaphp.h file.

> @@ -227,7 +229,7 @@
>  	}
>  	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
>  	/* do pci_scan_child_bus */
> -	pci_scan_child_bus(child_bus);
> +	// pci_scan_child_bus(child_bus);

And the reason you are commenting out this function is...

thanks,

greg k-h
