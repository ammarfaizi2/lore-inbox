Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTILHLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 03:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTILHLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 03:11:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57267 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261151AbTILHLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 03:11:12 -0400
Date: Fri, 12 Sep 2003 09:11:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030912071106.GC16813@suse.de>
References: <20030909110112.4d634896.skraw@ithnet.com> <16225.13206.910616.386713@notabene.cse.unsw.edu.au> <20030912085435.6a26fec4.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912085435.6a26fec4.skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12 2003, Stephan von Krawczynski wrote:
> > My only guess is that it is doing a lot of copying into low memory
> > because your devices can only DMA into/outof low memory.
> 
> I forgot to mention: Both network card and controller are 64 bit cards.
> Network card is (vendor 3com):
> Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet
> (rev 15) (tg3-driver)
> Controller is:
> RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
> I have "CONFIG_HIGHIO=y"

That is not enough, the 3ware driver only sets a 32-bit IO capability
mask. So you will still be bouncing to/from the upper 2G, Neils
diagnosis is absolutely right. If you want to verify this fact, boot
with profile=2 and run readprofile -r; updatedb; readprofile | sort -nr
and you should see the bounce copy functions near the top.

As a paying customer, you should ask 3ware about their hardware. They
might be able to support > 32-bit dma just noone has asked about this
feature yet. A quick peek at their driver shows they define their sg
address element as a 32-bit quantity, so maybe not...

-- 
Jens Axboe

