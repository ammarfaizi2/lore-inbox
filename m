Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWHAGMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWHAGMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWHAGMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:12:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6610
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161136AbWHAGMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:12:41 -0400
Date: Mon, 31 Jul 2006 23:11:58 -0700 (PDT)
Message-Id: <20060731.231158.91311705.davem@davemloft.net>
To: dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org, neilb@suse.de, galak@kernel.crashing.org,
       christopher.leech@intel.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH rev2 1/4] dmaengine: enable mutliple clients and
 operations
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
References: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can I ask that the known bugs in the I/O AT DMA code be fixed
before we start adding new features to it?

Specifically, the lock_cpu_hotplug() call in net_dma_rebalance()
is still there and being invoked with a spinlock held.  The
spinlock is grabbed by the caller, netdev_dma_event() which
grabs the net_dma_event_lock spinlock.

You cannot invoke lock_cpu_hotplug() while holding a spinlock
because lock_cpu_hotplug(), as seen in kernel/cpu.c, takes
a semaphore which can sleep.  Sleeping while holding a spinlock
is not allowed.

This is the second time I have tried to make the Intel developers
aware of this bug.  So please fix this problem.

Thanks a lot.
