Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVBAQ5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVBAQ5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBAQ5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:57:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:50590 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262070AbVBAQ5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:57:12 -0500
Date: Tue, 1 Feb 2005 08:54:34 -0800
From: Greg KH <greg@kroah.com>
To: Aurelien Jarno <aurelien@aurel32.net>, Alexey Dobriyan <adobriyan@mail.ru>,
       linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
Message-ID: <20050201165434.GD23118@kroah.com>
References: <200502011420.17466.adobriyan@mail.ru> <20050201121414.GA15219@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201121414.GA15219@bode.aurel32.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 01:14:14PM +0100, Aurelien Jarno wrote:
> +/* Locate SiS bridge and correct base address for SIS5595 */
> +static int sis5595_find_sis(int *address)
> +{
> +	u16 val;
> +	int *i;
> +
> +	if (!(s_bridge =
> +	    pci_get_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503, NULL)))
> +		return -ENODEV;

You never free the reference you grabbed on the pci_dev here.  Please
read the docs on how pci_get_device() is to be used, it isn't just a
drop in replacement for pci_find_device(), sorry.

> +	/* Look for imposters */
> +	for(i = blacklist; *i != 0; i++) {
> +		if (pci_get_device(PCI_VENDOR_ID_SI, *i, NULL)) {

Same here, you are leaking a reference count.

Why are you not using the pci driver interface instead?

thanks,

greg k-h
