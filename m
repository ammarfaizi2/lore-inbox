Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261408AbSITIWQ>; Fri, 20 Sep 2002 04:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSITIWQ>; Fri, 20 Sep 2002 04:22:16 -0400
Received: from angband.namesys.com ([212.16.7.85]:53915 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261408AbSITIWP>; Fri, 20 Sep 2002 04:22:15 -0400
Date: Fri, 20 Sep 2002 12:27:16 +0400
From: Oleg Drokin <green@namesys.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Message-ID: <20020920122716.A2297@namesys.com>
References: <Pine.LNX.4.44.0209182101150.27697-100000@localhost.localdomain> <Pine.LNX.4.44.0209190344280.3935-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209190344280.3935-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 19, 2002 at 04:54:46AM +0200, Ingo Molnar wrote:

>  - unified kernel/pid.c and kernel/idtag.c into kernel/pid.c.

> +			/*
> +			 * Free the page if someone raced with us
> +			 * installing it:
> +			 */
> +			if (cmpxchg(&map->page, NULL, page))
> +				free_page(page);

Note that this piece breaks compilation for every arch that does not
have cmpxchg implementation.
This is the case with x86 (with CONFIG_X86_CMPXCHG undefined, e.g. i386),
ARM, CRIS, m68k, MIPS, MIPS64, PARISC, s390, SH, sparc32, UML (for x86).

Bye,
    Oleg
