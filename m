Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTGMQor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270289AbTGMQor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:44:47 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:18438 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270283AbTGMQon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:44:43 -0400
Date: Sun, 13 Jul 2003 12:58:47 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Paul Rolland <rol@as2917.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.75] Oops at boot : kobject_get from nbd_init
In-Reply-To: <010a01c3493d$ebec23e0$2101a8c0@witbe>
Message-ID: <Pine.LNX.4.10.10307131253280.764-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Paul Rolland wrote:

> Hello,
> 
> I've the following when booting a vanilla 2.5.75, no module configured,
> just plain stock kernel.
> 
> EIP:    0060:[<c0256509>]    Not tainted
> EFLAGS: 00010206
> EIP is at kobject_get+0xf/0x4e
> eax: 33cc33d4   ebx: 33cc33d4   ecx: c04725cd   edx: c049a8bc
> esi: dfd8fd3c   edi: dfd8fd3c   ebp: 00000440   esp: dff8df3c
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=dff8c000 task=dff8f880)
> Stack: dfd90bfc dfd90bfc dfd90bfc ffffffff dfd8fd3c c0256227 33cc33d4 dfd8fc00 
>        c02563dd dfd8fd3c dfd8fd3c 00000014 dfd8fc00 c05ee1e8 c02c7e5f dfd8fd3c 
>        00000014 c049a8ba c04725c8 dfd90b80 c05ee1e8 00000010 c0580430 dfd90b80 
> Call Trace:
>  [<c0256227>] kobject_init+0x2d/0x48
>  [<c02563dd>] kobject_register+0x1b/0x5a
>  [<c02c7e5f>] blk_register_queue+0x83/0xa8
>  [<c0580430>] nbd_init+0x154/0x1ac
>  [<c02c8cd8>] exact_match+0x0/0x8
>  [<c056871b>] do_initcalls+0x27/0x94
>  [<c012c689>] init_workqueues+0xf/0x26
>  [<c010509a>] init+0x36/0x194
>  [<c0105064>] init+0x0/0x194
>  [<c0108a09>] kernel_thread_helper+0x5/0xc

This has been patched in Andrew Morton's -mm tree. I think the fix is on the way
to Linus. In the meantime, I guess you can either configure nbd out if you don't
need it, or you can get the patch from kernel.org:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm3/broken-out/nbd-kobject-oops-fix.patch

--
Paul

