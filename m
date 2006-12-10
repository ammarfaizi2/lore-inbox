Return-Path: <linux-kernel-owner+w=401wt.eu-S1761889AbWLJQWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761889AbWLJQWx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762247AbWLJQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:22:53 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:52560 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761889AbWLJQWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:22:52 -0500
Message-ID: <457C345D.8030305@gentoo.org>
Date: Sun, 10 Dec 2006 11:22:53 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Linus Torvalds <torvalds@osdl.org>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       cw@f00f.org
Subject: Re: RFC: PCI quirks update for 2.6.16
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de>
In-Reply-To: <20061210160053.GD10351@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Below is the patch for going back to the 2.6.16.16 status quo that is in 
> 2.6.16.36-rc1.
> 
> Does this cause any serious regression for anyone?

If I remember right, it breaks Chris Wedgwood's box

> cu
> Adrian
> 
> 
> commit dcb1715778026c4aec20d186dc794245d9a1f5de
> Author: Adrian Bunk <bunk@stusta.de>
> Date:   Fri Dec 8 17:00:35 2006 +0100
> 
>     revert the quirk_via_irq changes
>     
>     This patch reverts the quirk_via_irq changes in 2.6.16.17 that
>     caused regressions for several people.
>     
>     Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a1cdf06..2a66e39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -656,13 +656,7 @@ static void quirk_via_irq(struct pci_dev *dev)
>  		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
>  	}
>  }
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
> -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
>  
>  /*
>   * VIA VT82C598 has its device ID settable and many BIOSes
> 

