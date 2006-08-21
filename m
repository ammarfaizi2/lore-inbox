Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWHUQDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWHUQDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWHUQDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:03:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65258 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422685AbWHUQDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:03:40 -0400
Subject: Re: disabling dma/new ide interface 2.6.18-rc4-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bahadir Balban <bahadir.balban@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7ac1e90c0608210727m1c5375b9xb936168c877084c@mail.gmail.com>
References: <7ac1e90c0608210727m1c5375b9xb936168c877084c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 17:24:52 +0100
Message-Id: <1156177492.18887.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-21 am 15:27 +0100, ysgrifennodd Bahadir Balban:
> Hi,
> 
> I am trying to implement a basic ide driver based on ata_generic.c.
> Its a pio-only device.
> 
> How do I disable dma on the new interface? Changing ata_port_info fields?

ata_generic.c assumes the BIOS set up the timings and the device follows
PCI SFF. In those cases it already correctly handles PIO only
controllers.

If you are trying to write a driver for a non PCI motherboard device (Eg
on an embedded board) then drivers/ata/pata_qdi.c may be a better
example to follow as it sets up all the device ports by hand as a
platform device.

If you want PIO only then don't provide mwdma or udma mode masks in the
ata_port_info.

Alan

