Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUBRGAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 01:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUBRGAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 01:00:49 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:42505 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263787AbUBRGAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 01:00:46 -0500
Message-ID: <4032FF7D.55D9935B@SteelEye.com>
Date: Wed, 18 Feb 2004 01:00:29 -0500
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nbd oops on unload.
References: <20040217224700.GE6242@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> modprobe nbd ; rmmod nbd  was enough to reproduce this one..
> (2.6.3rc4)

hmmm...I'll look into it...out of curiosity, are you using any "unusual"
kernel config options? I've done the same test myself many times and
have not seen any problems...

--
Paul



>                 Dave
> 
> nbd: registered device at major 43
> Unable to handle kernel paging request at virtual address 6b6b6baf
>  printing eip:
> c01d3206
> *pde = 00000000
> Oops: 0000 [#2]
> CPU:    0
> EIP:    0060:[<c01d3206>]    Not tainted
> EFLAGS: 00010202
> EIP is at kobject_hotplug+0x24/0x30
> eax: c02e9ff3   ebx: c36530d4   ecx: c36530d4   edx: 6b6b6b6b
> esi: c1f4f190   edi: 00000000   ebp: 00000000   esp: c44c5f24
> ds: 007b   es: 007b   ss: 0068
> Process rmmod (pid: 7597, threadinfo=c44c4000 task=c40b4650)
> Stack: c01d3486 c36530d4 c01d349d c3653084 c0224536 c3653084 c02276d0 c1f4f190
>        c7c103dc c022857a c1f4f190 c0191001 c1f4f190 c7c12990 c7c0e4a4 c7c0fd80
>        00000000 c031acd8 c013a805 0064626e 00000000 c2cd62d8 c2cd62d8 b80d1000
> Call Trace:
>  [<c01d3486>] kobject_del+0xf/0x1e
>  [<c01d349d>] kobject_unregister+0x8/0x10
>  [<c0224536>] elv_unregister_queue+0xf/0x1d
>  [<c02276d0>] blk_unregister_queue+0x1b/0x36
>  [<c022857a>] unlink_gendisk+0x8/0x19
>  [<c0191001>] del_gendisk+0x45/0xc8
>  [<c7c0e4a4>] nbd_cleanup+0x26/0x55 [nbd]
>  [<c013a805>] sys_delete_module+0x168/0x18a
>  [<c014ff4d>] unmap_vma_list+0xe/0x17
>  [<c01503f9>] do_munmap+0x17d/0x189
>  [<c010b697>] syscall_call+0x7/0xb
> 
> Code: 83 7a 44 00 74 05 e9 9f fd ff ff c3 53 31 d2 89 c3 c7 40 18
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
