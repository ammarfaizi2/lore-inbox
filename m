Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTB0WlB>; Thu, 27 Feb 2003 17:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTB0WlA>; Thu, 27 Feb 2003 17:41:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:42886 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267227AbTB0Wk7>;
	Thu, 27 Feb 2003 17:40:59 -0500
Date: Thu, 27 Feb 2003 14:47:49 -0800
From: Andrew Morton <akpm@digeo.com>
To: janetmor@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.5.63 BUG in deadline-iosched.c
Message-Id: <20030227144749.48e8e0f1.akpm@digeo.com>
In-Reply-To: <3E5E70E0.36937042@us.ibm.com>
References: <3E5E70E0.36937042@us.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Feb 2003 22:51:13.0189 (UTC) FILETIME=[BA5B5D50:01C2DEB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janet Morgan <janetmor@us.ibm.com> wrote:
>
> I got this on 2.5.63 while running the "find" command:
> 
> kernel BUG at drivers/block/deadline-iosched.c:145!
> invalid operand: 0000
> CPU:    3
> EIP:    0060:[<c026f8a1>]    Not tainted
> EFLAGS: 00010046
> EIP is at deadline_find_drq_hash+0x41/0xb0
> eax: f76fe060   ebx: f76fe058   ecx: f76fe060   edx: 00000000
> esi: f76fe060   edi: f76fe044   ebp: f76fe050   esp: f7e27c88
> ds: 007b   es: 007b   ss: 0068
> Process pdflush (pid: 16, threadinfo=f7e26000 task=c3b39300)
> Stack: 010d7ce6 00000000 f7fd2ae0 f7fd2ae0 f7fd2ae0 f7747f80 c026fbc9
> f7747f80
>        010d7ce6 00000000 f7747f80 00000000 f7759000 f7759000 00000008
> c026a438
>        f7759000 f7e27cf8 f7fd2ae0 c026cc58 f7759000 f7e27cf8 f7fd2ae0
> 010d7ce6
> Call Trace:
>  [<c026fbc9>] deadline_merge+0x49/0x120
>  [<c026a438>] elv_merge+0x18/0x30
>  [<c026cc58>] __make_request+0xb8/0x440

Nick, could this be caused by a stale next_drq[] entry?

If so,

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.63/2.5.63-mm1/broken-out/deadline-dispatching-fix.patch

is designed to fix it.
