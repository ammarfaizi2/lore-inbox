Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVHBStK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVHBStK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVHBStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:49:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61601 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261707AbVHBSsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:48:55 -0400
Date: Tue, 2 Aug 2005 11:47:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
In-Reply-To: <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org>
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com>
 <Pine.LNX.4.58.0508020829010.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021645050.4921@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org>
 <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2005, Hugh Dickins wrote:
> 
> It might not be so bad.  It's going to access the struct page anyway.
> And clearing dirty from parent and child at fork time could save two
> set_page_dirtys at exit time.  But I'm not sure that we could batch the
> the dirty bit clearing into one TLB flush like we do the write protection.

Yes, good point. If the thing is still marked dirty in the TLB, some other 
thread might be writing to the page after we've cleared dirty but before 
we've flushed the TLB - causing the new dirty bit to be lost. I think.

		Linus

