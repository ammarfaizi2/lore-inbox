Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWGCVzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWGCVzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWGCVzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:55:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:45714 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932090AbWGCVzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:55:50 -0400
Date: Mon, 3 Jul 2006 14:55:34 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep seeing zones on various platforms that are never used and wonder
why we compile support for them into the kernel.

IA64 on SGI for example only uses ZONE_DMA other IA64 platforms can
also use ZONE_NORMAL. So we have 50% useless zones. Large amounts
of memory go to waste with systems with a few hundred nodes and a few
hundred processors.

My x86_64 system seems to only use ZONE_DMA and ZONE_DMA32. I never see pages
in ZONE_NORMAL (probably because I have less than 4G memory).

And ZONE_HIGHMEM on a 64 bit system? We can address all memory. I keep
seeing all the highmem counters as zero on ia64 and x86_64 and even on
i386 systems.

Then it seems that ZONE_DMA32 is only used on x86_64 but we compile it into
the kernel for all platforms.

This patch makes ZONE_DMA32 and ZONE_HIGHMEM support optional. MAX_NR_ZONES
will be 2 for most non i386 platforms and even for i386 without CONFIG_HIGHMEM
set.

I tested this on IA64 and x86_64. Compiles fine on i386 with and without
CONFIG_HIGHMEM set.

The patchset consists of 8 patches that are following this message.

One could go even further than this patchset and also make ZONE_DMA optional
because some platforms do not need a separate DMA zone and can do DMA to all
of memory. This could reduce MAX_NR_ZONES to 1.

