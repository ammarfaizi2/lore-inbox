Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbTE1FzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTE1FzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:55:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27530 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264538AbTE1FzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:55:14 -0400
Date: Wed, 28 May 2003 08:08:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at include/linux/blkdev (2.5.70)
Message-ID: <20030528060829.GG845@suse.de>
References: <200305272323.29063.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272323.29063.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27 2003, Ivan Gyurdiev wrote:
> Out of nowhere on mozilla open (after it worked fine all afternoon):
> 
> ------------[ cut here ]------------
> kernel BUG at include/linux/blkdev.h:408!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c02322be>]    Tainted: P  
> EFLAGS: 00010046
> EIP is at blk_queue_start_tag+0x8e/0x100
> eax: dfdfaf40   ebx: 00000000   ecx: c040176c   edx: dfdfc1a8
> esi: dfdfc1a8   edi: dff52240   ebp: dff52260   esp: cf275aa8
> ds: 007b   es: 007b   ss: 0068
> Process mozilla-bin (pid: 3073, threadinfo=cf274000 task=d7296cc0)
> Stack: da5a3880 000003e8 c04016c0 c040176c 00000286 00000001 dfdf0080 c040176c 
>        c0245baa c040177c dfdfc1a8 00e916ff c04016c0 c0246832 c040176c dfdfc1a8 
>        c01142d4 00000060 00000283 00000000 c01e92f2 000003e8 0023e546 000001f7 
> Call Trace:
>  [<c0245baa>] idedisk_start_tag+0x7a/0x90
>  [<c0246832>] __ide_do_rw_disk+0x722/0x770
>  [<c01142d4>] delay_tsc+0x14/0x40
>  [<c01e92f2>] __delay+0x12/0x20
>  [<c023afb4>] start_request+0x104/0x160
>  [<c023b28b>] ide_do_request+0x24b/0x430
>  [<c023b48d>] do_ide_request+0x1d/0x30

This bug doesn't look possible. Basically it's a trigger to sanity check
whether the request is already gone from the list or not, and there's no
way it can be gone from this path (IDE would never call
idedisk_start_tag() on a removed request).

So I suspect something else is wrong, and this was just the first to
trigger.

-- 
Jens Axboe

