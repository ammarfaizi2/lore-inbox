Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263207AbUD2EEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUD2EEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUD2EEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:04:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:51685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263335AbUD2ECe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:02:34 -0400
Date: Wed, 28 Apr 2004 21:02:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428210214.31efe911.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
	<20040428124809.418e005d.akpm@osdl.org>
	<Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
	<20040428182443.6747e34b.akpm@osdl.org>
	<Pine.LNX.4.58.0404282244280.13311@ozma.hauschen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook <busterbcook@yahoo.com> wrote:
>
> sync_sb_inodes: write inode c55d25bc
>  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
>  pages_skipped:0 en:0
>  __sync_single_inode: writepages in nr_pages:25 nr_to_write:949
>  pages_skipped:0 en:0

uh-huh.

Does this fix it?

 25-akpm/fs/fs-writeback.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/fs-writeback.c~a fs/fs-writeback.c
--- 25/fs/fs-writeback.c~a	2004-04-28 21:01:37.012603336 -0700
+++ 25-akpm/fs/fs-writeback.c	2004-04-28 21:02:00.701002152 -0700
@@ -191,8 +191,8 @@ __sync_single_inode(struct inode *inode,
 				 */
 				inode->i_state |= I_DIRTY_PAGES;
 				inode->dirtied_when = jiffies;
-				list_move(&inode->i_list, &sb->s_dirty);
 			}
+			list_move(&inode->i_list, &sb->s_dirty);
 		} else if (inode->i_state & I_DIRTY) {
 			/*
 			 * Someone redirtied the inode while were writing back

_

