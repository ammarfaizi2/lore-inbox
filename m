Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbULQXAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbULQXAn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbULQXAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:00:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16298 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262219AbULQXAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:00:15 -0500
Date: Fri, 17 Dec 2004 14:59:59 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
Message-ID: <20041217225959.GA23572@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 04:47:18PM -0600, Kylene Hall wrote:
> +static struct pci_device_id tpm_pci_tbl[] __devinitdata = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801BA_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
> +	{0,}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, tpm_pci_tbl);

Please do not put this in a .h file.  It belongs in the .c files.  If
both tpm drivers could be on all of the above pci devices, then that's
fine.  But odds are, eventually the table will start to differenciate.

This is also not a good idea, as the main tpm core module will end up
with this pci device table, and it should not, as it does not support
any pci devices itself.

thanks,

greg k-h
