Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269555AbTGJSjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269560AbTGJSjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:39:36 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:23303 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269555AbTGJSj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:39:29 -0400
Date: Thu, 10 Jul 2003 14:53:35 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Dave Jones <davej@codemonkey.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NBD oops in 2.5-bk.
In-Reply-To: <20030710172052.GA32479@suse.de>
Message-ID: <Pine.LNX.4.10.10307101450510.764-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Dave Jones wrote:

> Current bitkeeper tree seems to have problems with NBD.
> As soon as I modprobe nbd (or boot with it compiled in)
> I get this..
> 
> nbd: registered device at major 43
> Unable to handle kernel paging request at virtual address 5a5a5a7e
>  printing eip:
> c027864b
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c027864b>]    Not tainted
> EFLAGS: 00010206
> EIP is at kobject_get+0xb/0x50
> eax: 5a5a5a6a   ebx: 5a5a5a6a   ecx: c0492e7f   edx: 00000000
> esi: ffffffea   edi: c60b91a0   ebp: c4f01f14   esp: c4f01f10
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1141, threadinfo=c4f00000 task=c6524000)
> Stack: c60b91a0 c4f01f24 c0278319 5a5a5a6a c60b91a0 c4f01f38 c0278537 c60b91a0 
>        c77f8004 c60b9004 c4f01f60 c03063e6 c60b91a0 c60b91a0 00000014 c0492e7d 
>        c046f3c6 c77f8004 d087bf60 00000001 c4f01fa8 d08151d9 c77f8004 d087bf40 
> Call Trace:
>  [<c0278319>] kobject_init+0x29/0x50
>  [<c0278537>] kobject_register+0x17/0x50
>  [<c03063e6>] blk_register_queue+0x56/0x90
>  [<d08151d9>] nbd_init+0x1d9/0x250 [nbd]
>  [<c0144f5c>] sys_init_module+0x1cc/0x370
>  [<c010a027>] syscall_call+0x7/0xb
> 
> Code: 8b 43 14 85 c0 74 0c ff 43 14 89 d8 8b 5d fc 89 ec 5d c3 68 

2.5.74-mm does not have this problem, could you try the following patch from Andrew's tree?

nbd-kobject-oops-fix.patch

That should fix the problem. I guess we need to push to Linus?

--
Paul

