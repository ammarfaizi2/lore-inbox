Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVKAEup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVKAEup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVKAEup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:50:45 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:24932 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964934AbVKAEuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:50:44 -0500
From: David Brownell <david-b@pacbell.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Don't touch USB controllers with MMIO disabled in quirks
Date: Mon, 31 Oct 2005 20:50:41 -0800
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, torvalds@osdl.org, Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <17254.59690.713323.294726@cargo.ozlabs.ibm.com>
In-Reply-To: <17254.59690.713323.294726@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312050.42008.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 8:03 pm, Paul Mackerras wrote:

>  static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
>  {
> +	u16 cmd;
> +
> +	if (pci_read_config_word(pdev, PCI_COMMAND, &cmd) ||
> +	    (cmd & PCI_COMMAND_MEMORY) == 0)

I suspect that should be

	(tabs)	|| (cmd & (PCI_COMMAND_MEMORY|PCI_COMMAND_IO)) == 0

Admittedly that'll matter only for UHCI, which isn't much used out of
x86 and ia64 ... but testing for both is more correct.  Other than that,
this looks good to me.

- Dave


> +		return;
>  	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
>  		quirk_usb_handoff_uhci(pdev);
>  	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
> 
