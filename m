Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161629AbWJaJTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161629AbWJaJTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161630AbWJaJTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:19:13 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:10427 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S1161629AbWJaJTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:19:12 -0500
Message-ID: <4547150F.8070408@ti.uni-mannheim.de>
Date: Tue, 31 Oct 2006 10:19:11 +0100
From: Guillermo Marcus <marcus@ti.uni-mannheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmaping a kernel buffer to user space
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently run with the following situation while developing a PCI
driver. The driver allocates memory for a PCI device using
pci_alloc_consistent as this memory is going to be used to perform DMA
transfers. To pass the data from/to the user application, I mmap the
buffer into userspace. However, if I try to use remap_pfn_range
(>=2.6.10) or the older remap_page_range(<=2.6.9) for mmaping, it ends
up creating a new buffer, because they do not support RAM mapping, then
pagefaulting to the VMA and by default allocating new pages. Therefore,
I had to implement the nopage method and mmap one page at a time as they
fault.

However, to my point of view, this is unnecessary. The memory is already
allocated, the memory is locked because it is consistent, and it may be
a (very small) performance and stability issue to do them one-by-one.
Why can't I simply mmap it all at once? am I missing some function? More
important, why can't remap_{pfn/page}_range handle it?


Best wishes,
Guillermo Marcus

Note: I am using kernel 2.6.9 for these tests, as it is required by my
current setup. Maybe this issue has already been addressed in newer
kernel. If that is the case, please let me know.
