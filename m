Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSLQRDf>; Tue, 17 Dec 2002 12:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSLQRDf>; Tue, 17 Dec 2002 12:03:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:3583 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264944AbSLQRDa>;
	Tue, 17 Dec 2002 12:03:30 -0500
Message-ID: <3DFF5A80.46051426@digeo.com>
Date: Tue, 17 Dec 2002 09:10:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.52-mm1 kernel BUG at mm/page_walk.c:430!
References: <3DFD908D.14D7F6E7@digeo.com> <3DFEDE0B.E0F692A4@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Dec 2002 17:11:21.0565 (UTC) FILETIME=[524278D0:01C2A5EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> X suddenly died, and was restarted.  I found this in dmesg:
> 
> kernel BUG at mm/page_walk.c:430!
> invalid operand: 0000
> CPU:    0
> EIP:    0060:[<c013beeb>]    Not tainted
> EFLAGS: 00013246
> EIP is at make_pages_present+0x77/0xbc
> eax: d0efa344   ebx: 6b6b6b6b   ecx: 000000a0   edx: c1604954
> esi: 6b6b6b6b   edi: 00009000   ebp: d0efa344   esp: de555ef8
> ds: 0068   es: 0068   ss: 0068
> Process XFree86 (pid: 246, threadinfo=de554000 task=dfc00d80)
> Stack: 00000000 de9c35cc 00000001 d0efa344 6b6b6b6b d0efa344 de555f00
> dfc00d80
>        c1604954 00009000 c013be64 00000000 c0136d78 6b6b6b6b 6b6b6b6b
> d0efa344
>        de554000 000a0000 00009000 d0efa344 00000000 d0efa344 c1604954
> d0efa344
> Call Trace:
>  [<c013be64>] gup_mk_present+0x0/0x10
>  [<c0136d78>] move_vma+0x3d4/0x404
>  [<c01370c8>] do_mremap+0x320/0x34c
>  [<c0137142>] sys_mremap+0x4e/0x6f
>  [<c0108973>] syscall_call+0x7/0xb
> 

Seems to be just a bogus assertion.  A shrinking, relocating mremap
against a VMA which has !MREMAP_MAYMOVE will call make_pages_present()
for zero pages.

You can remove mm:page_walk.c:430.

Thanks.
