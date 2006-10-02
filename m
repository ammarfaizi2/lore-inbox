Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWJBUvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWJBUvB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWJBUvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:51:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50862 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965098AbWJBUvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:51:00 -0400
Date: Mon, 2 Oct 2006 13:50:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: linux/compat.h includes asm/signal.h causing problems
Message-Id: <20061002135036.7bd1f76b.akpm@osdl.org>
In-Reply-To: <20061002.131414.74728780.davem@davemloft.net>
References: <20061002.131414.74728780.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 13:14:14 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> 
> On some platforms, including sparc64, asm/signal.h needs
> compat_sigset_t, but this is defined in linux/compat.h
> after asm/signal.h is included.
> 
> Andrew, aren't you doing sparc64 cross builds these days? :-)
> 
> This came from 3f2e05e90e0846c42626e3d272454f26be34a1bc
> 
>     [PATCH] BLOCK: Revert patch to hack around undeclared sigset_t in linux/compat.h
>     
>     Revert Andrew Morton's patch to temporarily hack around the lack of a
>     declaration of sigset_t in linux/compat.h to make the block-disablement
>     patches build on IA64.  This got accidentally pushed to Linus and should
>     be fixed in a different manner.
>     
>     Also make linux/compat.h #include asm/signal.h to gain a definition of
>     sigset_t so that it can externally declare sigset_from_compat().
>     
>     This has been compile-tested for i386, x86_64, ia64, mips, mips64, frv, ppc and
>     ppc64 and run-tested on frv.
>     
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> It figures that one of the platforms it wasn't compile tested on is
> the one that breaks :-)

not me, boss - I told 'em that using sigset_t in compat.h was a minefield. 
sparc64 built OK with my hack-shouldnt-be-merged patch applied, which is
how it was tested in -mm.

I don't know what a good fix is, really.  I guess one could put the
declaration of sigset_from_compat() into its own header file and include
that header from the right places.


