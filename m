Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVAEBzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVAEBzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVAEBzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:55:46 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35767 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262086AbVAEBzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:55:24 -0500
Subject: Re: libata PATA support - work items?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eric Mudama <edmudama@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Albert Lee <albertcc@tw.ibm.com>, IDE Linux <linux-ide@vger.kernel.org>,
       Doug Maxey <dwm@maxeymade.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <41DB299C.3030405@pobox.com>
References: <006301c4ee5c$49e6a230$95714109@tw.ibm.com>
	 <311601c9050101111929aef5ba@mail.gmail.com>  <41DB299C.3030405@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104886199.17176.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 00:50:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 23:41, Jeff Garzik wrote:
> So, that said, I think it is important for libata to fully support PATA, 
> if it is to support it at all.  That means handling the errata that Alan 
> always bugs me about, and that means handling C/H/S support as well.

I think so. If it supports all the features of the old IDE layer we get
to have a party when we eliminate the need for drivers/ide once and for
all.

That means
- Hotplug (controller and disk)
- CHS
- "Not quite generic" IDE DMA (eg CS5520)
- VDMA (eg CS5520)
- IORDY timers (not handled well in drivers/ide but needed)
- Funky Maxtor "LBA48.. maybe" oddments
- Missing slave detection
- Controller errata hooks (modes, drives, timings, "dont touch during an
I/O" etc)
- Drive nIEN bugs
- No nIEN cases
- Drives that don't do some DMA/modes right
- Crazy shit "Don't DMA from the page below 640K" (not handled by
drivers/ide but an AMD errata
	fixed by using a PS/2 mouse)
- Serialize (RZ1000, CMD640, some 469, etc)
- Bandwidth arbiter (not in drivers/ide but needed)
- Non PCI shared IRQ mess 8(

Hopefully most of this can be buried away in a pata-errata.c 8)

