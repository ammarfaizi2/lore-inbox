Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271744AbTHMKrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTHMKrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:47:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:40332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271744AbTHMKrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:47:37 -0400
Date: Wed, 13 Aug 2003 03:48:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm2
Message-Id: <20030813034806.04648085.akpm@osdl.org>
In-Reply-To: <20030813172221.3eecc258.hugang@soulinfo.com>
References: <20030813013156.49200358.akpm@osdl.org>
	<20030813172221.3eecc258.hugang@soulinfo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugang <hugang@soulinfo.com> wrote:
>
> On Wed, 13 Aug 2003 01:31:56 -0700
>  Andrew Morton <akpm@osdl.org> wrote:
> 
>  >  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm2/
>  > 
> 
>  2.6.0-test3-mm2 can not boot, It oops in fsck. See attached file.


It's a bogus BUG_ON.  It can be removed.


diff -puN mm/filemap.c~aio-O_SYNC-fix-fix mm/filemap.c
--- 25/mm/filemap.c~aio-O_SYNC-fix-fix	2003-08-13 03:46:59.000000000 -0700
+++ 25-akpm/mm/filemap.c	2003-08-13 03:47:06.000000000 -0700
@@ -1927,8 +1927,6 @@ generic_file_aio_write_nolock(struct kio
 	ssize_t ret;
 	loff_t pos = *ppos;
 
-	BUG_ON(iocb->ki_pos != *ppos);
-
 	if (!iov->iov_base && !is_sync_kiocb(iocb)) {
 		/* nothing to transfer, may just need to sync data */
 		ret = iov->iov_len; /* vector AIO not supported yet */

_

