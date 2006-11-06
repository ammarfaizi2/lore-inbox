Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752946AbWKFMqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbWKFMqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbWKFMqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:46:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:736 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752947AbWKFMqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:46:35 -0500
Subject: Re: [PATCH] add pci revision id to struct pci_dev
From: Arjan van de Ven <arjan@infradead.org>
To: Conke Hu <conke.hu@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
References: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 13:46:33 +0100
Message-Id: <1162817193.3138.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 20:40 +0800, Conke Hu wrote:
> Hi all,
>     PCI revision id had better be added to struct pci_dev and
> initialized in pci_scan_device.
> 
>     Signed-off-by: Conke Hu <conke.hu@gmail.com>

Hi,

it's customary to use the email address from the copyright holder (eg
your employer, AMD) in the Signed-off-by line.

> 
> -----
> diff -Nur linux-2.6.19-rc4-git10.orig/drivers/pci/probe.c
> linux-2.6.19-rc4-git10/drivers/pci/probe.c
> --- linux-2.6.19-rc4-git10.orig/drivers/pci/probe.c     2006-11-06
> 19:38:43.000000000 +0800

and your patch is word wrapped...

> +++ linux-2.6.19-rc4-git10/drivers/pci/probe.c  2006-11-06
> 19:41:17.000000000 +0800
> @@ -785,6 +785,7 @@
>        u32 l;
>        u8 hdr_type;
>        int delay = 1;
> +       u8 rev;
> 
>        if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &l))
>                return NULL;
> @@ -813,6 +814,9 @@
>        if (pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type))
>                return NULL;
> 
> +       if (pci_bus_read_config_byte(bus, devfn, PCI_REVISION_ID, &rev))
> +               return NULL;
> +
>        dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
>        if (!dev)
>                return NULL;
> @@ -828,6 +832,7 @@
>        dev->device = (l >> 16) & 0xffff;
>        dev->cfg_size = pci_cfg_space_size(dev);
>        dev->error_state = pci_channel_io_normal;
> +       dev->revision = rev;
> 
>        /* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
>           set this higher, assuming the system even supports it.  */
> diff -Nur linux-2.6.19-rc4-git10.orig/include/linux/pci.h
> linux-2.6.19-rc4-git10/include/linux/pci.h
> --- linux-2.6.19-rc4-git10.orig/include/linux/pci.h     2006-11-06
> 19:39:07.000000000 +0800
> +++ linux-2.6.19-rc4-git10/include/linux/pci.h  2006-11-06
> 19:41:57.000000000 +0800
> @@ -123,6 +123,7 @@
>        unsigned short  device;
>        unsigned short  subsystem_vendor;
>        unsigned short  subsystem_device;
> +       u8              revision;       /* PCI revision ID */
>        unsigned int    class;          /* 3 bytes: (base,sub,prog-if) */
>        u8              hdr_type;       /* PCI header type (`multi'
> flag masked out) */

pretty badly in fact.


can you resend it without the word wrappings ?

It looks good to me otherwise....


