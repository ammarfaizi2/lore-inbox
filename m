Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSGYUzI>; Thu, 25 Jul 2002 16:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSGYUzI>; Thu, 25 Jul 2002 16:55:08 -0400
Received: from [195.223.140.120] ([195.223.140.120]:56370 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316309AbSGYUzH>; Thu, 25 Jul 2002 16:55:07 -0400
Date: Thu, 25 Jul 2002 22:59:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Cort Dougan <cort@fsmlabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725205910.GR1180@dualathlon.random>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725142716.N2276@host110.fsmlabs.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 02:27:16PM -0600, Cort Dougan wrote:
> None of the changes look like a problem.  I'll absorb them and send another

the lack of <= was a bug, the buffer overflows on the stack with symbols
> 60 was a bug too even if less likely to trigger.

> patch.  One that fixes Ben's criticisms of spurious whitespace, even :)
> 
> Are you suggesting that it should print the start/end of the module in each
> trace in addition to the symbol names or instead of them?

Not the end, just the start, and not in addition, but only the start
address of each module without any symbol.

> I've found it valuable to have the EIP resolved.  Even though the symbol
> name may not be perfect (only resolves exported names) it is valuable to
> see that the function crashed 0x1fe bytes after a given symbol name.

valuable for what? you need the system.map or the .o disassembly of the
module anyways to take advantage of such symbol. I don't find it useful.
Furthmore ksymoops will prefer to work with hex numbers rather than
doing the reverse lookup to the number and then resolving to the right
symbol (and not only ksymoops, me too while doing by hand and that's why
I prefer hex there)

One thing is if you have ksymall ala kdb and you can resolve to
something where you don't need the system.map to guess what happened,
but without the ksymall you need the system.map or vmlinux anyways.

Andrea
