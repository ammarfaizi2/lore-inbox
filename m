Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbUCMOj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 09:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUCMOj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 09:39:58 -0500
Received: from av7-2-sn2.hy.skanova.net ([81.228.8.109]:42134 "EHLO
	av7-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S263102AbUCMOj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 09:39:57 -0500
Message-ID: <40531D3D.2090702@comhem.se>
Date: Sat, 13 Mar 2004 15:39:57 +0100
From: Danjel McGougan <danjel.mcgougan@comhem.se>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
References: <1z8Na-5hH-1@gated-at.bofh.it>
In-Reply-To: <1z8Na-5hH-1@gated-at.bofh.it>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Rittmeyer wrote:
> copy_tofrom_user and copy_page use dcbt to prefetch source data [1].
> Since at least 2.4.17, these functions have been prefetching
> beyond the end of the source buffer, leading to two problems:
> 
> 1. Subtly broken software cache coherency. If the area following src
> was invalidate_dcache_range'd prior to submitting for DMA,
> an out-of-bounds dcbt from copy_to_user of a separate slab object
> may read in the area before DMA completion. When the DMA does complete,
> data will not be loaded from RAM because stale data is already in cache.
> Thus you get a corrupt network packet, bogus audio capture, etc.
> 
[snip]

I am no expert on the ppc arch, but in my humble opinion it seems 
strange to invalidate the dcache *before* the memory-writing 
DMA-transaction. The obvious solution is to invalidate the dcache 
*after* DMA completion. It seems hard to guarantee that nobody will 
touch the memory area in question during the DMA.

Just some clue-less comments from a linux-kernel lurker.

Regards,
Danjel
