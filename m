Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSHLHb0>; Mon, 12 Aug 2002 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSHLHbZ>; Mon, 12 Aug 2002 03:31:25 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:20167 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317462AbSHLHbZ>;
	Mon, 12 Aug 2002 03:31:25 -0400
Date: Mon, 12 Aug 2002 17:34:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, julliard@winehq.com,
       ldb@ldb.ods.org
Subject: Re: [patch] tls-2.5.31-C3
Message-Id: <20020812173404.39d3abab.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0208112326580.29560-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
	<Pine.LNX.4.44.0208112326580.29560-200000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Sun, 11 Aug 2002 23:46:01 +0200 (CEST) Ingo Molnar <mingo@elte.hu> wrote:
>
>  	/*
>  	 * The APM segments have byte granularity and their bases
>  	 * and limits are set at run time.
>  	 */
> -	.quad 0x0040920000000000	/* 0x40 APM set up for bad BIOS's */
> -	.quad 0x00409a0000000000	/* 0x48 APM CS    code */
> -	.quad 0x00009a0000000000	/* 0x50 APM CS 16 code (16 bit) */
> -	.quad 0x0040920000000000	/* 0x58 APM DS    data */
> +	.quad 0x0040920000000000	/* 0x80 APM set up for bad BIOS's */
> +	.quad 0x00409a0000000000	/* 0x88 APM CS    code */
> +	.quad 0x00009a0000000000	/* 0x90 APM CS 16 code (16 bit) */
> +	.quad 0x0040920000000000	/* 0x98 APM DS    data */

I just lost 0x40 which needs to be exactly 0x40 if it is do its job (i.e.
cope with brain dead BIOS writers using 0x40 as a segment offset in
protected mode ...

The idea is that segment 0x40 maps from physical address 0x400 to the end
of the first physical page.  As a real mode program would (more or less)
expect it to.

The other three segments don't matter as longs as they are in that order
and contiguous.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
