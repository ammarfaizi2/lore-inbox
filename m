Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271266AbTHMAL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271270AbTHMAL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:11:26 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:20895 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271266AbTHMALZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:11:25 -0400
Date: Tue, 12 Aug 2003 20:11:22 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200308130011.h7D0BME29033@devserv.devel.redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: consistent_dma_mask is a ghost?
In-Reply-To: <mailman.1060643897.16128.linux-kernel2news@redhat.com>
References: <mailman.1060643897.16128.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This means that only _two_ platforms, ia64 and x86_64, have means to use
> that information, and other platforms use set_dma_mask() and dev->dma_mask
> for consistent (coherent) allocations ignoring consistent_dma_mask at all
> (and possibly allocating memory from invalid region, if the masks are
> not equal).

Platforms which worked correctly before continue to work
correctly thereafter. IMHO, the whole thing is a kludge,
designed to support AIC7xxx on SGI SN-2, and that's about
all it does. There's a device which uses fewer DMA bits
when it accesses its mailbox than when it accesses data.
Since the mailbox is allocated in consistent memory, this
can be used as a clue to restrict the allocation. This is a
fragile, opaque construct and it's conceptually wrong (what if
the driver accessed device mailboxes through streaming mappings?),
but it works for its purpose. Just don't use it in your drivers
and you'll be fine.

-- Pete
