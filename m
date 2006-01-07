Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWAGV2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWAGV2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbWAGV2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:28:54 -0500
Received: from ns1.suse.de ([195.135.220.2]:4998 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752587AbWAGV2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:28:53 -0500
Date: Sat, 7 Jan 2006 22:28:51 +0100
From: Olaf Hering <olh@suse.de>
To: linas <linas@austin.ibm.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/22] ppc64: RPA PHP to EEH code movement
Message-ID: <20060107212851.GA31731@suse.de>
References: <20051006232032.GA29826@austin.ibm.com> <20051006234624.GO29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051006234624.GO29826@austin.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Oct 06, Linas Vepstas wrote:

> 
> 14-rpaphp-migrate.patch
> 
> This patch moves some pci device add & remove code from the PCI
> hotplug directory to the arch/ppc64/kernel directory, and cleans 
> it up a tad. The primary reason for this is that the code performs
> some fairly generic operations that are shared with the PCI error
> recovery code (living in the arch/ppc64/kernel directory).

> +++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dlpar.c	2005-10-06 17:54:00.306445890 -0500

> +pcibios_add_pci_devices(struct pci_bus * bus)

> +	eeh_add_device_tree_early(dn);

eeh_add_device_tree_early is in eeh.c, which depends on CONFIG_EEH. but
pci_dlpar.c is compiled unconditionally. Current powerpc.git gives:

arch/powerpc/platforms/built-in.o(.text+0x99b8): In function `.pcibios_add_pci_devices':
: undefined reference to `.eeh_add_device_tree_early'
arch/powerpc/platforms/built-in.o(.text+0x9b40): In function `.pcibios_remove_pci_devices':
: undefined reference to `.eeh_remove_bus_device'


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
