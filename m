Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUJPPYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUJPPYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUJPPYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:24:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60313 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268762AbUJPPYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:24:39 -0400
Date: Sat, 16 Oct 2004 17:24:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016152427.GA16334@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <200410161621.34657.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410161621.34657.dominik.karall@gmx.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Karall <dominik.karall@gmx.net> wrote:

> i'm not sure if this bug depends on preemption patch, or if it is a
> general one in -mm1 tree.
> 
> kernel BUG at fs/fat/cache.c:150!

> EIP is at fat_cache_add+0x135/0x151

> Process mplayer (pid: 9843, threadinfo=ce414000 task=c8128a20)

> Call Trace:
>  [<c01a11bb>] fat_get_cluster+0x11f/0x1de
>  [<c01a12c1>] fat_bmap_cluster+0x47/0x98
>  [<c01a13f1>] fat_bmap+0xdf/0x101
>  [<c01a36e8>] fat_get_block+0x30/0x198
>  [<c0152866>] alloc_buffer_head+0x33/0x52
>  [<c01501ea>] create_buffers+0x51/0x86
>  [<c015141c>] block_read_full_page+0x1bd/0x2cc
>  [<c01a36b8>] fat_get_block+0x0/0x198
>  [<c0132f0c>] add_to_page_cache+0x58/0x6e
>  [<c013a0e4>] read_pages+0xbe/0x15e
>  [<c013a49c>] do_page_cache_readahead+0x120/0x19b
>  [<c013a606>] page_cache_readahead+0xef/0x1f8
>  [<c01336ab>] do_generic_mapping_read+0x133/0x54b
>  [<c013c911>] lru_cache_add+0xd/0x4f
>  [<c0133d53>] __generic_file_aio_read+0x1a3/0x218
>  [<c0133ac3>] file_read_actor+0x0/0xed
>  [<c0133ec5>] generic_file_read+0x9c/0xba
>  [<c012b84c>] _mutex_lock+0x20/0x36
>  [<c01244c8>] do_sigaction+0x1dc/0x1f7
>  [<c012b468>] autoremove_wake_function+0x0/0x43
>  [<c012b84c>] _mutex_lock+0x20/0x36
>  [<c0167974>] dnotify_parent+0x35/0x95
>  [<c014e0a9>] vfs_read+0xcd/0x126
>  [<c014e36f>] sys_read+0x41/0x6a
>  [<c0103f7b>] syscall_call+0x7/0xb

indeed this does not seem to be related to the preemption patch. How
hard is it to reproduce this problem? If it's easy then please try with
vanilla 2.6.9-rc4-mm1 (and if it breaks too, with 2.6.9-rc4 as well), to
narrow down where the breakage got introduced.

	Ingo
