Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbTHZPH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTHZPG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:06:28 -0400
Received: from mail3-126.ewetel.de ([212.6.122.126]:8137 "EHLO mail3.ewetel.de")
	by vger.kernel.org with ESMTP id S262951AbTHZPE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:04:59 -0400
Date: Tue, 26 Aug 2003 17:04:22 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <sct@redhat.com>, <akpm@osdl.org>
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164 
In-Reply-To: <Pine.LNX.4.44.0308260832180.3191@logos.cnet>
Message-ID: <Pine.LNX.4.44.0308261659340.4274-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Marcelo Tosatti wrote:

> I've never seen this oops reported before.
> Can you reproduce the problem?

Yes. Running fsx directly on my ext3 /home partition gets me the
BUG within a few seconds, with the exact same backtrace as below.
There don't seem to be any jbd changes from -rc1 to final 2.4.22,
so I assume the problem exists in 2.4.22 as well.

Box survives a night of memtest86, so I figure it's not a memory
problem.

> > Assertion failure in journal_dirty_metadata() at transaction.c:1164:
> > "jh->b_frozen_data == 0"
> > kernel BUG at transaction.c:1164!

> > >>EIP; c015dcc7 <journal_dirty_metadata+167/1a0>   <=====
> > Trace; c015581a <commit_write_fn+1a/60>
> > Trace; c01637f7 <__jbd_kmalloc+27/a0>
> > Trace; c015557d <walk_page_buffers+5d/80>
> > Trace; c0155906 <ext3_commit_write+a6/1c0>
> > Trace; c0155800 <commit_write_fn+0/60>
> > Trace; c01276cd <do_generic_file_write+29d/3e0>
> > Trace; c0127ad0 <generic_file_write+f0/110>
> > Trace; c01531ff <ext3_file_write+1f/b0>
> > Trace; c0132245 <sys_write+95/f0>
> > Trace; c0131e20 <generic_file_llseek+0/b0>
> > Trace; c0131fce <sys_lseek+6e/80>
> > Trace; c01088a3 <system_call+33/38>

-- 
Ciao,
Pascal

