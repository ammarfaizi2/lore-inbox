Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWCGTjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWCGTjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWCGTjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:39:04 -0500
Received: from gold.veritas.com ([143.127.12.110]:17854 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932276AbWCGTjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:39:03 -0500
X-IronPort-AV: i="4.02,172,1139212800"; 
   d="scan'208"; a="56800067:sNHT31989160"
Date: Tue, 7 Mar 2006 19:39:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Hui Yu <hyu@ati.com>
cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] mm: data overlapping in page struct 
In-Reply-To: <E6F1C74189C227449B7C7BC9F60926F901B4EC4C@torcaexmb2.atitech.com>
Message-ID: <Pine.LNX.4.61.0603071933070.4158@goblin.wat.veritas.com>
References: <E6F1C74189C227449B7C7BC9F60926F901B4EC4C@torcaexmb2.atitech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Mar 2006 19:39:00.0545 (UTC) FILETIME=[C8698B10:01C6421E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Hui Yu wrote:

> This patch is to fix a data overlapping issue in struct page. The
> problem was introduced a few months ago by "split page table lock"
> change in which mapping is moved into the same union with ptl. Since
> private has fixed length (size of unsigned long), depending on config
> options, ptl may have larger size than private. In this case, ptl will
> overlap to mapping and may overwrite the original data in mapping. 
> The simplest way of fixing this is to move mapping out of the union, as
> in this patch. There may be better approaches; I'll leave it to the
> experts more familiar with this part of code.  

Nak.  We use ->mapping for page cache pages, or pages mapped into
user address space.  We use ->ptl for page table pages of user
address space.  Where is it that you expect a data page to be
used as a page table page at the same time?

This 2.6.16 change was precisely to share that part of the struct
page between mapping and ptl, so as to bring struct page back down
to its 2.6.14 size on the non-DEBUG_SPINLOCK configurations.

Hugh
