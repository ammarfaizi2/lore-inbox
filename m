Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTKMD1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 22:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKMD1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 22:27:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:62848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262056AbTKMD1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 22:27:45 -0500
Date: Wed, 12 Nov 2003 19:31:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Inefficient TLB flushing
Message-Id: <20031112193124.48224ccb.akpm@osdl.org>
In-Reply-To: <20031113031801.GA17689@sgi.com>
References: <20031112200119.GA22429@sgi.com>
	<16306.40177.200706.688936@napali.hpl.hp.com>
	<20031112132253.7f95df20.akpm@osdl.org>
	<20031113031801.GA17689@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> > Either that, or add a new interface function
>  > 
>  > 	int mmu_gather_is_full_mm(mmu_gather *tlb);
>  > 
>  > and use it...
>  > 
> 
>  How implementation independent should it be? Currently, there is only one
>  field in the mmu_gather structure that must be preserved. However, if we
>  want to make the interface truly implementation independent, it seems
>  like we should define something like:
> 
>  	if (need_resched()) {
>  		struct mmu_gather_state state;
>  		tlb_mmu_gather_save_state(*tlbp, &state);
>  		tlb_finish_mmu(*tlbp, tlb_start, start);
>  		...
>  		*tlbp = tlb_mmu_gather_restore_state(&state);
>  	}
> 
>  Is this overkill?

Think so ;) The `full_mm_flush' boolean is the only state thing we can pass
into tlb_gather_mmu anyway.

> 
>  Should we use the patch given above for 2.6.0 & replace it with an implementation 
>  independent interface for 2.6.1?

Just the little wrapper which doesn't assume the presence of
mmu_gather.full_mm should suffice.

