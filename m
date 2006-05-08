Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWEHWNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWEHWNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEHWNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:13:09 -0400
Received: from [63.64.152.142] ([63.64.152.142]:18693 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751276AbWEHWNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:13:08 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 0/9] I/OAT network recv copy offload
Date: Mon, 08 May 2006 15:16:32 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060508221632.15181.50046.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few changes after going over all the memory allocations, but mostly just
keeping the patches up to date.

This patch series is the a full release of the Intel(R) I/O
Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
engine, and changes to the TCP stack to offload copies of received
networking data to application space.

Changes from last posting:
	Fixed a struct ioat_dma_chan memory leak on driver unload.
	Changed a lock that was never held in atomic contexts to a mutex
	as part of avoiding unneeded GFP_ATOMIC allocations.

These changes apply to Linus' tree as of commit
	6810b548b25114607e0814612d84125abccc0a4f
	[PATCH] x86_64: Move ondemand timer into own work queue

They are available to pull from
	git://63.64.152.142/~cleech/linux-2.6 ioat-2.6.17

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
