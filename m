Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVAaS0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVAaS0P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVAaS0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:26:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:53191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261300AbVAaS0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:26:07 -0500
Date: Mon, 31 Jan 2005 10:21:48 -0800
From: Greg KH <greg@kroah.com>
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
Message-ID: <20050131182148.GA21438@kroah.com>
References: <20050125220945.GA23560@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125220945.GA23560@bode.aurel32.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:09:45PM +0100, Aur?lien Jarno wrote:
> +/* Locate SiS bridge and correct base address for SIS5595 */
> +static int sis5595_find_sis(int *address)
> +{
> +	u16 val;
> +	int *i;
> +
> +	if (!(s_bridge =
> +	    pci_find_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL)))

Please use pci_get_device().  It's safer, and not a depreciated
function.

> +	/* Look for imposters */
> +	for(i = blacklist; *i != 0; i++) {
> +		if (pci_find_device(PCI_VENDOR_ID_SI, *i, NULL)) {

Same here.

> +			printk("sis5595.ko: Error: Looked for SIS5595 but found unsupported device %.4X\n", *i);

<snip>

> +		printk("sis5595.ko: base address not set - upgrade BIOS or use force_addr=0xaddr\n");

These printk() calls need a KERN_ level.  Why not use the dev_* calls
instead?  You have a pci_dev to use here, right?

thanks,

greg k-h
