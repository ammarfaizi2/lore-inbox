Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVI3Cgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVI3Cgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVI3Cgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:36:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42468 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932419AbVI3Cgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:36:51 -0400
Date: Fri, 30 Sep 2005 03:36:50 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] bogus BUILD_BUG_ON() in bpa_iommu
Message-ID: <20050930023650.GC7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	BUILD_BUG_ON(1) is asking for trouble (and getting it) when used
in that manner - dead code elimination happens after we parse it and
invalid type is invalid type, dead code or not.
	It might be version-dependent, but at least 4.0.1 refuses to
accept that.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/arch/ppc64/kernel/bpa_iommu.c current/arch/ppc64/kernel/bpa_iommu.c
--- RC14-rc2-git6-base/arch/ppc64/kernel/bpa_iommu.c	2005-09-26 00:02:29.000000000 -0400
+++ current/arch/ppc64/kernel/bpa_iommu.c	2005-09-15 14:22:33.000000000 -0400
@@ -99,7 +99,11 @@
 		break;
 
 	default: /* not a known compile time constant */
-		BUILD_BUG_ON(1);
+		{
+			/* BUILD_BUG_ON() is not usable here */
+			extern void __get_iost_entry_bad_page_size(void);
+			__get_iost_entry_bad_page_size();
+		}
 		break;
 	}
 
