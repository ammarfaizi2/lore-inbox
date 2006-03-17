Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWCQSTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWCQSTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 13:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWCQSTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 13:19:48 -0500
Received: from gold.veritas.com ([143.127.12.110]:5936 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030252AbWCQSTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 13:19:47 -0500
X-IronPort-AV: i="4.03,105,1141632000"; 
   d="scan'208"; a="57339987:sNHT30515028"
Date: Fri, 17 Mar 2006 18:20:12 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: "Bryan O'Sullivan" <bos@pathscale.com>, Roland Dreier <rdreier@cisco.com>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace (was: [PATCH 10 of 20] ipath
 - support for userspace apps using core driver)
In-Reply-To: <Pine.LNX.4.64.0603170921470.3618@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0603171813390.1099@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
  <adad5gmne20.fsf_-_@cisco.com>  <Pine.LNX.4.61.0603171631240.32660@goblin.wat.veritas.com>
 <1142615848.28538.53.camel@serpentine.pathscale.com>
 <Pine.LNX.4.64.0603170921470.3618@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Mar 2006 18:19:46.0150 (UTC) FILETIME=[5EB3F060:01C649EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006, Linus Torvalds wrote:
> 
> Anyway, zap_page_range() would do what you want, but it's not exported, 
> and I'm not convinced it's even something we want to export. You can only 
> zap a page range from within the context of the zappee, not from an 
> external module/driver.
> 
> [ Maybe it works if somebody else calls it, maybe it doesn't. I wouldn't 
>   bet on it, and more importantly, I can pretty much _guarantee_ that a 
>   driver will get the "struct mm_struct" reference counting wrong. ]

But vmtruncate or unmap_mapping_range is quite used to operating on
whatever mm's have mapped the file, so should be a safe route.  Except
here it's a device mapped VM_PFNMAP, so there might prove to be some
gotchas.  I'd be happy to make a nopage fault on VM_PFNMAP give SIGBUS,
for sensible behaviour after the "truncate" - but recent history warns
we're liable then to discover some app expecting otherwise ;)

Hugh
