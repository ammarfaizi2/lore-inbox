Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTBTTm1>; Thu, 20 Feb 2003 14:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTBTTm1>; Thu, 20 Feb 2003 14:42:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:15656 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S266888AbTBTTm0>; Thu, 20 Feb 2003 14:42:26 -0500
Date: Thu, 20 Feb 2003 19:54:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount versus iprune
In-Reply-To: <20030220104017.7f1981be.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302201925050.2226-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > When prune_icache coincides with unmounting, invalidate_inodes notices
> > the inode it's working on as busy but doesn't wait: Self-destruct in 5
> > seconds message, and later iput oopses on freed super_block.
> 
> Is 2.4 affected?

Good question.

I had thought obviously not, 2.4 prune_icache doesn't __iget and
drop inode_lock as 2.5 does (while invalidating buffers and pages).
Looks like 2.4 leaves that work to the subsequent dispose_list's
truncate_inode_pages.

But that raises the doubt: maybe 2.4 won't get any Self-destruct
message, but when prune_icache calls dispose_list calls clear_inode
and destroy_inode, there could be a reference to freed super_block?

Perhaps there's some other reason why not,
I'll check it out more carefully later.

Hugh

