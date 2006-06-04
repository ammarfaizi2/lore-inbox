Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932169AbWFDUeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWFDUeE (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWFDUeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:34:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932169AbWFDUeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:34:01 -0400
Date: Sun, 4 Jun 2006 13:33:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Message-Id: <20060604133326.f1b01cfc.akpm@osdl.org>
In-Reply-To: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 05:04:29 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> [ 1637.890434]
> [ 1637.890440] ======================================
> [ 1637.890641] [ BUG: bad unlock ordering detected! ]
> [ 1637.890741] --------------------------------------
> [ 1637.890841] mv/935 is trying to release lock (&mgr->tmgr_lock) at:
> [ 1637.890996]  [<e098e01b>] try_capture+0x306/0x9b1 [reiser4]
> [ 1637.891255] but the next lock to release is:
> [ 1637.891344]  (&atom->alock){--..}, at: [<e098dfe2>]
> try_capture+0x2cd/0x9b1 [reiser4]
> [ 1637.891667]
> [ 1637.891670] other info that might help us debug this:
> [ 1637.891854] 3 locks held by mv/935:
> [ 1637.891951]  #0:  (&inode->i_mutex/1){--..}, at: [<c0160325>]
> lock_rename+0xba/0xc1
> [ 1637.892297]  #1:  (&mgr->tmgr_lock){--..}, at: [<e098deb5>]
> try_capture+0x1a0/0x9b1 [reiser4]
> [ 1637.892647]  #2:  (&txnh->hlock){--..}, at: [<e098debd>]
> try_capture+0x1a8/0x9b1 [reiser4]
> [ 1637.892994]
> [ 1637.892996] stack backtrace:
> [ 1637.893577]  [<c010311a>] show_trace_log_lvl+0x54/0xfd
> [ 1637.893738]  [<c0103709>] show_trace+0xd/0x10
> [ 1637.893893]  [<c0103750>] dump_stack+0x19/0x1b
> [ 1637.894045]  [<c012d713>] lockdep_release+0x18b/0x350
> [ 1637.894407]  [<c02880d9>] _spin_unlock+0x16/0x1f
> [ 1637.894777]  [<e098e01b>] try_capture+0x306/0x9b1 [reiser4]
> [ 1637.895048]  [<e0988a80>] longterm_lock_znode+0x2e3/0x3e3 [reiser4]
> [ 1637.895254]  [<e0995790>] coord_by_handle+0x136/0xaf4 [reiser4]
> [ 1637.895515]  [<e09962de>] object_lookup+0x8e/0x96 [reiser4]
> [ 1637.895764]  [<e09a9ece>] find_entry+0xbb/0x200 [reiser4]
> [ 1637.896134]  [<e099fab1>] rename_common+0x96b/0x9b6 [reiser4]
> [ 1637.896440]  [<c0160e96>] vfs_rename+0x1dd/0x315
> [ 1637.897098]  [<c0162b84>] sys_renameat+0x1bb/0x22a
> [ 1637.897664]  [<c0162c05>] sys_rename+0x12/0x14
> [ 1637.898220]  [<c0288283>] syscall_call+0x7/0xb

Why does the locking validator complain about unlocking ordering?
