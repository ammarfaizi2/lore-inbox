Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVA0Pxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVA0Pxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVA0Pxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:53:48 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:16595 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262648AbVA0Pxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:53:47 -0500
Date: Thu, 27 Jan 2005 07:53:38 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Steve Lord <lord@xfs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
Message-ID: <20050127155338.GB12493@taniwha.stupidest.org>
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org> <20050127154017.GA12493@taniwha.stupidest.org> <41F9290E.1050209@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F9290E.1050209@tiscali.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 05:46:54PM +0000, Matthias-Christian Ott wrote:

> How did you fix it?

I suggested:

===== fs/xfs/linux-2.6/xfs_stats.h 1.9 vs edited =====
Index: cw-current/fs/xfs/linux-2.6/xfs_stats.h
===================================================================
--- cw-current.orig/fs/xfs/linux-2.6/xfs_stats.h	2005-01-17 16:03:59.656946818 -0800
+++ cw-current/fs/xfs/linux-2.6/xfs_stats.h	2005-01-17 16:06:50.692361597 -0800
@@ -142,9 +142,9 @@
 
 /* We don't disable preempt, not too worried about poking the
  * wrong cpu's stat for now */
-#define XFS_STATS_INC(count)		(__get_cpu_var(xfsstats).count++)
-#define XFS_STATS_DEC(count)		(__get_cpu_var(xfsstats).count--)
-#define XFS_STATS_ADD(count, inc)	(__get_cpu_var(xfsstats).count += (inc))
+#define XFS_STATS_INC(count)		(per_cpu(xfsstats, __smp_processor_id()).count++)
+#define XFS_STATS_DEC(count)		(per_cpu(xfsstats, __smp_processor_id()).count--)
+#define XFS_STATS_ADD(count, inc)	(per_cpu(xfsstats, __smp_processor_id()).count += (inc))
 
 extern void xfs_init_procfs(void);
 extern void xfs_cleanup_procfs(void);

but what was checked in was a bit cleaner.
