Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUIIX3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUIIX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUIIX3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:29:15 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:59897 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266463AbUIIX15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:27:57 -0400
Date: Thu, 9 Sep 2004 16:27:43 -0700
From: Chris Wedgwood <cw@f00f.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Nathan Scott <nathans@sgi.com>
Subject: [PATCH 3/3] Disable XFS when using 4K stacks
Message-ID: <20040909232743.GC13572@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFS isn't (presently) completely reliable with 4K stacks.  This patch
disables it in those circumstances.  This depends upon previous posted
patches.

Signed-off-by: Chris Wedgwood <cw@f00f.org>



diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2004-09-09 16:05:52 -07:00
+++ b/fs/Kconfig	2004-09-09 16:05:52 -07:00
@@ -294,6 +294,7 @@
 
 config XFS_FS
 	tristate "XFS filesystem support"
+	depends on !I386_4KSTACKS
 	help
 	  XFS is a high performance journaling filesystem which originated
 	  on the SGI IRIX platform.  It is completely multi-threaded, can

