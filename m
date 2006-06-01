Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWFAJtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWFAJtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWFAJtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:49:13 -0400
Received: from mga07.intel.com ([143.182.124.22]:17718 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964834AbWFAJtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:49:12 -0400
X-IronPort-AV: i="4.05,196,1146466800"; 
   d="scan'208"; a="44430548:sNHT30283582"
Date: Thu, 1 Jun 2006 02:46:11 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: "bibo,mao" <bibo.mao@intel.com>
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060601024611.A32490@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <447E91CE.7010705@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <447E91CE.7010705@intel.com>; from bibo.mao@intel.com on Thu, Jun 01, 2006 at 03:05:50PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 03:05:50PM +0800, bibo,mao wrote:
> I found that in -mm tree, function pci_disable_device() 
> clears bars_enabled variable, so that pci_release_regions 
> can not release reserved PCI I/O and memory resource. Some
> device driver programs in kernel tree call pci_release_regions
> function after pci_disable_device(), that will cause some problem.

It's coming from Kaneshige-san's patch:
pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch

This patch assumes that pci_request_region() will always be called
after pci_enable_device() and pci_release_region() will always
be called before pci_disable_device(). We cannot make this
assumption,since it's perfectly legal to disable a device
first and then release it's regions. So, I think that patch
needs to change.

thanks,
Rajesh
