Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVA2PNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVA2PNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVA2PNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:13:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33294 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262925AbVA2PNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:13:51 -0500
Date: Sat, 29 Jan 2005 15:13:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
Message-ID: <20050129151346.B12311@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	LKML <linux-kernel@vger.kernel.org>, wbsd-devel@list.drzeus.cx
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx> <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org> <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050129150023.GA959@infradead.org>; from hch@infradead.org on Sat, Jan 29, 2005 at 03:00:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 03:00:23PM +0000, Christoph Hellwig wrote:
> Either way a new driver shouldn't use isa_virt_to_bus at all but rather
> use the proper DMA API and all those problems go away.

One thing which comes up in this instance is: what struct device should
be used.

With ISA devices doing DMA, the device which actually "owns" the DMA
is the ISA DMA controller, not the device wiggling its DMA request
signal to the ISA DMA controller.

Given that, shouldn't the ISA DMA code have its own struct device to
represent the ISA DMA engine for things like the floppy driver and
other drivers using the ISA DMA engine?

To me, it makes no sense to pass the ISA device wiggling its DMA request
into the DMA API - this ISA device doesn't care whether the ISA DMA engine
can only access the first 16MB of memory or not (which is ISA DMA engine
specific), so the DMA mask on the ISA device is rather meaningless.

(This type of DMA also appears on later ARM platforms as well, hence
why I have given the whole issue some thought.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
