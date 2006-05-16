Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWEPP0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWEPP0o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWEPP0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:26:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44293 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932103AbWEPP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:26:43 -0400
Date: Tue, 16 May 2006 17:26:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mark.fasheh@oracle.com,
       kurt.hackel@oracle.com
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [-mm patch] fs/ocfs2/dlm/: cleanups
Message-ID: <20060516152641.GA5677@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
>  git-ocfs2.patch
>...
>  git trees
>...


This patch #if 0's the no longer used dlm_dump_lock_resources().

Since this makes dlmdebug.h empty, this patch also removes this header.

Additionally, the needlessly global dlm_is_node_recovered() is made 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/dlm/dlmdebug.c    |    4 ++--
 fs/ocfs2/dlm/dlmdebug.h    |   30 ------------------------------
 fs/ocfs2/dlm/dlmdomain.c   |    1 -
 fs/ocfs2/dlm/dlmmaster.c   |    1 -
 fs/ocfs2/dlm/dlmrecovery.c |    2 +-
 5 files changed, 3 insertions(+), 35 deletions(-)

--- linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmdebug.h	2006-03-20 06:53:29.000000000 +0100
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,30 +0,0 @@
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
- * dlmdebug.h
- *
- * Copyright (C) 2004 Oracle.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
- *
- */
-
-#ifndef DLMDEBUG_H
-#define DLMDEBUG_H
-
-void dlm_dump_lock_resources(struct dlm_ctxt *dlm);
-
-#endif
--- linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmdebug.c.old	2006-05-16 13:16:46.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmdebug.c	2006-05-16 13:17:16.000000000 +0200
@@ -37,10 +37,8 @@
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
-#include "dlmdebug.h"
 
 #include "dlmdomain.h"
-#include "dlmdebug.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
 #include "cluster/masklog.h"
@@ -120,6 +118,7 @@
 }
 EXPORT_SYMBOL_GPL(dlm_print_one_lock);
 
+#if 0
 void dlm_dump_lock_resources(struct dlm_ctxt *dlm)
 {
 	struct dlm_lock_resource *res;
@@ -142,6 +141,7 @@
 	}
 	spin_unlock(&dlm->spinlock);
 }
+#endif  /*  0  */
 
 static const char *dlm_errnames[] = {
 	[DLM_NORMAL] =			"DLM_NORMAL",
--- linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmdomain.c.old	2006-05-16 13:17:25.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmdomain.c	2006-05-16 13:17:28.000000000 +0200
@@ -41,7 +41,6 @@
 #include "dlmapi.h"
 #include "dlmcommon.h"
 
-#include "dlmdebug.h"
 #include "dlmdomain.h"
 
 #include "dlmver.h"
--- linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmmaster.c.old	2006-05-16 13:17:36.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmmaster.c	2006-05-16 13:17:39.000000000 +0200
@@ -47,7 +47,6 @@
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
-#include "dlmdebug.h"
 #include "dlmdomain.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_MASTER)
--- linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmrecovery.c.old	2006-05-16 13:18:14.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/fs/ocfs2/dlm/dlmrecovery.c	2006-05-16 13:18:22.000000000 +0200
@@ -357,7 +357,7 @@
 
 /* returns true if node is no longer in the domain
  * could be dead or just not joined */
-int dlm_is_node_recovered(struct dlm_ctxt *dlm, u8 node)
+static int dlm_is_node_recovered(struct dlm_ctxt *dlm, u8 node)
 {
 	int recovered;
 	spin_lock(&dlm->spinlock);

