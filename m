Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTD2MLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbTD2MLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:11:38 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:27658 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261821AbTD2MLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:11:37 -0400
Date: Tue, 29 Apr 2003 16:23:22 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030429162322.B5767@jurassic.park.msu.ru>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org> <20030429150532.A3984@jurassic.park.msu.ru> <wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrpvfwx5xcq.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Tue, Apr 29, 2003 at 01:58:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 01:58:29PM +0200, Marc Zyngier wrote:
> That's exactly what I wanted to avoid : It we feed NULL (for a non PCI
> device) to pci_map_single (for example), we limit the max DMA address
> to 24 bits, and this is quite bad for an EISA device, which is 32 bits
> capable.

Agreed, but what if your EISA-PCI bridge has only 30 address lines wired
to PCI? Yes, we can check this for EISA device because it has *real*
PCI parent (thanks, Marc :-), but what about ISA/legacy/whatever drivers?
I doubt that all of them bother to set dma_mask pointer (so you can have
an oops there).

Ivan.
