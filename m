Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131182AbQKKQ01>; Sat, 11 Nov 2000 11:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbQKKQ0R>; Sat, 11 Nov 2000 11:26:17 -0500
Received: from Cantor.suse.de ([194.112.123.193]:43020 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131182AbQKKQ0N>;
	Sat, 11 Nov 2000 11:26:13 -0500
Date: Sat, 11 Nov 2000 17:26:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
Message-ID: <20001111172610.A9140@inspiron.suse.de>
In-Reply-To: <20001111154209.A3450@inspiron.suse.de> <Pine.LNX.4.21.0011111448200.1511-100000@saturn.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011111448200.1511-100000@saturn.homenet>; from tigran@veritas.com on Sat, Nov 11, 2000 at 02:51:21PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 02:51:21PM +0000, Tigran Aivazian wrote:
> Yes, Andrea, I know that paging is disabled at the point of loading the
> image but I was talking about the inability to boot (boot == complete
> booting, i.e. at least reach start_kernel()) a kernel with very large
> .data or .bss segments because of various reasons -- one of which,
> probably,is the inadequacy of those pg0 and pg1 page tables set up in
> head.S

Ah ok, I thought you were talking about bootloader.

About the initial pagetable setup on i386 port there's certainly a 3M limit on
the size of the kernel image, but it's trivial to enlarge it.  BTW, exactly for
that kernel size limit reasons in x86-64 I defined a 40Mbyte mapping where we
currently have a 4M mapping and that's even simpler to enlarge since they're 2M
PAE like pagetables.

Basically as far as the kernel can get loaded in memory correctly we have
no problem :)

> (which Peter says is infinite?) or the ones on .text/.data/.bss (and what
> exactly are they?)? See my question now?

We sure hit the 3M limit on the .bss clearing right now.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
