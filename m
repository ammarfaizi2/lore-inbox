Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSHCXLD>; Sat, 3 Aug 2002 19:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSHCXLD>; Sat, 3 Aug 2002 19:11:03 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:42644 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318013AbSHCXLC>; Sat, 3 Aug 2002 19:11:02 -0400
Message-ID: <3D4C62A5.8040607@quark.didntduck.org>
Date: Sat, 03 Aug 2002 19:09:25 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Dead code in i386/kernel/process.c
References: <3D4C5B8E.5060009@quark.didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> This patch removes an artifact of code left over from the 2.0 days when 
> the kernel didn't use flat segments.
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urN linux-2.5.30/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
> --- linux-2.5.30/arch/i386/kernel/process.c	Fri Aug  2 10:15:28 2002
> +++ linux/arch/i386/kernel/process.c	Sat Aug  3 16:41:03 2002
> @@ -313,11 +313,6 @@
>  	memcpy (swapper_pg_dir, swapper_pg_dir + USER_PGD_PTRS,
>  		sizeof (swapper_pg_dir [0]) * KERNEL_PGD_PTRS);
>  
> -	/* Make sure the first page is mapped to the start of physical memory.
> -	   It is normally not mapped, to trap kernel NULL pointer dereferences. */
> -
> -	pg0[0] = _PAGE_RW | _PAGE_PRESENT;
> -
>  	/*
>  	 * Use `swapper_pg_dir' as our page directory.
>  	 */

I should clarify that the dead code does the same thing as the preceding 
memcpy.

