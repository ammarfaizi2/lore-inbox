Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279652AbRJ3AAu>; Mon, 29 Oct 2001 19:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279653AbRJ3AAk>; Mon, 29 Oct 2001 19:00:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48169 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S279652AbRJ3AAd>; Mon, 29 Oct 2001 19:00:33 -0500
Date: Tue, 30 Oct 2001 00:02:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029182949.H25434@redhat.com>
Message-ID: <Pine.LNX.4.21.0110292358290.1036-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Benjamin LaHaise wrote:
> Think of CPUs with tagged tlbs and lots of entries.  Or even a system that 
> only runs 1 threaded app.  Easily triggerable.  If people want to optimise 
> it, great.  But go for correctness first, please...

But was the original flush_tlb_page() fully correct?  In i386 it's
	if (vma->vm_mm == current->active_mm)
		__flush_tlb_one(addr);
without reference to whether vma->vm_mm is active on another cpu.

Hugh

