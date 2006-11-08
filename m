Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWKHT52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWKHT52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422759AbWKHT52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:57:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:64740 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422751AbWKHT51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:57:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=DHzzX+LtajolkzU+NxOBiHHVRmHbE7BqBSdVhblWiXiHFaEai4eGkrj+rkQqhqLmJW6+cvxbyhaS9ownP/ThY4TTn0mLKJfxI6GwqiUtsLvNZt/R8ynJ+A0yAZCflBZvqVJWF84+a4fjt6aF/lfbxV6LR9ItXzrmT9fZ04m/e5U=
Date: Wed, 8 Nov 2006 20:57:33 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci quirks: Sort out the VIA mess once and for all ?(hopefully)
Message-ID: <20061108195732.GA11067@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163003156.23956.40.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> ha scritto:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/include/linux/pci.h linux-2.6.19-rc4-mm1/include/linux/pci.h
> --- linux.vanilla-2.6.19-rc4-mm1/include/linux/pci.h    2006-10-31 21:11:50.000000000 +0000
> +++ linux-2.6.19-rc4-mm1/include/linux/pci.h    2006-11-07 10:07:06.000000000 +0000
> @@ -389,6 +390,21 @@
>        .vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
>        .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> 
> +/**
> + * PCI_VDEVICE - macro used to describe a specific pci device in short form
> + * @vend: the vendor name
> + * @dev: the 16 bit PCI Device ID
> + *
> + * This macro is used to create a struct pci_device_id that matches a
> + * specific PCI device.  The vendor, device, subvendor, and subdevice
> + * fields will be set to PCI_ANY_ID. The macro allows the next field

Hello Alan,
the comment doesn't match the macro: vendor and device are passed by the
caller, they're not PCI_ANY_ID.

> + * to follow as the device private data.
> + */
> + 
> +#define PCI_VDEVICE(vendor, device)            \
> +       PCI_VENDOR_ID_##vendor, (device),       \
> +       PCI_ANY_ID, PCI_ANY_ID, 0, 0
> +
> /* these external functions are only available when PCI support is enabled */
> #ifdef CONFIG_PCI

Luca
-- 
Recursion n.:
	See Recursion.
