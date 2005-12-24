Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVLXWoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVLXWoO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 17:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVLXWoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 17:44:14 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:48395
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S1750744AbVLXWoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 17:44:13 -0500
Date: Sat, 24 Dec 2005 14:44:12 -0800
From: Brad Boyer <flar@allandria.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/36] m68k: drivers/scsi/mac53c94.c __iomem annotations
Message-ID: <20051224224412.GB17645@pants.nu>
References: <E1EpIQf-0004tx-Oh@ZenIV.linux.org.uk> <20051224215633.GA17645@pants.nu> <20051224223230.GV27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051224223230.GV27946@ftp.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2005 at 10:32:30PM +0000, Al Viro wrote:
> Speaking of mac_esp, there's a pending patch for NCR53C9x.c fixing PIO
> breakage in esp_do_data().
> 		/* read fifo */
> 		for(j=0;j<fifocnt;j++)
> 			SCptr->SCp.ptr[i++] = esp_read(eregs->esp_fdata);
> 
> is not a good thing to do when we set .ptr to (char *)virt_to_phys_(....).
> 
> It works mostly by accident on e.g. 840AV, until you get a minimally
> non-trivial memory mapping.  The same thing happens on the write side.
> Fix is obvious (find phys_to_virt(SCptr->SCp.ptr) in the PIO branch
> and use it).  I've put that in -bird, will show up in tonight's snapshot...

It's only partly by accident. Early on in the development, someone put in
a fixed mapping with physical == virtual for the I/O space. Lots of the
drivers for internal devices on m68k macs take advantage of this and
use the physical addresses as pointers. They should be fixed, I guess.

> BTW, what's the situation with DMA on 840AV?  If you have any patches
> to test, I've got such box and being what it is, it's not tied by any
> work...

No, I haven't done much of anything with it. I do have a Q840AV, but the
DMA engine I really wanted to get working was the one on the IIfx. The
disk performance of the mac_scsi driver makes the IIfx nearly useless.
I almost got it working, but I can't figure out how to get the interrupts
for the DMA completion to work properly. The DMA for the AV models is
several steps down on my list at the moment. There are a couple other
people that have looked at it, but noone is especially active.

	Brad Boyer
	flar@allandria.com

