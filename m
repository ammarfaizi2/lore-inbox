Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRCEXYU>; Mon, 5 Mar 2001 18:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRCEXYL>; Mon, 5 Mar 2001 18:24:11 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:61756 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130766AbRCEXX7>; Mon, 5 Mar 2001 18:23:59 -0500
Message-ID: <3AA41FE0.E7681291@sgi.com>
Date: Mon, 05 Mar 2001 15:23:12 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ramfs & a_ops->truncatepage()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking at this part of 2.4.2-ac8:

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.4.0/mm/filemap.c
linux.ac/mm/filemap.c
--- linux-2.4.0/mm/filemap.c    Wed Jan  3 02:59:45 2001
+++ linux.ac/mm/filemap.c       Thu Jan 11 17:26:55 2001
@@ -206,6 +206,9 @@
        if (!page->buffers || block_flushpage(page, 0))
                lru_cache_del(page);

+       if (page->mapping->a_ops->truncatepage)
+               page->mapping->a_ops->truncatepage(page);
+
        /*
         * We remove the page from the page cache _after_ we have
         * destroyed all buffer-cache references to it. Otherwise some
----------

Does anyone know who proposed these changes as part of
ramfs enhancements? Basically, we have a very similar
operation in XFS, but would like the call to truncatepage
be _before_ the call to block_flushpage(). As far as ramfs
is concerned, such a change would be a no-op since ramfs doesn't
have page->buffers. Is this correct?

thanks,

ananth.

--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
