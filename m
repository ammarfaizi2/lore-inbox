Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131287AbQKKQqG>; Sat, 11 Nov 2000 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbQKKQp4>; Sat, 11 Nov 2000 11:45:56 -0500
Received: from [62.172.234.2] ([62.172.234.2]:11987 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S131287AbQKKQpp>;
	Sat, 11 Nov 2000 11:45:45 -0500
Date: Sat, 11 Nov 2000 16:46:09 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
To: Andrea Arcangeli <andrea@suse.de>
cc: Tigran Aivazian <tigran@veritas.com>, "H. Peter Anvin" <hpa@transmeta.com>,
        Max Inux <maxinux@bigfoot.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <20001111172610.A9140@inspiron.suse.de>
Message-ID: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Andrea Arcangeli wrote:

> On Sat, Nov 11, 2000 at 02:51:21PM +0000, Tigran Aivazian wrote:
> > Yes, Andrea, I know that paging is disabled at the point of loading the
> > image but I was talking about the inability to boot (boot == complete
> > booting, i.e. at least reach start_kernel()) a kernel with very large
> > .data or .bss segments because of various reasons -- one of which,
> > probably,is the inadequacy of those pg0 and pg1 page tables set up in
> > head.S
> 
> Ah ok, I thought you were talking about bootloader.
> 
> About the initial pagetable setup on i386 port there's certainly a 3M limit on
> the size of the kernel image, but it's trivial to enlarge it.  BTW, exactly for
> that kernel size limit reasons in x86-64 I defined a 40Mbyte mapping where we
> currently have a 4M mapping and that's even simpler to enlarge since they're 2M
> PAE like pagetables.
> 
> Basically as far as the kernel can get loaded in memory correctly we have
> no problem :)
> 
> > (which Peter says is infinite?) or the ones on .text/.data/.bss (and what
> > exactly are they?)? See my question now?
> 
> We sure hit the 3M limit on the .bss clearing right now.
> 

I understand and agree with what you say except the number 4M. It is not
4M but 8M, imho. See arch/i386/kernel/head.S

/*
 * The page tables are initialized to only 8MB here - the final page
 * tables are set up later depending on memory size.
 */
.org 0x2000
ENTRY(pg0)

.org 0x3000
ENTRY(pg1)

/*
 * empty_zero_page must immediately follow the page tables ! (The
 * initialization loop counts until empty_zero_page)
 */

.org 0x4000
ENTRY(empty_zero_page)

(the comment next to pg0 in asm/pgtable.h is misleading, whilst the
comment above paging_init() is plain wrong -- I sent a patch to Linus
yesterday but perhaps "wrong comment" is not a critical 2.4 issue :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
