Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265540AbUAKAuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAKAuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:50:06 -0500
Received: from mail1.kontent.de ([81.88.34.36]:62438 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265540AbUAKAuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:50:02 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] Re: USB hangs
Date: Sun, 11 Jan 2004 01:49:34 +0100
User-Agent: KMail/1.5.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net>
In-Reply-To: <20040111002304.GE16484@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401110149.34654.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 11. Januar 2004 01:23 schrieb Matthew Dharm:
> Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
> down and eliminated them.
> 

static int ohci_mem_init (struct ohci *ohci)
{
	ohci->td_cache = pci_pool_create ("ohci_td", ohci->ohci_dev,
		sizeof (struct td),
		32 /* byte alignment */,
		0 /* no page-crossing issues */,
		GFP_KERNEL | OHCI_MEM_FLAGS);
	if (!ohci->td_cache)
		return -ENOMEM;
	ohci->dev_cache = pci_pool_create ("ohci_dev", ohci->ohci_dev,
		sizeof (struct ohci_device),
		16 /* byte alignment */,
		0 /* no page-crossing issues */,
		GFP_KERNEL | OHCI_MEM_FLAGS);
	if (!ohci->dev_cache)
		return -ENOMEM;
	return 0;
}

This one here looks dangerous.

	Regards
		Oliver

