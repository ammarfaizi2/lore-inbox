Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWBQT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWBQT1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbWBQT1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:27:11 -0500
Received: from silver.veritas.com ([143.127.12.111]:6332 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751469AbWBQT1K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:27:10 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,124,1139212800"; 
   d="scan'208"; a="34332717:sNHT22903792"
Date: Fri, 17 Feb 2006 19:27:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] convert sighand_cache to use SLAB_DESTROY_BY_RCU
In-Reply-To: <43F62B96.C54704D1@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0602171926180.15992@goblin.wat.veritas.com>
References: <43F62B96.C54704D1@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 17 Feb 2006 19:27:08.0540 (UTC) FILETIME=[2496B3C0:01C633F8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006, Oleg Nesterov wrote:
> This patch borrows a clever Hugh's 'struct anon_vma' trick.
> 
> Without tasklist_lock held we can't trust task->sighand until we
> locked it and re-checked that it is still the same.
> 
> But this means we don't need to defer 'kmem_cache_free(sighand)'.
> We can return the memory to slab immediately, all we need is to
> be sure that sighand->siglock can't dissapear inside rcu protected
> section.
> 
> To do so we need to initialize ->siglock inside ctor function,
> SLAB_DESTROY_BY_RCU does the rest.

Yes, that looks a good use of SLAB_DESTROY_BY_RCU to me: thanks!

Hugh
