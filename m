Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbTHSUG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSUGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:06:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52241 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261363AbTHSUGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:06:23 -0400
Date: Tue, 19 Aug 2003 21:06:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Standard driver call to enable/disable PCI ROM
Message-ID: <20030819210618.D23670@flint.arm.linux.org.uk>
Mail-Followup-To: Jon Smirl <jonsmirl@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030819194503.10122.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030819194503.10122.qmail@web14911.mail.yahoo.com>; from jonsmirl@yahoo.com on Tue, Aug 19, 2003 at 12:45:03PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 12:45:03PM -0700, Jon Smirl wrote:
> Here's the code I used...
> 
> static void * __init aty128_map_ROM(struct pci_dev
>                    *dev, const struct aty128fb_par
> *par)
> {
>    void *rom;
>    struct resource *r =
>       &dev->resource[PCI_ROM_RESOURCE];
>                                                       
>    /* assign address if it doesn't have one */
>    if (r->start == 0)
>       pci_assign_resource(dev,
>                                     PCI_ROM_RESOURCE);
>                                                       
>    /* enable if needed */
>    if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
>       pci_write_config_dword(dev,
>                      dev->rom_base_reg, r->start | 
                                          ^^^^^^^^^

This is non-portable.

You should use pcibios_resource_to_bus() to convert a resource to a
representation suitable for a BAR.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

