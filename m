Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbSJPSUi>; Wed, 16 Oct 2002 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbSJPSUh>; Wed, 16 Oct 2002 14:20:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262597AbSJPSUh>;
	Wed, 16 Oct 2002 14:20:37 -0400
Date: Wed, 16 Oct 2002 19:26:30 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: [PATCH] shmem missing cache flush
Message-ID: <20021016192630.L15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Really, this should be a clear_user_page(), but we can't reasonable get
a user address all the way down to it, so let's just flush it instead.
Note that 2.4 needs an equivalent fix.

diff -urpNX build-tools/dontdiff linus-2.5/mm/shmem.c parisc-2.5/mm/shmem.c
--- linus-2.5/mm/shmem.c	Tue Oct  8 10:54:20 2002
+++ parisc-2.5/mm/shmem.c	Tue Oct  8 16:49:24 2002
@@ -848,6 +848,7 @@ repeat:
 		info->alloced++;
 		spin_unlock(&info->lock);
 		clear_highpage(page);
+		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
 

-- 
Revolutions do not require corporate support.
