Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSKUWYO>; Thu, 21 Nov 2002 17:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbSKUWYO>; Thu, 21 Nov 2002 17:24:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12416 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264983AbSKUWYL>;
	Thu, 21 Nov 2002 17:24:11 -0500
Date: Thu, 21 Nov 2002 14:31:18 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Use min_t() instead of min() in fs/xfs/support/qsort.c
Message-ID: <20021121223118.GD1431@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change removes a "duplicate 'const'" compiler warning.

diff -Nru a/fs/xfs/support/qsort.c b/fs/xfs/support/qsort.c
--- a/fs/xfs/support/qsort.c	Thu Nov 21 13:51:26 2002
+++ b/fs/xfs/support/qsort.c	Thu Nov 21 13:51:26 2002
@@ -199,7 +199,7 @@
   {
     char *const end_ptr = &base_ptr[size * (total_elems - 1)];
     char *tmp_ptr = base_ptr;
-    char *thresh = min(end_ptr, base_ptr + max_thresh);
+    char *thresh = min_t(const int, end_ptr, base_ptr + max_thresh);
     register char *run_ptr;
 
     /* Find smallest element in first threshold and place it at the
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
