Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTFOH5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbTFOH5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:57:31 -0400
Received: from dp.samba.org ([66.70.73.150]:8080 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262001AbTFOH5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:57:30 -0400
Date: Sun, 15 Jun 2003 18:04:42 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
Message-ID: <20030615080442.GF31148@krispykreme>
References: <16097.36514.763047.738847@napali.hpl.hp.com> <20030607.001140.08328499.davem@redhat.com> <20030615070611.GE31148@krispykreme> <20030615.001107.88478922.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615.001107.88478922.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The hash table need not be sized wrt. ram, but rather to the expected
> amount of "DMA in flight" you can expect for the system.
>
> You have to make these tables per-IOMMU anyways, which breaks down the
> problem much further.

Thats turns out to be a problem because we can have a bunch of IOMMUs
on ppc64 - we might have 4 slots per IOMMU. Also, on a partitioned machine,
each slot gets an exclusive range of bus addresses to provide isolation
between adapters.

At the extreme end we might have 512GB of RAM and 48 IOMMUs. A hash
table per IOMMU could end up using a lot of RAM.

To make the best use of the IOMMU we would want to have it filled with
addresses (to have the best chance that we will find an existing
mapping). And for zero copy stuff it could be all over RAM. 
In effect we are looking at a mapping from 512GB -> 3GB. (assuming the
top 1GB of PCI addresses are for PCI IO and memory)

We also need a quick way to find old entries in order to purge them.

> ROFL, whose workstation name is krispykreme? :-)
> I just noticed that.

Hey thats my laptop :) One is opening up in Penrith Australia next
week, I may never need to visit the US again :)

Anton
