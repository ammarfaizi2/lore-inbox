Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbTH2QXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbTH2QXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:23:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:12173 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261410AbTH2QXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:23:36 -0400
Date: Fri, 29 Aug 2003 09:07:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, rl@hellgate.ch,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6] kernel BUG at arch/i386/mm/highmem.c:14!
Message-Id: <20030829090727.10ea0099.akpm@osdl.org>
In-Reply-To: <20030829083556.GB28216@suse.de>
References: <20030826173337.GA3993@k3.hellgate.ch>
	<20030826180146.GF862@suse.de>
	<20030826190252.GA3642@k3.hellgate.ch>
	<20030829083556.GB28216@suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > ----------------------------------------------------------------------------
> > hda: DMA disabled
> > bad: scheduling while atomic!
> > Call Trace:
> >  [<c011ce00>] schedule+0x510/0x520
> >  [<c022a820>] blk_run_queues+0x120/0x300
> >  [<c0147e50>] find_get_page+0x70/0x140
> >  [<c011ed6e>] io_schedule+0xe/0x20
> >  [<c0171f7f>] __wait_on_buffer+0xcf/0xe0
> >  [<c011fa80>] autoremove_wake_function+0x0/0x50
> >  [<c011fa80>] autoremove_wake_function+0x0/0x50
> >  [<c01de17a>] flush_commit_list+0x31a/0x440
> >  [<c01e28fb>] do_journal_end+0x5fb/0xc00
> >  [<c01e1b79>] flush_old_commits+0x139/0x1d0
> >  [<c01cf940>] reiserfs_write_super+0x30/0x40
> >  [<c01791bf>] sync_supers+0x1ef/0x280
> >  [<c014e143>] wb_kupdate+0x63/0x160
> >  [<c011cae2>] schedule+0x1f2/0x520
> >  [<c014eb0c>] __pdflush+0x21c/0x5f0
> >  [<c014eee0>] pdflush+0x0/0x20
> >  [<c014eef1>] pdflush+0x11/0x20
> >  [<c014e0e0>] wb_kupdate+0x0/0x160
> >  [<c0107259>] kernel_thread_helper+0x5/0xc
> 
> These traces look suspicious. Are you using a standard kernel? What
> options?

This trace has been reported several times, and it always correlates with
an IDE error message of some form.

I'm suspecting that something in the IDE error handling path either forgets
to undo a spinlock or leaves interrupts disabled.


