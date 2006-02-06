Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWBFIn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWBFIn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWBFIn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:43:58 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:51063 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750782AbWBFIn5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:43:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bCUq3WBRBKHwkveIJPIzJ3uIfKxRExBU4e2HhsYAs5cjyZDzdspExDi881eCtSKUZVyb+gs4YvuXQ+akx0Y+9XWMdMOHbVUQ5me3OeUFaSUQRg7DVTwr4kHDEpSL58G1Paigaw10YSzVS2nQbl86XjfNyKuHaVY3UB6LuuDjMqU=
Message-ID: <986ed62e0602060043o5e203341ra5daf0fe628866f9@mail.gmail.com>
Date: Mon, 6 Feb 2006 00:43:57 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit - Resubmit
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43E3BDDD.6000402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43E3BDDD.6000402@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> diff -urNp linux-2.6.16-rc2/include/asm-i386/param.h linux-2.6.16-rc2.new/include/asm-i386/param.h
> --- linux-2.6.16-rc2/include/asm-i386/param.h   2006-01-03 05:21:10.000000000 +0200
> +++ linux-2.6.16-rc2.new/include/asm-i386/param.h       2006-02-03 21:23:21.000000000 +0200
> @@ -19,6 +19,6 @@
>  #endif
>
>  #define MAXHOSTNAMELEN 64      /* max length of hostname */
> -#define COMMAND_LINE_SIZE 256
> +#define COMMAND_LINE_SIZE 1024
>
>  #endif
> diff -urNp linux-2.6.16-rc2/include/asm-i386/setup.h linux-2.6.16-rc2.new/include/asm-i386/setup.h
> --- linux-2.6.16-rc2/include/asm-i386/setup.h   2006-01-03 05:21:10.000000000 +0200
> +++ linux-2.6.16-rc2.new/include/asm-i386/setup.h       2006-02-03 21:19:44.000000000 +0200
> @@ -17,7 +17,7 @@
>  #define MAX_NONPAE_PFN (1 << 20)
>
>  #define PARAM_SIZE 4096
> -#define COMMAND_LINE_SIZE 256
> +#define COMMAND_LINE_SIZE 1024
>
>  #define OLD_CL_MAGIC_ADDR      0x90020
>  #define OLD_CL_MAGIC           0xA33F
> diff -urNp linux-2.6.16-rc2/include/asm-x86_64/setup.h linux-2.6.16-rc2.new/include/asm-x86_64/setup.h
> --- linux-2.6.16-rc2/include/asm-x86_64/setup.h 2006-01-03 05:21:10.000000000 +0200
> +++ linux-2.6.16-rc2.new/include/asm-x86_64/setup.h     2006-02-03 21:20:40.000000000 +0200
> @@ -1,6 +1,6 @@
>  #ifndef _x8664_SETUP_H
>  #define _x8664_SETUP_H
>
> -#define COMMAND_LINE_SIZE      256
> +#define COMMAND_LINE_SIZE      1024
>
>  #endif

(Sorry, I didn't notice your patch when you posted it in the past, or
I would have responded back then.)

FWIW, this was tried between 2.6.11-rc1 and 2.6.11-rc2 (except it was
256->2048 instead of 256->1024), and it was reverted before 2.6.11-rc2
because it broke booting with lilo -- for many people, the change
caused their system to freeze early during boot.

This is what the 2.6.11-rc2 changelog has to say about the matter:
>	Revert "x86_64/i386: increase command line size" patch
>	
>	It's a bootup dependancy, you can't just increase it randomly, and
>	it breaks booting with LILO.
>	
>	Pointed out by Janos Farkas and Adrian Bunk.

Has this issue been addressed yet? (i.e. does 1024 avoid the problem
that 2048 had, or did anything else change in the kernel between
2.6.11-rc1 and today to prevent the problem from happening again?)
--
-Barry K. Nathan <barryn@pobox.com>
