Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUIPRmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUIPRmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUIPRky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:40:54 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:17126 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S268382AbUIPRie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:38:34 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: 2.6.9-rc2-mm1
Date: Thu, 16 Sep 2004 11:38:25 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       len.brown@intel.com,
       Natalie Protasevich <Natalie.Protasevich@unisys.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161014.59686.jbarnes@engr.sgi.com>
In-Reply-To: <200409161014.59686.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409161138.25404.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 11:14 am, Jesse Barnes wrote:
> On Thursday, September 16, 2004 2:40 am, Andrew Morton wrote:
> >  bk-acpi.patch
> 
> Looks like some changes in this patch break sn2.  In particular, this hunk in 
> acpi_pci_irq_enable():
> 
> -               if (dev->irq && (dev->irq <= 0xF)) {
> +               if (dev->irq >= 0 && (dev->irq <= 0xF)) {
>                         printk(" - using IRQ %d\n", dev->irq);
>                         return_VALUE(dev->irq);
>                 }
>                 else {
>                         printk("\n");
> -                       return_VALUE(0);
> +                       return_VALUE(-EINVAL);
>                 }
> 
> Now instead of returning 0, we'll get -EINVAL when a driver calls 
> pci_enable_device.  This is arguably correct since there's no _PRT entry (and 
> in fact no ACPI namespace on sn2), but shouldn't the code above be looking at 
> the 'pin' value instead of dev->irq?  The sn2 specific PCI code sets up each 
> dev->irq long before this with the correct values...

I think the change above is actually from
    incorrect-pci-interrupt-assignment-on-es7000-for-pin-zero.patch

of which I am officially ignorant :-)
