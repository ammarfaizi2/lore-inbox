Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVATCCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVATCCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVATCCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:02:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:15748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261810AbVATB7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:59:49 -0500
Date: Wed, 19 Jan 2005 17:59:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] mips default mlock limit fix
Message-ID: <20050119175945.K469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mips RLIMIT_MEMLOCK incorrectly defaults to unlimited, it was confused
with RLIMIT_NPROC.  Found while consolidating resource.h headers.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== include/asm-mips/resource.h 1.6 vs edited =====
--- 1.6/include/asm-mips/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-mips/resource.h	2005-01-19 17:34:25 -08:00
@@ -53,8 +53,8 @@
 	{ INR_OPEN,      INR_OPEN      },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MLOCK_LIMIT,     MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ 0,             0             },		\
+	{ MLOCK_LIMIT,   MLOCK_LIMIT   },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
 	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
