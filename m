Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUFBWDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUFBWDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbUFBWDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:03:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:40680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264244AbUFBWDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:03:33 -0400
Date: Wed, 2 Jun 2004 15:06:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3_orphan_del may double-decrement bh->b_count
Message-Id: <20040602150614.005e939f.akpm@osdl.org>
In-Reply-To: <40BE3235.5060906@suse.com>
References: <40BE3235.5060906@suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney <jeffm@suse.com> wrote:
>
> Chris Mason and I ran across this one while hunting down another bug.

Thanks.  Can be simplified ;)

--- 25/fs/ext3/namei.c~ext3_orphan_del-may-double-decrement-bh-b_count	Wed Jun  2 15:03:43 2004
+++ 25-akpm/fs/ext3/namei.c	Wed Jun  2 15:05:24 2004
@@ -1971,8 +1971,6 @@ int ext3_orphan_del(handle_t *handle, st
 		goto out_brelse;
 	NEXT_ORPHAN(inode) = 0;
 	err = ext3_mark_iloc_dirty(handle, inode, &iloc);
-	if (err)
-		goto out_brelse;
 
 out_err:
 	ext3_std_error(inode->i_sb, err);
_

What was the "other bug"?
