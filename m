Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTH2If6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTH2If6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:35:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64473 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264358AbTH2Ifz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:35:55 -0400
Date: Fri, 29 Aug 2003 10:35:56 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: rl@hellgate.ch
Subject: Re: [2.6] kernel BUG at arch/i386/mm/highmem.c:14!
Message-ID: <20030829083556.GB28216@suse.de>
References: <20030826173337.GA3993@k3.hellgate.ch> <20030826180146.GF862@suse.de> <20030826190252.GA3642@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826190252.GA3642@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26 2003, Roger Luethi wrote:
> On Tue, 26 Aug 2003 20:01:46 +0200, Jens Axboe wrote:
> > Possibly some artifact of using read/write multiple on IDE, does it work
> > if you disable that with -m0 on the device? I'm guessing the error is
> > 100% reproducible?
> 
> I'm guessing you're right (small sample size, though).
> 
> I made one (successful) attempt at reproducing the BUG (copy some 300 MB of
> data to a partition, then disable DMA on the target disk).
> 
> I made two further attempts but with all kernel output on the serial
> console, one with -m16 and one with -m0. Both resulted in a flood of "bad:
> scheduling while atomic!", but no BUG. The -m0 version looked like a flood
> in slow motion (line by line).
> 
> I suppose the first BUG had the scheduling messages, too, but I didn't see
> them because they had scrolled past by the time I got to the console. I did
> see those "bad: scheduling while atomic!" messages, tough, when I
> reproduced the BUG.

Strange, I cannot reproduce the problem here locally... A look over of
the code doesn't reveal any problems either. I'll keep it in mind,
though.

> 
> Call traces would look like this:
> ----------------------------------------------------------------------------
> hda: DMA disabled
> bad: scheduling while atomic!
> Call Trace:
>  [<c011ce00>] schedule+0x510/0x520
>  [<c022a820>] blk_run_queues+0x120/0x300
>  [<c0147e50>] find_get_page+0x70/0x140
>  [<c011ed6e>] io_schedule+0xe/0x20
>  [<c0171f7f>] __wait_on_buffer+0xcf/0xe0
>  [<c011fa80>] autoremove_wake_function+0x0/0x50
>  [<c011fa80>] autoremove_wake_function+0x0/0x50
>  [<c01de17a>] flush_commit_list+0x31a/0x440
>  [<c01e28fb>] do_journal_end+0x5fb/0xc00
>  [<c01e1b79>] flush_old_commits+0x139/0x1d0
>  [<c01cf940>] reiserfs_write_super+0x30/0x40
>  [<c01791bf>] sync_supers+0x1ef/0x280
>  [<c014e143>] wb_kupdate+0x63/0x160
>  [<c011cae2>] schedule+0x1f2/0x520
>  [<c014eb0c>] __pdflush+0x21c/0x5f0
>  [<c014eee0>] pdflush+0x0/0x20
>  [<c014eef1>] pdflush+0x11/0x20
>  [<c014e0e0>] wb_kupdate+0x0/0x160
>  [<c0107259>] kernel_thread_helper+0x5/0xc

These traces look suspicious. Are you using a standard kernel? What
options?

-- 
Jens Axboe

