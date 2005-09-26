Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVIZHVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVIZHVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVIZHVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:21:06 -0400
Received: from gold.veritas.com ([143.127.12.110]:45890 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932423AbVIZHVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:21:05 -0400
Date: Mon, 26 Sep 2005 08:20:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] mm: zap_pte_range dont dirty anon
In-Reply-To: <20050925231424.6c08bc8a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509260816530.8574@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0509251649100.3490@goblin.wat.veritas.com>
 <20050925152630.75560571.akpm@osdl.org> <Pine.LNX.4.61.0509260659370.8065@goblin.wat.veritas.com>
 <20050925231424.6c08bc8a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Sep 2005 07:21:04.0743 (UTC) FILETIME=[DB0ECF70:01C5C26A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Andrew Morton wrote:
> 
> 	mmap(MAP_ANONYMOUS|MAP_SHARED)
> 	fork()
> 	swapout
> 	swapin
> 	swapoff
> 
> Now we have two mm's sharing a clean, non-cowable, non-swapcache anonymous
> page, no?

No, MAP_ANONYMOUS|MAP_SHARED gives you a tmpfs object via shmem_zero_setup:
all those pages are shared file pages, not PageAnon at all.

Hugh
