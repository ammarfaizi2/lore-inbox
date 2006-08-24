Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWHXUP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWHXUP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWHXUP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:15:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64684 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751694AbWHXUP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:15:56 -0400
Date: Thu, 24 Aug 2006 13:15:44 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: fs cache patch breaks sparc build in 2.6.18-rc4-mm2
Message-Id: <20060824131544.aa9223f0.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6.18-rc4-mm2 patch:
    fs-cache-make-kafs-use-fs-cache.patch

seems to break the arch=sparc defconfig build, failing with:

  CC [M]  fs/afs/file.o
fs/afs/file.c: In function `afs_file_releasepage':
fs/afs/file.c:332: error: structure has no member named `cache'
make[2]: *** [fs/afs/file.o] Error 1

Looking at line numbers 326-337 in the file fs/afs/file.c, I see:

326             /* deny */
327             if (PageFsMisc(page)) {
328                     _leave(" = F");
329                     return 0;
330             }
331
332             fscache_uncache_page(AFS_FS_I(page->mapping->host)->cache, page);
333
334             /* indicate that the page can be released */
335             _leave(" = T");
336             return 1;
337     }

So this does seem to be the line 332 the compile is complaining about.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
