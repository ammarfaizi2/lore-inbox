Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAOMzF>; Mon, 15 Jan 2001 07:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbRAOMy4>; Mon, 15 Jan 2001 07:54:56 -0500
Received: from linuxcare.com.au ([203.29.91.49]:18440 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129401AbRAOMyq>; Mon, 15 Jan 2001 07:54:46 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 15 Jan 2001 23:51:13 +1100
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, David Weinehall <tao@acc.umu.se>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010115235113.A31461@linuxcare.com>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m1snmlfbrx.fsf_-_@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Jan 15, 2001 at 01:41:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> shared mmap.  This is the important one.  Since we have a logical
> backing store this is easy to handle.  We just enforce that the
> virtual address in a process that we mmap something to must match the
> logical address to VIRT_INDEX_BITS.  The effect is the same as a
> larger page size with virtually no overhead.

Check out arch/sparc64/kernel/sys_sparc32.c. Dave and I fixed this a while
ago. In particular look at the arch specific SPARC_FLAG_MMAPSHARED flag.

> sysv shared memory is exactly the same as shared mmap.  Except instead
> of a file offset you have an offset into the sysv segment.

sysv shared mem when you specify an attach address should work fine (ie
aligned to SHMLBA). On the other hand sysv shared mem without requesting
an address is broken and I havent got around to fixing it yet.

> mremap.  Linux specific but pretty much the same as mmap, but easier.
> We just enforce that the virtual address of the source of mremap,
> and the destination of mremap match on VIRT_INDEX_BITS.

See above.

Cheers,
Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
