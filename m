Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTBESHn>; Wed, 5 Feb 2003 13:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTBESHn>; Wed, 5 Feb 2003 13:07:43 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:15299 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262812AbTBESHl>;
	Wed, 5 Feb 2003 13:07:41 -0500
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
From: Steve Lord <lord@sgi.com>
To: Andy Chou <acc@cs.stanford.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mc@cs.stanford.edu
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044469000.18872.27.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 12:16:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BUG] Only possible if the argument len == 0.
/u1/acc/linux/2.5.48/fs/xfs/pagebuf/page_buf.c:966:pagebuf_get_no_daddr: ERROR:LEAK:966:966:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/pagebuf/page_buf.c:966:kmalloc]

This function is never called with len == 0

[BUG] Not sure.  Code path is complicated.
/u1/acc/linux/2.5.48/fs/xfs/xfs_da_btree.c:2221:xfs_da_do_buf: ERROR:LEAK:2179:2221:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/xfs_da_btree.c:2179:xfs_da_buf_make]

The code makes me shudder, but there is no leak in here, I chased it
around and all the callers use the right set of arguments to not leak.

[BUG]
/u1/acc/linux/2.5.48/fs/xfs/xfs_dir_leaf.c:651:xfs_dir_leaf_to_shortform: ERROR:LEAK:645:651:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/xfs_dir_leaf.c:645:kmem_alloc]

yep, that's a bug, only happens in forced shutdown of the filesystem.

[BUG]
/u1/acc/linux/2.5.48/fs/xfs/xfs_log_recover.c:1304:xlog_recover_add_to_trans: ERROR:LEAK:1294:1304:Memory leak [Allocated from: /u1/acc/linux/2.5.48/fs/xfs/xfs_log_recover.c:1294:kmem_zalloc]

Also a bug, and we don't need to zero the memory either. 

Fixes for the last two will be in the pipeline with other xfs fixes to
Linus.

Thanks

  Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
