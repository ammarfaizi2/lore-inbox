Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTEYWcG (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTEYWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 18:32:06 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8246 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263791AbTEYWcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 18:32:05 -0400
Date: Sun, 25 May 2003 15:48:40 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
   Trond Myklebust <trond.myklebust@fys.uio.no>,
   Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.5.69-mm9
Message-Id: <20030525154840.3ba7609b.akpm@digeo.com>
In-Reply-To: <1053899811.750.1.camel@teapot.felipe-alfaro.com>
References: <20030525042759.6edacd62.akpm@digeo.com>
	<1053899811.750.1.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 May 2003 22:45:15.0532 (UTC) FILETIME=[4F1D7CC0:01C3230F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> Unable to handle kernel paging request at virtual address c8df7014
>   printing eip:
>  e08d1a9b
>  *pde = 00023067
>  *pte = 08df7000
>  Oops: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<e08d1a9b>]    Not tainted VLI
>  EFLAGS: 00010206
>  EIP is at svc_udp_recvfrom+0x52b/0x560 [sunrpc]
>  eax: dda32004   ebx: c8df7004   ecx: ddff0004   edx: d73ba938
>  esi: c8df7004   edi: d68549c4   ebp: 0000808c   esp: de3d3eec
>  ds: 007b   es: 007b   ss: 0068
>  Process nfsd (pid: 2182, threadinfo=de3d2000 task=d6490000)
>  Stack: de3d3f04 d73ba938 ddff0004 c012d4b5 de3d3f04 de3d3f04 c02ea1b0 de3e1f04 
>         0082863d 1d244b3c 00000000 00000005 c02b4e54 00000000 00000000 4b87ad6e 
>         c012d3e0 d6490000 00000000 de3d2000 d73ba938 ddff0004 00000000 e08d384e 
>  Call Trace:
>   [<c012d4b5>] schedule_timeout+0xc5/0xe0
>   [<c012d3e0>] process_timeout+0x0/0x10
>   [<e08d384e>] svc_recv+0x67e/0x850 [sunrpc]
>   [<c011db20>] default_wake_function+0x0/0x20
>   [<e08d06c2>] svc_process+0x4e2/0x690 [sunrpc]
>   [<c011db20>] default_wake_function+0x0/0x20
>   [<c013167a>] sigprocmask+0x18a/0x280
>   [<e090c549>] nfsd+0x289/0x7c0 [nfsd]
>   [<e090c2c0>] nfsd+0x0/0x7c0 [nfsd]
>   [<c0108201>] kernel_thread_helper+0x5/0x14
> 
>  Code: 0f 00 00 8b 4c 24 60 c1 e8 0c 0f b7 91 88 01 00 00 01 c2 66 89 91 88 01 00 00 8b 54 24 04 8b 42 14 85 c0 74 03 ff 40 08 8b 47 14 <8b> 53 10 8b 4b 14 89 90 94 01 00 00 89 88 98 01 00 00 31 c0 0f 


OK, you have CONFIG_DEBUG_PAGEALLOC set.  That's the patch which unmaps
pages from kernel virtual address space when they are freed.

That patch seems quite stable on uniprocessor at least - there are question
marks over its honesty on SMP.

I would be inclined to say that this is a hitherto undiscovered
use-after-free bug.

