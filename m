Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUBQEuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUBQEuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:50:11 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:15088 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265978AbUBQEuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:50:06 -0500
Subject: Non-PCI build broken on sparc64, maybe others
From: David Dillow <dave@thedillows.org>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1076993402.21443.5.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Feb 2004 23:50:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this changeset in Linus's tree:
======== ChangeSet 1.1500.12.4 ========
D 1.1500.12.4 04/02/02 11:04:46-08:00 dsaxena@plexity.net 35779 35702 5/0/1
P ChangeSet
C [PATCH] PCI: Replace pci_pool with generic dma_pool
C
C - Move drivers/pci/pool.c to drivers/base/pool.c
C - Initialize struct device.dma_pools in device_initialize()
C - Remove initialization of struct pci_dev.pools from pci_setup_device()
------------------------------------------------

with key: dsaxena@plexity.net|ChangeSet|20040202190446|51997

breaks builds that do not include PCI support.

If I set CONFIG_PCI=y, it builds. If not, I get:
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x2056c): In function `pool_alloc_page':
: undefined reference to `dma_alloc_coherent'
drivers/built-in.o(.text+0x2060c): In function `pool_free_page':
: undefined reference to `dma_free_coherent'
make: *** [.tmp_vmlinux1] Error 1

while building BK-latest for my Ultra1.

Just a heads up,
Dave
