Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWCPFye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWCPFye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWCPFye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:54:34 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:57633 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932671AbWCPFyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:54:33 -0500
X-IronPort-AV: i="4.02,196,1139212800"; 
   d="scan'208"; a="314796535:sNHT25144612"
To: Andrew Morton <akpm@osdl.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Hugh@veritas.com,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 21:54:30 -0800
In-Reply-To: <20060315213813.747b5967.akpm@osdl.org> (Andrew Morton's message of "Wed, 15 Mar 2006 21:38:13 -0800")
Message-ID: <ada8xrbszmx.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 05:54:32.0607 (UTC) FILETIME=[18F0FAF0:01C648BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Someone left PG_private set on this page (!)

How does PG_private get set?  Could doing a > 1 page kmalloc set it
(because we end up with a compound page)?

    Andrew> You need to decide who "owns" these pages.  Once that's
    Andrew> decided, it tells you who should release them.

    [... really good guide to mapping pages into userspace snipped ...]

How about the case where one wants to map pages from
dma_alloc_coherent() into userspace?  It seems one should do
get_page() in .nopage, and then the driver can do dma_free_coherent()
when the vma is released.

Or maybe it's just simpler to use vm_insert_page() in the .mmap method
and not try to be fancy with .nopage?

 - R.
