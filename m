Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVCYVTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVCYVTP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVCYVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:19:15 -0500
Received: from alog0128.analogic.com ([208.224.220.143]:20451 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261290AbVCYVTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:19:11 -0500
Date: Fri, 25 Mar 2005 16:19:03 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: mmap/munmap on linux-2.6.11
Message-ID: <Pine.LNX.4.61.0503251541420.4959@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Memory gurus,

We have an application where a driver allocates DMA-able memory.
This DMA-able memory is mmap()ed to user-space. To conserve
DMA memory only single pages are obtained using
  __get_dma_pages(GFP_KERNEL, 1) (one page at a time). These
pages, that may be scattered all about, are mmap()ed into contiguous
user data-space. The DMA engine uses a scatter-list so we can
write DMA pages anywhere. They don't have to be contiguous.

Here's a catch. It would be nice to release those DMA pages
when we don't need them. However, there doesn't appear to
be any way for driver code to know when munmap() has been
called and those DMA pages are available to be released.

How do I know that munmap() has been called? It turns out
that if I release those pages before unmapping the user-mode,
the system will crash. Therefore this could be a DOS attack
if my driver ever allowed the DMA pages to be released.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
