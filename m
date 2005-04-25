Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVDYCba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVDYCba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVDYCba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:31:30 -0400
Received: from vanguard.topspin.com ([12.162.17.52]:4903 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S262461AbVDYCbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:31:19 -0400
To: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix include order in mthca_memfree.c
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Sun, 24 Apr 2005 19:31:18 -0700
Message-ID: <52vf6bwps9.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Apr 2005 02:31:18.0385 (UTC) FILETIME=[DC5D9E10:01C5493E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About commit fdca124a1bcc7e624f6b887c6f26153f40ee43ee ("missing
include in mthca"):

 - Out of curiousity, what arch and/or config requires <linux/mm.h>?
   I regularly cross-compile drivers/infiniband for i386, x86_64, ppc64,
   ia64, sparc64 and ppc, and I haven't needed <linux/mm.h> in mthca_memfree.c.

 - When making changes to drivers/infiniband, can you please cc the
   maintainers or at least a public mailing list?  As far as I can
   tell, the patch went directly to Linus with no public review, which
   doesn't seem appropriate, no matter how trivial the change.

 - When adding includes, please match the existing style and put
   <linux/xxx.h> includes before any local "yyy.h" includes.

Linus, please apply the patch below to move the include where it belongs.

Thanks,
  Roland


Fix order of #include lines in mthca_memfree.c

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux.orig/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-24 19:18:29.000000000 -0700
+++ linux/drivers/infiniband/hw/mthca/mthca_memfree.c	2005-04-24 19:20:10.000000000 -0700
@@ -32,10 +32,11 @@
  * $Id$
  */
 
+#include <linux/mm.h>
+
 #include "mthca_memfree.h"
 #include "mthca_dev.h"
 #include "mthca_cmd.h"
-#include <linux/mm.h>
 
 /*
  * We allocate in as big chunks as we can, up to a maximum of 256 KB
