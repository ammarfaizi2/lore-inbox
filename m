Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVC1RgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVC1RgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVC1RgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:36:12 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:23138 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S261959AbVC1RgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:36:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: mmap/munmap on linux-2.6.11
Date: Mon, 28 Mar 2005 09:35:49 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301CD4D3A@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mmap/munmap on linux-2.6.11
Thread-Index: AcUxgKd2vzo1kzJiSoG3ZJBst1M3CACO7B/A
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <linux-os@analogic.com>, "Linux kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Mar 2005 17:36:07.0029 (UTC) FILETIME=[9F5A4A50:01C533BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of linux-os
>Sent: Friday, March 25, 2005 1:19 PM
>To: Linux kernel
>Subject: mmap/munmap on linux-2.6.11
>
>Memory gurus,
>
>We have an application where a driver allocates DMA-able memory.
>This DMA-able memory is mmap()ed to user-space. To conserve
>DMA memory only single pages are obtained using
>  __get_dma_pages(GFP_KERNEL, 1) (one page at a time). These
>pages, that may be scattered all about, are mmap()ed into contiguous
>user data-space. The DMA engine uses a scatter-list so we can
>write DMA pages anywhere. They don't have to be contiguous.
>
>Here's a catch. It would be nice to release those DMA pages
>when we don't need them. However, there doesn't appear to
>be any way for driver code to know when munmap() has been
>called and those DMA pages are available to be released.
>
>How do I know that munmap() has been called? It turns out
>that if I release those pages before unmapping the user-mode,
>the system will crash. Therefore this could be a DOS attack
>if my driver ever allowed the DMA pages to be released.

munmap() should do the job for you and release those automatically.

Aleks.
