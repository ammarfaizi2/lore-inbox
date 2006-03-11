Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752299AbWCKC07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbWCKC07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWCKC07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:26:59 -0500
Received: from [198.78.49.142] ([198.78.49.142]:61956 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1752295AbWCKC06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:26:58 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
Date: Fri, 10 Mar 2006 18:27:59 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060311022759.3950.58788.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is the a full release of the Intel(R) I/O
Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
engine, and changes to the TCP stack to offload copies of received
networking data to application space.

Changes from last weeks posting:
  fixed return value from sysfs show functions as suggested by Joe Perches
  code style fixes suggested by Andrew Morton, David Miller, and others
  renamed anything related to pinning pages from lock/locked to pin/pinned
  renamed ioatdma register read/write functions with less generic names
  return a pinned list from dma_pin_iovec_pages instead of passing in a 
	**dma_pinned_list
  replaced all cb/CB symbol prefixes in ioatdma with ioat/IOAT,
	CB was an abbreviation of an early code name
  use set_page_dirty_lock instead of SetPageDirty pointed out by Andrew Morton
  rename dma_async_try_early_copy to tcp_dma_try_early_copy and stop exporting

I'll be focusing on reducing ifdefs and adding much needed comments, with
another release early next week. 

These changes apply to DaveM's net-2.6.17 tree as of commit
32639ad6b7e3da27f233c0516471f0747f1178f5 ([SPARC]: Fixup SO_*SEC values on 32-bit sparc.)

They are available to pull from
	git://198.78.49.142/~cleech/linux-2.6 ioat-2.6.17

There are 8 patches in the series:
	1) The memcpy offload APIs and class code
	2) The Intel I/OAT DMA driver (ioatdma)
	3) Core networking code to setup networking as a DMA memcpy client
	4) Utility functions for sk_buff to iovec offloaded copy
	5) Structure changes needed for TCP receive offload
	6) Rename cleanup_rbuf to tcp_cleanup_rbuf
	7) Add a sysctl to tune the minimum offloaded I/O size for TCP
	8) The main TCP receive offload changes

--
Chris Leech <christopher.leech@intel.com>
I/O Acceleration Technology Software Development
LAN Access Division / Digital Enterprise Group 
