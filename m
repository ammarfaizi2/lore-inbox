Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264343AbTCYW2H>; Tue, 25 Mar 2003 17:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264373AbTCYW2H>; Tue, 25 Mar 2003 17:28:07 -0500
Received: from holomorphy.com ([66.224.33.161]:29603 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264343AbTCYW2G>;
	Tue, 25 Mar 2003 17:28:06 -0500
Date: Tue, 25 Mar 2003 14:38:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 11/13 fix unuse_pmd fixme
Message-ID: <20030325223853.GL30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain> <Pine.LNX.4.44.0303252220420.12636-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303252220420.12636-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:21:51PM +0000, Hugh Dickins wrote:
> try_to_unuse drop mmlist_lock across unuse_process (with pretty dance
> of atomic_incs and mmputs of various mmlist markers, and a polite new
> cond_resched there), so unuse_process can pte_chain_alloc(GFP_KERNEL)
> and pass that down and down and down and down to unuse_pte: which
> cannot succeed more than once on a given mm (make that explicit by
> returning back up once succeeded).  Preliminary checks moved up from
> unuse_pte to unuse_pmd, and done more efficiently (avoid that extra
> pte_file test added recently), swapoff spends far too long in here.
> Updated locking comments and references to try_to_swap_out.

Aha, the unlock_page() and the contorted loop breakout were wrong
in my patch. Well, that and the cleanup of fossilized comments dating
back to the Silurian is nice.


-- wli
