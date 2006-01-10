Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWAJUQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWAJUQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWAJUQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:16:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:3468 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932507AbWAJUQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:16:25 -0500
Date: Tue, 10 Jan 2006 12:15:45 -0800
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       lkml <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060110201545.GA17908@kroah.com>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com> <20060103231304.56e3228b.akpm@osdl.org> <1136422680.30655.1.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136422680.30655.1.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 08:58:00AM +0800, Shaohua Li wrote:
> --- linux-2.6.15-rc5/include/linux/pci.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
> +++ linux-2.6.15-rc5-root/include/linux/pci.h	2005-12-22 09:23:16.000000000 +0800
> @@ -135,6 +135,7 @@ struct pci_dev {
>  	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
>  
>  	u32		saved_config_space[16]; /* config space saved at suspend time */
> +	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
>  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
>  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
>  	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */


This should not be a void *, right?  Why not make it the proper type?

thanks,

greg k-h
