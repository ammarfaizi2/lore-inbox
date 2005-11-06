Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbVKFThq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVKFThq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 14:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVKFThq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 14:37:46 -0500
Received: from ozlabs.org ([203.10.76.45]:14781 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751179AbVKFThp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 14:37:45 -0500
Date: Mon, 7 Nov 2005 04:59:43 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-ID: <20051106175943.GJ12353@krispykreme>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com> <20051106112838.0d524f65.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106112838.0d524f65.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This patch makes the ppc64 crash.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02976.jpg
> 
> I don't know what the access address was (ia32 nicely tells you), but if
> it's `DAR' then we have LIST_POISON1.  Which would indicate that the slab
> page which backs the mm_struct itself is getting freed-up-pte-page
> treatment, which is deeply screwed up.

Yep on a 300 exception the DAR is the faulting address.

We should spit out a line like x86 does at the start of the oops to make
it clear.

Anton
