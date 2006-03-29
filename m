Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWC2Wws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWC2Wws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWC2Wws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:52:48 -0500
Received: from [198.78.49.142] ([198.78.49.142]:36357 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751145AbWC2Wwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:52:47 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 0/9] I/OAT
Date: Wed, 29 Mar 2006 14:55:05 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060329225505.25585.30392.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is the a full release of the Intel(R) I/O
Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
engine, and changes to the TCP stack to offload copies of received
networking data to application space.

Changes from last posting:
	Fixed a page reference leak that happened when offloaded copies were 
	set up but never used for a recv.
	Fixed the ioatdma self test to handle failures correctly.
	Serialized DMA ADD and REMOVE events in the networking core with a lock.
	Added a long comment in dmaengine.c to describe the locking and 
	reference counting being used.
	Disabled preempt around a use of get_cpu_var.
	Made tcp_dma_try_early_copy static, it is only used in one file.
	Made some GFP_ATOMIC allocations GFP_KERNEL where safe to sleep.
	Made changes to sk_eat_skb, removing some ifdefs in the TCP code.
	

These changes apply to DaveM's net-2.6.17 tree as of commit
68907dad58cd7ef11536e1db6baeb98b20af91b2 ([DCCP]: Use NULL for pointers, comfort sparse.)

They are available to pull from
	git://198.78.49.142/~cleech/linux-2.6 ioat-2.6.17

There are 9 patches in the series:
	1) The memcpy offload APIs and class code
	2) The Intel I/OAT DMA driver (ioatdma)
	3) Core networking code to setup networking as a DMA memcpy client
	4) Utility functions for sk_buff to iovec offloaded copy
	5) Structure changes needed for TCP receive offload
	6) Rename cleanup_rbuf to tcp_cleanup_rbuf
	7) Make sk_eat_skb aware of early copied packets
	8) Add a sysctl to tune the minimum offloaded I/O size for TCP
	9) The main TCP receive offload changes

--
Chris Leech <christopher.leech@intel.com>
I/O Acceleration Technology Software Development
LAN Access Division / Digital Enterprise Group 
