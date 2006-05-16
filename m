Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWEPQle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWEPQle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWEPQle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:41:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:45014 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932136AbWEPQld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:41:33 -0400
Subject: Funnies with remap_pfn_range, x86_64, > 4GB RAM, kernels < 2.6.16
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Discuss@x86-64.org
Content-Type: text/plain
Date: Tue, 16 May 2006 09:41:46 -0700
Message-Id: <1147797706.3801.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I was preparing the ipath driver for submission, I got rid of our
accursed vmops->nopage routine and replaced it with the much simpler use
of remap_pfn_range.

Unfortunately, we've recently been testing this code on machines with
more than 4GB of memory, and found that it is not working reliably on
kernels older than 2.6.16.  As far as I can tell, every prior kernel
back to 2.6.9 is affected.

The symptom occurs when we use remap_pfn_range to map some driver memory
(allocated with dma_alloc_coherent) into userspace, and get the hardware
to DMA into that memory range.  The physical and virtual addresses all
look OK; the DMA from the hardware appears to succeed; but the pages
written to do not show any changes, most of the time (occasionally it
works, but we don't know why).

These problems do not occur with 2.6.16, so this looks like a kernel bug
that got fixed somewhere.  What I'm wondering is (a) does anyone
remember fixing this, because I can't see anything obvious in the myriad
of likely contenders, and (b) has anyone else been faced with this
problem and found a workaround for older kernels?

Thanks,

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

