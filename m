Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262352AbSJOBK1>; Mon, 14 Oct 2002 21:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJOBK1>; Mon, 14 Oct 2002 21:10:27 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:19859 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262352AbSJOBK0>;
	Mon, 14 Oct 2002 21:10:26 -0400
Date: Tue, 15 Oct 2002 02:18:07 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support, 2.5.42-F8
Message-ID: <20021015011807.GA27718@bjl1.asuk.net>
References: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple of suggestions/questions that may make this syscall
more generally useful.

Ingo Molnar wrote:
>  * @prot: new protection bits of the range

So, you can change the protection per page without thousands of vmas?
Some garbage collectors could take advantage of that.

> Since all the mapping information of nonlinear vmas lives in the
> pagetables, they either have to be MAP_LOCKED (for databases or
> virtualization software) or need a special SIGBUS handler to
> reinstall mappings across swapping (for more complex uses such as
> memory debuggers).

I like the SIGBUS.  Am I correct to assume that, when there is memory
pressure, some pages are evicted from memory and all accesses to those
pages from userspace will raise SIBUS until the mapping is
reastablished?  Am I correct to assume this works fine on /dev/shm files?

This has uses in programs that cache data that is faster to
recalculate than to swap.  For example, a vector image displayer might
prefer to re-render parts of an image than to wait for parts of a
large cached image to page in.  A JIT run-time compiler might prefer
to regenerate code fragments on demand than to wait for paged out,
cached code fragments to page back in.

I think that the above two features are already supported by your
patch, by simply using a /dev/shm file as the backing store.  Ingo,
can you confirm this?

Thanks,
-- Jamie
