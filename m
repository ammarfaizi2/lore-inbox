Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWILVQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWILVQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWILVQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:16:39 -0400
Received: from waste.org ([66.93.16.53]:1422 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750727AbWILVQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:16:38 -0400
Date: Tue, 12 Sep 2006 16:15:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Howells <dhowells@redhat.com>
Cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
Message-ID: <20060912211500.GH19707@waste.org>
References: <20060912174339.GA19707@waste.org> <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com> <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com> <3551.1157448903@warthog.cambridge.redhat.com> <6d6a94c50609051935m607f976j942263dd1ac9c4fb@mail.gmail.com> <44FE4222.3080106@yahoo.com.au> <6d6a94c50609120107w1942a8d8j368dd57a271d0250@mail.gmail.com> <24525.1158089104@warthog.cambridge.redhat.com> <6626.1158094964@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6626.1158094964@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 10:02:44PM +0100, David Howells wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> 
> > Not sure yet. There's only one user in nommu.c that shouldn't just be
> > changed to ksize() that I can see, and that's the one in
> > show_process_blocks(). That could test for VM_MAPPED_COPY and keep its
> > hands off otherwise. 
> 
> Hmmm...  You're right.  However, note binfmt_elf_fdpic().  This calls ksize()
> but should really call kobjsize().  It should not assume that the allocation
> it's been given is of any particular type. 

I presume you mean load_elf_fdpic_binary, which is doing:

        fullsize = ksize((char *) current->mm->start_brk);

That's a little troubling.

> IIRC ksize() changed purpose at some point.

Uh, nope. ksize doesn't even exist in 2.4 and has always done the same
thing in 2.6.

-- 
Mathematics is the supreme nostalgia of our time.
