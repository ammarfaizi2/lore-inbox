Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSBSCHh>; Mon, 18 Feb 2002 21:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289297AbSBSCH1>; Mon, 18 Feb 2002 21:07:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15371 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289298AbSBSCHV>; Mon, 18 Feb 2002 21:07:21 -0500
Date: Mon, 18 Feb 2002 18:05:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
Subject: Re: [RFC] Page table sharing
In-Reply-To: <Pine.LNX.4.33L.0202182252260.1930-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0202181758260.24597-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Feb 2002, Rik van Riel wrote:
>
> The swapout code can remove a page from the page table
> while another process is in the process of unsharing
> the page table.

Ok, I'll buy that. However, looking at that, the locking is not the real
issue at all:

When the swapper does a "ptep_get_and_clear()" on a shared pmd, it will
end up having to not just synchronize with anybody doing unsharing, it
will have to flush all the TLB's on all the mm's that might be implicated.

Which implies that the swapper needs to look up all mm's some way anyway,
so the locking gets solved that way.

(Now, that's really pushing the problem somewhere else, and that
"somewhere else" is actually a whole lot nastier than the original locking
problem ever was, so I'm not claiming this actually solves anything. I'm
just saying that the locking isn't the issue, and we actually have some
quite fundamental problems here..)

		Linus

