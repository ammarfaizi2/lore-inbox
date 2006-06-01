Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWFASjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWFASjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWFASjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:39:36 -0400
Received: from mga06.intel.com ([134.134.136.21]:42063 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S965097AbWFASjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:39:35 -0400
X-IronPort-AV: i="4.05,199,1146466800"; 
   d="scan'208"; a="44484353:sNHT157234357"
Date: Thu, 1 Jun 2006 11:36:26 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Rajesh Shah <rajesh.shah@intel.com>, "bibo,mao" <bibo.mao@intel.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060601113625.A4043@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060601171559.GA16288@colo.lackof.org>; from grundler@parisc-linux.org on Thu, Jun 01, 2006 at 11:15:59AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 11:15:59AM -0600, Grant Grundler wrote:
> +   The device driver needs to call pci_request_region() to make sure
> +no other device is already using the same resource. The driver is expected
> +to determine MMIO and IO Port resource availability _before_ calling
> +pci_enable_device().  Conversely, drivers should call pci_release_region()
> +_after_ calling pci_disable_device(). The idea is to prevent two devices
> +colliding on the same address range.
> +
A quick look in the drivers directory shows that _lots_ of drivers
violate this rule. In fact, I suspect Kaneshige-san made the original
incorrect assumption since there were so many drivers out there
which do it in the wrong order.

Rajesh
