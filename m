Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWCBNot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWCBNot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWCBNot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:44:49 -0500
Received: from ns.suse.de ([195.135.220.2]:37091 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751015AbWCBNos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:44:48 -0500
From: Andi Kleen <ak@suse.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Date: Thu, 2 Mar 2006 14:46:46 +0100
User-Agent: KMail/1.9.1
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
References: <200603020023.21916@zmi.at> <200603021433.17235.ak@suse.de> <20060302133322.GQ4329@suse.de>
In-Reply-To: <20060302133322.GQ4329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021446.46352.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 14:33, Jens Axboe wrote:

> Hmm I would have guessed the first is way more common, the device/driver
> consuming lots of iommu space would be the most likely to run into
> IOMMU-OOM.

e.g. consider a simple RAID-1. It will always map the requests twice so the 
normal case is 2 times as much IOMMU space needed. Or even more with bigger 
raids.

But you're right of course that only waiting for one user would be likely
sufficient. e.g. even if it misses some freeing events the "current" device
should eventually free some space too.

On the other hand it would seem cleaner to me to solve it globally
instead of trying to hack around it in the higher layers.

>
> I was thinking just a global one, we are in soft error handling anyways
> so should be ok. I don't think you would need to dirty any global cache
> line unless you actually need to wake waiters.

__wake_up takes the spinlock even when nobody waits.

-Andi
