Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVCNFFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVCNFFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCNFFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:05:48 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:57515 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261526AbVCNFB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:01:56 -0500
Subject: Re: [PATCH] break_lock forever broken
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>
	 <20050311203427.052f2b1b.akpm@osdl.org>
	 <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 16:01:42 +1100
Message-Id: <1110776502.5131.33.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 23:20 +0000, Hugh Dickins wrote:

> Since cond_resched_lock's spin_lock clears break_lock, no need to clear it
> itself; and use need_lockbreak there too, preferring optimizer to #ifdefs.
> 

FWIW, this patch solves the problems I had in mind (and so should
solve our copy_page_range livelock I hope). I was sort of inclined
to clear break_lock at lock time too.

As Arjan points out, an unconditional set is probably the way to go
if we've already dirtied the cacheline.

> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 

Thanks for doing the patch Hugh.



