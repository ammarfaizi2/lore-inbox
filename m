Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTJ0Q5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbTJ0Q5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:57:33 -0500
Received: from havoc.gtf.org ([63.247.75.124]:43190 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263356AbTJ0Q5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:57:31 -0500
Date: Mon, 27 Oct 2003 11:57:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Oliver M. Bolzer" <oliver@gol.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t9 libata: Promise FastTrak S150 TX4 not working
Message-ID: <20031027165730.GC19711@gtf.org>
References: <20031027151505.GB10432@magi.fakeroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027151505.GB10432@magi.fakeroot.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 04:15:05PM +0100, Oliver M. Bolzer wrote:
> Several weeks ago, I tested without success the 2.4.22-bk32-libata1
> patch with my Promise FastTrak S150 TX4 controller. Seeing that
> 2.6.0-test9 merged libata, I tryed again, without success.
> 
> 4 drives are connected to the controller and are configured as 4
> seperate arrays (the thing doesn't have a non-RAID-mode) that are
> working with Promise's partially-binary-only ft3xx driver on 2.4.22.
> 
> Below are the contents of /proc/pci on the machine and dmesg output
> with ATA_DEBUG and ATA_VERBOSE_DEBUG enabled. As it seemed that it
> could not soft-reset the ports, I also compiled the driver without
> the ATA_FLAG_SRST flag for my controller. It looks like the driver
> can recognize the arrays this way but then the kernel enters some
> kind of endless-loop after DMA timeouts. The dmesg output without
> ATA_FLAG_SRST ist also included below. 
> 
> In both cases, the actual error seems to be
> ATA: abnormal status 0x80 on port 0xF881321C
> 
> As I got 8 identical machines with only 3 currenly in beta-use, I'm
> ready to test any kind of patches to help improve the driver.

Wow, this is an excellent bug report.

Yes, it looks like I will need to use a Promise-specific reset
mechanism, rather than one of the three generic mechanisms:
EXECUTE DEVICE DIAGNOSTIC (no flags), ATA software reset
(ATA_FLAG_SRST), and Serial ATA COMRESET (ATA_FLAG_SATA_RESET).

I would prefer to switch both VIA and Promise drivers over to
ATA_FLAG_SATA_RESET.

	Jeff



