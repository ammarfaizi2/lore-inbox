Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbUBBUWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUBBUWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:22:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:59372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265935AbUBBUQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:16:07 -0500
Date: Mon, 2 Feb 2004 12:05:55 -0800
From: Greg KH <greg@kroah.com>
To: Dely Sy <dlsy@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       dely.l.sy@intel.com, tony.luck@intel.com
Subject: Re: Patch to get cpqphp working with IOAPIC (2.6.0-test5)
Message-ID: <20040202200555.GA32087@kroah.com>
References: <200309161550.h8GFoO2X003176@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309161550.h8GFoO2X003176@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 08:50:24AM -0700, Dely Sy wrote:
> Hi,
> 
> Here is a patch for 2.6.0-test5 to get cpqphp working with IOAPIC. 
> My earlier statement that a kernel patch is not needed for 2.6 is 
> true only when ACPI is enabled.  A similar patch is needed in 
> pcibios_enable_irq() for 2.4 kernel and I will send it out 
> later.
> 
> The fix is in pirq_enable_irq().  This function is called indirectly
> by pci_enable_device().  For device present during boot up, it should 
> get the proper dev->irq for pcibios_fixup_irqs() has been called to 
> get the dev->irq from MP table. If the value is still zero, then 
> this is properly caused by "buggy MP table".  For hot-plug device, 
> its dev->irq is 0 when the pci_enable_device() is called for it hasn't 
> gone through the fixup.  Therefore, the code (similiar to the code 
> in pcibios_fixup_irqs) is needed here.

Wow, very sorry for the long delay here.  I took the patch you sent me
for the irq.c file in your previous big SHPC patch and added it to the
rest of the cpqphp changes you made here, and applied it to my trees.

thanks,

greg k-h
