Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275319AbTHMSgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275337AbTHMSgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:36:18 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:62635 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S275319AbTHMSgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:36:09 -0400
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: consistent_dma_mask is a ghost?
References: <mailman.1060643897.16128.linux-kernel2news@redhat.com>
	<200308130011.h7D0BME29033@devserv.devel.redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 13 Aug 2003 16:51:11 +0200
In-Reply-To: <200308130011.h7D0BME29033@devserv.devel.redhat.com>
Message-ID: <m3n0ed6274.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> Platforms which worked correctly before continue to work
> correctly thereafter. IMHO, the whole thing is a kludge,
> designed to support AIC7xxx on SGI SN-2, and that's about
> all it does.

I'm a little confused. I assume the driver is not in the official tree
and this SN-2 uses either Itanium or Opteron CPU.

> There's a device which uses fewer DMA bits
> when it accesses its mailbox than when it accesses data.
> Since the mailbox is allocated in consistent memory, this
> can be used as a clue to restrict the allocation. This is a
> fragile, opaque construct and it's conceptually wrong (what if
> the driver accessed device mailboxes through streaming mappings?),
> but it works for its purpose. Just don't use it in your drivers
> and you'll be fine.

Right, but at least the documentation needs a fix. I also have a device
which needs different masks for streaming and consistent allocations
(4 GB for DMA streaming but only 256 MB for memory shared directly between
main CPU and on-board one) and I was hoping that setting the consistent
dma mask to 256MB (-1) would actually have some meaning (while it's NOP
on most platforms).

The question is: would it be better to only fix the docs to reflect
reality, or let the kludge die and fix AIC7xxx driver instead?
I understand it could be trivially done in the driver, i.e. by setting
dma_mask to correct value just before the consistent allocation is
requested. It should have little impact (if any) on performance, even
if the driver needs it for normal operation rather than for init only.


Or, should we do it the other way around? Instead of fixing docs,
we can fix the code to actually support setting the consistent dma mask
reliably (at least the easy part).
-- 
Krzysztof Halasa
Network Administrator
