Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTJaJt7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTJaJt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:49:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263157AbTJaJt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:49:57 -0500
Date: Fri, 31 Oct 2003 09:49:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Michael Clark <michael@metaparadigm.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 Fix oops in quirk_via_bridge
Message-ID: <20031031094946.A4556@flint.arm.linux.org.uk>
Mail-Followup-To: Michael Clark <michael@metaparadigm.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3FA22E6F.8000404@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FA22E6F.8000404@metaparadigm.com>; from michael@metaparadigm.com on Fri, Oct 31, 2003 at 05:42:07PM +0800
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 05:42:07PM +0800, Michael Clark wrote:
> Strangely making the quirk and its data __devinit solves the problem
> (as is most of the other stuff in pci/quirks.c). Not sure if it is
> the correct fix but it works for me. ie. why did I get the oops
> in the first place? as the quirks data was global and not marked
> for an __init section.

The function was marked as __init.  I'd strongly recommend against
marking the data with __devinitdata since its used elsewhere in the
kernel by non-init code.

> --- linux-2.6.0-test9/drivers/pci/quirks.c	2003-10-31 16:49:25.000000000 +0800
> +++ linux-2.6.0-test9-mc/drivers/pci/quirks.c	2003-10-31 16:49:57.000000000 +0800
> @@ -644,9 +644,9 @@
>   *	VIA northbridges care about PCI_INTERRUPT_LINE
>   */
>   
> -int interrupt_line_quirk;
> +__devinitdata int interrupt_line_quirk;
>  
> -static void __init quirk_via_bridge(struct pci_dev *pdev)
> +static void __devinit quirk_via_bridge(struct pci_dev *pdev)
>  {
>  	if(pdev->devfn == 0)
>  		interrupt_line_quirk = 1;
> 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
