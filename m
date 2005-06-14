Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVFNVTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVFNVTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVFNVTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:19:11 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:65131 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261341AbVFNVTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:19:06 -0400
Date: Tue, 14 Jun 2005 14:18:52 -0700
From: Greg KH <gregkh@suse.de>
To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial port driver 8250_pci - pci_device_id structure
Message-ID: <20050614211852.GA20037@suse.de>
References: <1118783140.7069.12.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118783140.7069.12.camel@siliver.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 04:05:40PM -0500, V. ANANDA KRISHNAN wrote:
> Hi All,
> 
>   In ppc architecture, I am trying to find out the codes that populate
> the pci_devic_id structure ( drivers/serial/8250_pci.c file) in the
> following init_one function:
> 
> static int __devinit
> pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)

It comes from the driver itself, as you point out:

>   I have the (pci card) data hard-coded in the following tables of
> 8250_pci.c file:
>           static struct pci_device_id serial_pci_tbl[]
>           static struct pci_board pci_boards[] __devinitdata={...}

Yup, that's what the pci core sets that pointer to.

> Since I could not find the data in the pci_device_id for pci card, I
> went thru the drivers/pci/search.c and drivers/pci/pci-driver.c files. I
> am not successful in locating those codes that populate the
> pci_device_id structure for a given pci card.

drivers/pci/pci-driver.c::pci_device_probe_static() does it.  See the
latest edition of the Linux Device Drivers book for a full description
and walk-through of how a pci device get added and removed from the
driver core (it's free online if you don't want to buy it.)

Hope this helps,

greg k-h
