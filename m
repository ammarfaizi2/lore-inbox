Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbULPBkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbULPBkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbULPBhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:37:17 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:55103 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262620AbULPBf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:35:57 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Wed, 15 Dec 2004 17:34:35 -0800
Message-ID: <52pt1bt49g.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH] Fix x86_64 put_user() sparse warnings
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 16 Dec 2004 01:34:36.0315 (UTC) FILETIME=[66DF6EB0:01C4E30F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may not be 2.6.10 material -- if not please queue for 2.6.11.

Thanks,
  Roland


Fix sparse warnings

    warning: cast removes address space of expression

for uses of put_user() on x86_64 caused by doing __m(addr) in
__put_user_asm() with addr a __user pointer.

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-bk/include/asm-x86_64/uaccess.h
===================================================================
--- linux-bk.orig/include/asm-x86_64/uaccess.h	2004-12-11 15:16:44.000000000 -0800
+++ linux-bk/include/asm-x86_64/uaccess.h	2004-12-15 15:35:47.482091664 -0800
@@ -172,7 +172,7 @@
 
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
-#define __m(x) (*(struct __large_struct *)(x))
+#define __m(x) (*(struct __large_struct __user *)(x))
 
 /*
  * Tell gcc we read from memory instead of writing: this is because
