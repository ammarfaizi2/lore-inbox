Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUKFJsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUKFJsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKFJsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:48:20 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12750 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261349AbUKFJsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:48:17 -0500
Date: Sat, 6 Nov 2004 09:47:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@novell.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /
    all_unreclaimable braindamage
In-Reply-To: <20041106015051.GU8229@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0411060944150.2721-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004, Andrea Arcangeli wrote:
> 
> all allocations should have a failure path to avoid deadlocks. But in
> the meantime __GFP_REPEAT is at least localizing the problematic places ;)

Problematic, yes: don't overlook that GFP_REPEAT and GFP_NOFAIL _can_
fail, returning NULL: when the process is being OOM-killed (PF_MEMDIE).

Hugh

